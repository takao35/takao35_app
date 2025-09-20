// lib/pages/my_page.dart
import 'package:flutter/material.dart';
import '../widgets/common_page_layout.dart';
import 'post_page.dart'; // 投稿ページ
import 'news_create_page.dart'; // 情報登録ページ
import 'package:latlong2/latlong.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
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
      ),
    );
  }
}
