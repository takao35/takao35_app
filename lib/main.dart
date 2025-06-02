import 'package:flutter/material.dart';
import 'map_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Takao Map',
      theme: ThemeData(useMaterial3: true),
      home: const MapPage(),
    );
  }
}
