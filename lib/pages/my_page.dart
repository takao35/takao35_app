import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('自然カテゴリ')),
      body: const Center(child: Text('自身が投稿した写真が表示されます。')),
    );
  }
}
