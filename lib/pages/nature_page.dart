// lib/pages/nature_page.dart
import 'package:flutter/material.dart';
import '../widgets/map_widget.dart'; // 共通地図ウィジェット
import 'package:latlong2/latlong.dart';

class NaturePage extends StatelessWidget {
  const NaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 上：地図（画面の1/3）
          Flexible(
            flex: 1,
            child: CommonMapWidget(
              initialCenter: const LatLng(35.6259, 139.2430),
              initialZoom: 13.0,
              children: [
                GsiTileLayer(),
                // 必要なら他のLayerも追加
              ],
            ),
          ),
          // 下：お役立ち情報（画面の2/3）
          Flexible(
            flex: 2,
            child: Container(
              color: Colors.grey[200],
              child: const Center(
                child: Text(
                  '高尾山の自然（草花、動物など）の情報が表示されます。',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
