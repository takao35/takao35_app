<<<<<<< HEAD
// lib/pages/post_page.dart
import 'package:flutter/material.dart';
=======
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // MapControllerを使うために残す
import 'package:latlong2/latlong.dart';
import '../widgets/map_widget.dart'; // 新しく作った共通ウィジェットをインポート
import '../config/routes.dart'; // ルート情報を取得するための設定ファイル
import '../utilities/gpx_loader.dart'; // GPXファイルの読み込みユーティリティ
>>>>>>> cc911945a0031f0b4e43391d2b661c42edb2cfb6

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
<<<<<<< HEAD
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedCategory = '風景';
  final List<String> _categories = ['風景', '植物', '動物', 'その他'];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
=======
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
>>>>>>> cc911945a0031f0b4e43391d2b661c42edb2cfb6
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '新しい投稿',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 写真選択セクション
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '写真を選択',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            height: 120,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo,
                                  size: 40,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '写真を追加',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // タイトル入力
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'タイトル',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _titleController,
                            decoration: const InputDecoration(
                              hintText: '投稿のタイトルを入力してください',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // カテゴリ選択
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'カテゴリ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            value: _selectedCategory,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            items: _categories.map((String category) {
                              return DropdownMenuItem<String>(
                                value: category,
                                child: Text(category),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  _selectedCategory = newValue;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 説明入力
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '説明',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _descriptionController,
                            maxLines: 4,
                            decoration: const InputDecoration(
                              hintText: '写真の説明や感想を入力してください',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 位置情報
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '位置情報',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.location_on, color: Colors.red),
                              const SizedBox(width: 8),
                              const Expanded(child: Text('現在の位置情報を使用')),
                              Switch(
                                value: true,
                                onChanged: (bool value) {
                                  // 位置情報の使用ON/OFF
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '緯度: 35.6259, 経度: 139.2430',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // 投稿ボタン
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // 投稿処理
                        _submitPost();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber[800],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: const Text('投稿する'),
                    ),
                  ),
                ],
              ),
=======
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
>>>>>>> cc911945a0031f0b4e43391d2b661c42edb2cfb6
            ),
          ),
        ],
      ),
    );
  }
<<<<<<< HEAD

  void _submitPost() {
    // 投稿処理のロジック
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('タイトルを入力してください')));
      return;
    }

    // 実際の投稿処理をここに実装
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('投稿しました！')));

    // フォームをクリア
    _titleController.clear();
    _descriptionController.clear();
    setState(() {
      _selectedCategory = '風景';
    });
  }
=======
>>>>>>> cc911945a0031f0b4e43391d2b661c42edb2cfb6
}
