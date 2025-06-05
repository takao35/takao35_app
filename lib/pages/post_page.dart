import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(center: LatLng(35.625, 139.243), zoom: 13.0),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                ),
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
