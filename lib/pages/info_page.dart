// lib/pages/info_page.dart
import 'package:flutter/material.dart';
import '../widgets/common_page_layout.dart';
import 'package:latlong2/latlong.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonPageLayout(
      mapCenter: const LatLng(35.6259, 139.2430),
      mapZoom: 13.0,
      subMenuButtons: [
        SubMenuButton(
          icon: Icons.event,
          label: 'イベント',
          content: _buildEventContent(),
        ),
        SubMenuButton(
          icon: Icons.wc,
          label: 'トイレ',
          content: _buildToiletContent(),
        ),
        SubMenuButton(
          icon: Icons.restaurant,
          label: 'お土産・食事',
          content: _buildRestaurantContent(),
        ),
      ],
      defaultContent: Container(
        color: Colors.blue[50],
        child: const Center(
          child: Text(
            '高尾山のお役立ち情報\n上のボタンから詳細情報をご覧いただけます。',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  // イベント情報のコンテンツ
  static Widget _buildEventContent() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '高尾山イベント情報',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                _buildEventCard(
                  '紅葉まつり',
                  '11月1日〜30日',
                  '秋の高尾山を彩る美しい紅葉をお楽しみください。',
                ),
                _buildEventCard('初詣', '1月1日〜3日', '薬王院での初詣。多くの参拝客で賑わいます。'),
                _buildEventCard('火渡り祭', '3月第2日曜日', '薬王院の伝統的な火渡り祭です。'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // トイレ情報のコンテンツ
  static Widget _buildToiletContent() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'トイレ情報',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                _buildToiletCard('高尾山口駅', '清滝駅近く', '24時間利用可能'),
                _buildToiletCard('1号路 薬王院', '薬王院境内', '6:00-18:00'),
                _buildToiletCard('山頂', '山頂広場', '6:00-17:00'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // お土産・食事情報のコンテンツ
  static Widget _buildRestaurantContent() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'お土産・食事',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                _buildRestaurantCard('高尾山ビアマウント', '山上', 'バイキング形式のビアガーデン'),
                _buildRestaurantCard('やまびこ茶屋', '山頂', '名物とろろそば'),
                _buildRestaurantCard('天狗の腰掛', '1号路', '甘味処・お土産'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // イベントカードのヘルパーメソッド
  static Widget _buildEventCard(String title, String date, String description) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(date, style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 4),
            Text(description),
          ],
        ),
      ),
    );
  }

  // トイレカードのヘルパーメソッド
  static Widget _buildToiletCard(String name, String location, String hours) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text('場所: $location'),
            Text('利用時間: $hours', style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }

  // レストランカードのヘルパーメソッド
  static Widget _buildRestaurantCard(
    String name,
    String location,
    String description,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text('場所: $location'),
            Text(description, style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }
}
