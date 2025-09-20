<<<<<<< HEAD
// lib/pages/my_page.dart
import 'package:flutter/material.dart';
import '../widgets/common_page_layout.dart';
import 'post_page.dart'; // 投稿ページ
import 'news_create_page.dart'; // 情報登録ページ
=======
import 'package:flutter/material.dart';
import '../widgets/map_widget.dart'; // 共通地図ウィジェット
>>>>>>> cc911945a0031f0b4e43391d2b661c42edb2cfb6
import 'package:latlong2/latlong.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return CommonPageLayout(
      mapCenter: const LatLng(35.6259, 139.2430),
      mapZoom: 13.0,
      subMenuButtons: [
        SubMenuButton(icon: Icons.edit, label: '投稿', content: const PostPage()),
        SubMenuButton(
          icon: Icons.fiber_new,
          label: '情報登録',
          content: const NewsCreatePage(),
        ),
      ],
      defaultContent: Container(
        color: Colors.grey[200],
        child: const Center(
          child: Text(
            '自身が投稿した写真が表示されます。\n上のボタンから投稿や情報登録ができます。',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
=======
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
                  '自身が投稿した写真が表示されます。',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
>>>>>>> cc911945a0031f0b4e43391d2b661c42edb2cfb6
      ),
    );
  }
}
