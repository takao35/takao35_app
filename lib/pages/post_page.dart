import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // MapControllerを使うために残す
import 'package:latlong2/latlong.dart';
import '../widgets/map_widget.dart'; // 新しく作った共通ウィジェットをインポート

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: const Text('高尾山 投稿')),
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.33,
            child: CommonMapWidget(
              // ここをCommonMapWidgetに置き換え
              mapController: _mapController,
              initialCenter: LatLng(35.625, 139.243),
              initialZoom: 13.0,
              children: [
                OpenStreetMapTileLayer(), // OpenStreetMapのタイルレイヤーを使用
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
