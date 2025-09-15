import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // MapControllerを使うために残す
import 'package:latlong2/latlong.dart';
import '../widgets/map_widget.dart'; // 新しく作った共通ウィジェットをインポート
import '../config/routes.dart'; // ルート情報を取得するための設定ファイル
import '../utilities/gpx_loader.dart'; // GPXファイルの読み込みユーティリティ

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final MapController _mapController = MapController();
  final List<Polyline> _polylines = [];

  @override
  void initState() {
    super.initState();
    _loadRoutes();
  }

  Future<void> _loadRoutes() async {
    for (final route in routeList) {
      final points = await loadGpxRoute(route.path);
      if (mounted) {
        // ウィジェットがまだマウントされているか確認
        setState(() {
          _polylines.add(
            Polyline(
              points: points,
              strokeWidth: 2.0,
              color: route.color.withValues(alpha: 0.5),
            ),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // appBar: AppBar(title: const Text('高尾山 投稿')),
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.25,
            child: CommonMapWidget(
              // ここをCommonMapWidgetに置き換え
              mapController: _mapController,
              initialCenter: LatLng(35.625, 139.245),
              initialZoom: 13.0,
              children: [
                OpenStreetMapTileLayer(), // OpenStreetMapのタイルレイヤーを使用
                PolylineLayer(polylines: _polylines),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              color: Colors.grey[100],
              child: const Text('ここに投稿欄が入ります'),
            ),
          ),
        ],
      ),
    );
  }
}
