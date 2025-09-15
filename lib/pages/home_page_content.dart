// -------------------------------------------------------------
// 旧 HomePage のボディ部分を切り出したウィジェット
// lib/pages/home_page.dart をこの内容に置き換えます。
// -------------------------------------------------------------
import 'package:flutter/material.dart';
import '../utilities/gpx_loader.dart'; // GPXファイルの読み込みユーティリティ
import '../widgets/map_widget.dart'; // 共通地図ウィジェットをインポート
import '../config/routes.dart'; // ルート情報を取得するための設定ファイル
import 'package:flutter_map/flutter_map.dart'; // FlutterMapやLatLngのために必要
import 'package:latlong2/latlong.dart'; // FlutterMapのために必要

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 地図エリア（上1/3）
        Flexible(
          flex: 1,
          child: CommonMapWidget(
            mapController: _mapController, // MapControllerを渡す
            initialCenter: LatLng(35.625, 139.243),
            initialZoom: 13.0,
            children: [
              GsiTileLayer(),
              PolylineLayer(polylines: _polylines),
            ],
          ),
        ),
        // 下部エリア（下2/3）
        Flexible(
          flex: 2,
          child: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 📰 新着情報（トップのパネル）
                  _SectionHeader(title: '📰 新着情報'),
                  const SizedBox(height: 8),
                  _NewsPanel(
                    items: const [
                      '近日中に1号路レポートを追加予定',
                      '薬王院周辺の紅葉フォトコンテストを開催',
                      '稲荷山コースの路面整備レポートを公開',
                    ],
                    onMore: () {
                      // TODO: ルーティングがある場合は置き換え
                      // Navigator.of(context).pushNamed(Routes.news);
                      debugPrint('新着情報 もっと見る');
                    },
                  ),

                  const SizedBox(height: 16),

                  // 要約パネル（イベント / 鉄道）
                  _SectionHeader(title: '📌 要約'),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _SummaryCard(
                          title: '🎪 イベント',
                          bullets: const [
                            '10/19 高尾山もみじ祭（仮）',
                            '今週末 山頂ライブ演奏',
                            '薬王院 宝物殿 特別公開',
                          ],
                          onTap: () {
                            // Navigator.of(context).pushNamed(Routes.events);
                            debugPrint('イベント要約を開く');
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _SummaryCard(
                          title: '🚃 鉄道情報',
                          bullets: const [
                            '京王線：通常運行',
                            '高尾登山電鉄：ケーブル運行中',
                            'JR中央線：遅延 5分',
                          ],
                          onTap: () {
                            // Navigator.of(context).pushNamed(Routes.rail);
                            debugPrint('鉄道要約を開く');
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // 既存：コース / 自然 のダイレクト導線をパネル化
                  _SectionHeader(title: '🔍 コンテンツ'),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _SummaryCard(
                          title: '⛰️ コース別情報',
                          bullets: const ['主要ルートの所要時間', 'GPX/高低図あり', '混雑の目安'],
                          onTap: () {
                            // Navigator.of(context).pushNamed(Routes.courses);
                            debugPrint('コース別情報へ');
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _SummaryCard(
                          title: '🌿 自然（動植物・地質）',
                          bullets: const ['今見頃の植物・昆虫', '地形・地質の豆知識', '観察マナー'],
                          onTap: () {
                            // Navigator.of(context).pushNamed(Routes.nature);
                            debugPrint('自然カテゴリへ');
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

class _NewsPanel extends StatelessWidget {
  final List<String> items;
  final VoidCallback onMore;
  const _NewsPanel({required this.items, required this.onMore});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            for (final text in items.take(5))
              ListTile(
                dense: true,
                horizontalTitleGap: 8,
                title: Text(
                  text,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  debugPrint('ニュース項目: ' + text);
                },
              ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(onPressed: onMore, child: const Text('もっと見る')),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final List<String> bullets;
  final VoidCallback onTap;
  const _SummaryCard({
    required this.title,
    required this.bullets,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              for (final b in bullets.take(3))
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• '),
                      Expanded(
                        child: Text(
                          b,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 4),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('詳細'),
                    SizedBox(width: 4),
                    Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
