// lib/map_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart'; // ← 追加

class MapPage extends StatefulWidget {
  const MapPage({super.key});
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final _mapController = MapController();

  Future<LatLng?> _getCurrentPosition() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return null;
    }
    if (permission == LocationPermission.deniedForever) return null;

    final p = await Geolocator.getCurrentPosition();
    return LatLng(p.latitude, p.longitude);
  }

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
              mapController: _mapController,
              options: MapOptions(
                initialCenter: const LatLng(35.6259, 139.2430), // 高尾山周辺で仮
                initialZoom: 13,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
              ],
            ),
          ),
          // 下：新着情報（画面の2/3）
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final pos = await _getCurrentPosition();
          if (pos != null) {
            _mapController.move(pos, 17); // だいたい半径500m相当のズーム
          } else {
            if (!mounted) return;
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('現在地を取得できませんでした')));
          }
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
