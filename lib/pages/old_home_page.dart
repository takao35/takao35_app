import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../utilities/gpx_loader.dart';
import '../widgets/map_widget.dart'; // 共通地図ウィジェットをインポート
import '../config/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final MapController _mapController = MapController();
  final List<Polyline> _polylines = [];

  @override
  void initState() {
    super.initState();
    _loadRoutes();
  }

  Future<void> _loadRoutes() async {
    for (final route in routeList) {
      final points = await loadGpxRoute(route.path);
      setState(() {
        _polylines.add(
          Polyline(
            points: points,
            strokeWidth: 2.0,
            color: route.color.withOpacity(0.5), // ← 色付きで半透明
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 上部バー（メニュー＋タイトル）
          SizedBox(
            height: 56,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    '高尾山GO！',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      print('メニュー開く');
                    },
                  ),
                ),
              ],
            ),
          ),

          // 地図エリア（上1/3）
          Flexible(
            flex: 1,
            child: CommonMapWidget(
              // ここをCommonMapWidgetに置き換え
              // mapController: _mapController,
              initialCenter: LatLng(35.625, 139.243),
              initialZoom: 13.0,
              children: [
                GsiTileLayer(), // 国土地理院のタイルレイヤーを使用
                PolylineLayer(polylines: _polylines),
              ],
            ),
          ),
          // 下部エリア（下2/3）
          Flexible(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.centerLeft,
                    color: Colors.white,
                    child: const Text('📰 新着情報：近日中に1号路レポートを追加予定'),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () => print('コース別情報へ'),
                      child: const Text('⛰️ コース別情報'),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () => print('🌿 自然カテゴリへ'),
                      child: const Text('自然カテゴリ'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
