import 'package:flutter/material.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('コース別情報')),
      body: const Center(child: Text('高尾山のコース別情報が表示されます。')),
    );
  }
}
