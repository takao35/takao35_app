// lib/pages/course_page.dart
import 'package:flutter/material.dart';
import '../widgets/common_page_layout.dart';
import 'package:latlong2/latlong.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonPageLayout(
      mapCenter: const LatLng(35.6259, 139.2430),
      mapZoom: 13.0,
      subMenuButtons: [
        SubMenuButton(
          icon: Icons.looks_one,
          label: '1号路',
          content: _buildCourseContent(
            '1号路（表参道コース）',
            '舗装された歩きやすいメインコース',
            '約100分',
            '3.8km',
            'すべての方におすすめ',
          ),
        ),
        SubMenuButton(
          icon: Icons.looks_two,
          label: '2号路',
          content: _buildCourseContent(
            '2号路（霞台ループコース）',
            '霞台展望台を巡る自然豊かなコース',
            '約40分',
            '0.9km',
            '1号路との組み合わせがおすすめ',
          ),
        ),
        SubMenuButton(
          icon: Icons.looks_3,
          label: '3号路',
          content: _buildCourseContent(
            '3号路（かつら林コース）',
            'カツラの大木が見どころの自然コース',
            '約60分',
            '2.4km',
            '自然が好きな方におすすめ',
          ),
        ),
        SubMenuButton(
          icon: Icons.looks_4,
          label: '4号路',
          content: _buildCourseContent(
            '4号路（吊り橋コース）',
            'みやま橋（吊り橋）がハイライト',
            '約50分',
            '1.5km',
            '吊り橋体験をしたい方に',
          ),
        ),
        SubMenuButton(
          icon: Icons.looks_5,
          label: '5号路',
          content: _buildCourseContent(
            '5号路（山頂ループコース）',
            '山頂周辺を巡る短いコース',
            '約30分',
            '0.9km',
            '山頂到達後の散策に',
          ),
        ),
        SubMenuButton(
          icon: Icons.looks_6,
          label: '6号路',
          content: _buildCourseContent(
            '6号路（びわ滝コース）',
            'びわ滝を目指す沢沿いのコース',
            '約90分',
            '3.3km',
            '滝と自然を楽しみたい方に',
          ),
        ),
        SubMenuButton(
          icon: Icons.filter_7,
          label: '稲荷山',
          content: _buildCourseContent(
            '稲荷山コース',
            '尾根道を歩く本格的な登山コース',
            '約90分',
            '3.1km',
            '登山経験者におすすめ',
          ),
        ),
      ],
      defaultContent: Container(
        color: Colors.green[50],
        child: const Center(
          child: Text(
            '高尾山のコース情報\n上のボタンから各コースの詳細をご覧いただけます。',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  // コース詳細のコンテンツを生成
  static Widget _buildCourseContent(
    String courseName,
    String description,
    String time,
    String distance,
    String recommendation,
  ) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            courseName,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // コース基本情報
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildInfoRow('所要時間', time, Icons.access_time),
                  const Divider(),
                  _buildInfoRow('距離', distance, Icons.straighten),
                  const Divider(),
                  _buildInfoRow('おすすめ', recommendation, Icons.thumb_up),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // コース説明
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'コースの特徴',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(description),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // 見どころ（サンプル）
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '主な見どころ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(_getHighlights(courseName)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 情報行を作成するヘルパーメソッド
  static Widget _buildInfoRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
        Expanded(child: Text(value)),
      ],
    );
  }

  // コースごとの見どころを取得
  static String _getHighlights(String courseName) {
    switch (courseName) {
      case '1号路（表参道コース）':
        return '薬王院、杉並木、ケーブルカー・リフト乗り場';
      case '2号路（霞台ループコース）':
        return '霞台展望台、東京の景色';
      case '3号路（かつら林コース）':
        return 'カツラの大木、自然林';
      case '4号路（吊り橋コース）':
        return 'みやま橋（吊り橋）、渓谷美';
      case '5号路（山頂ループコース）':
        return '山頂展望台、富士山の眺望';
      case '6号路（びわ滝コース）':
        return 'びわ滝、沢の自然、修行場';
      case '稲荷山コース':
        return '稲荷山展望台、尾根道からの眺望';
      default:
        return '自然豊かな高尾山の魅力';
    }
  }
}
