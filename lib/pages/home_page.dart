import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 上部：メニュー + タイトル
          SizedBox(
            height: 56, // AppBar 相当の高さ
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
                      print('メニューを開く'); // 後でDrawerなどに接続
                    },
                  ),
                ),
              ],
            ),
          ),

          // 中央：地図（上1/3）
          Flexible(
            flex: 1,
            child: FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(35.625, 139.243),
                initialZoom: 14,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://cyberjapandata.gsi.go.jp/xyz/pale/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.takao35',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(35.625, 139.243),
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.place,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 下部：3分割
          Flexible(
            flex: 2,
            child: Column(
              children: [
                // 新着情報
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.white,
                    alignment: Alignment.centerLeft,
                    child: const Text('📰 新着情報：近日中に1号路レポートを追加予定'),
                  ),
                ),
                // コース別情報ボタン
                Expanded(
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () => print('コース別情報へ'),
                      child: const Text('⛰️ コース別情報'),
                    ),
                  ),
                ),
                // 自然カテゴリボタン
                Expanded(
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () => print('自然カテゴリへ'),
                      child: const Text('🌿 自然カテゴリ'),
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
