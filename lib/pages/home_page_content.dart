// -------------------------------------------------------------
// 旧 HomePage のボディ部分を切り出したウィジェット
// lib/pages/home_page.dart をこの内容に置き換えます。
// -------------------------------------------------------------
import 'package:flutter/material.dart';
import '../utilities/gpx_loader.dart'; // GPXファイルの読み込みユーティリティ
import '../widgets/map_widget.dart'; // 共通地図ウィジェットをインポート
import '../config/routes.dart'; // ルート情報を取得するための設定ファイル
import 'package:flutter_map/flutter_map.dart'; // FlutterMapやLatLngのために必要
import 'package:latlong2/latlong.dart'; // FlutterMapのために必要

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
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
              color: route.color.withOpacity(0.5),
            ),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 地図エリア（上1/3）
        Flexible(
          flex: 1,
          child: CommonMapWidget(
            mapController: _mapController, // MapControllerを渡す
            initialCenter: LatLng(35.625, 139.243),
            initialZoom: 13.0,
            children: [
              GsiTileLayer(),
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
    );
  }
}
