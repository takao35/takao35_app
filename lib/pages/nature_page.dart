import 'package:flutter/material.dart';

class NaturePage extends StatelessWidget {
  const NaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('自然カテゴリ')),
      body: const Center(child: Text('高尾山の自然（草花、動物など）の情報が表示されます。')),
    );
  }
}
