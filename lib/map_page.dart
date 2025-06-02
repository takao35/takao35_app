import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('高尾山GO！')),
      body: Column(
        children: [
          // 上：地図（画面の1/3）
          Flexible(
            flex: 1,
            child: FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(35.625, 139.243),
                initialZoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://cyberjapandata.gsi.go.jp/xyz/pale/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
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
                        size: 40,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 下：その他のUI（画面の2/3）
          Flexible(
            flex: 2,
            child: Container(
              color: Colors.grey[200],
              child: const Center(
                child: Text('新着情報がここに表示されます', style: TextStyle(fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
