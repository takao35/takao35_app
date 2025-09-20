// lib/widgets/common_page_layout.dart
import 'package:flutter/material.dart';
import 'map_widget.dart'; // 共通地図ウィジェット
import 'package:latlong2/latlong.dart';

class CommonPageLayout extends StatefulWidget {
  final List<SubMenuButton> subMenuButtons; // サブメニューボタンのリスト
  final Widget defaultContent; // デフォルトで表示するコンテンツ
  final LatLng? mapCenter; // 地図の中心位置（省略時はデフォルト）
  final double? mapZoom; // 地図のズーム値

  const CommonPageLayout({
    super.key,
    required this.subMenuButtons,
    required this.defaultContent,
    this.mapCenter,
    this.mapZoom,
  });

  @override
  State<CommonPageLayout> createState() => _CommonPageLayoutState();
}

class _CommonPageLayoutState extends State<CommonPageLayout> {
  int _selectedSubMenuIndex = -1; // 選択されたサブメニューのインデックス（-1はデフォルト）

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 上：地図エリア（画面の1/3）
        Flexible(
          flex: 1,
          child: CommonMapWidget(
            initialCenter: widget.mapCenter ?? const LatLng(35.6259, 139.2430),
            initialZoom: widget.mapZoom ?? 13.0,
            children: [
              GsiTileLayer(),
              // 必要なら他のLayerも追加
            ],
          ),
        ),

        // 中：サブメニューボタン
        if (widget.subMenuButtons.isNotEmpty) ...[
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: widget.subMenuButtons.asMap().entries.map((entry) {
                  int index = entry.key;
                  SubMenuButton button = entry.value;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _selectedSubMenuIndex = index;
                        });
                      },
                      icon: Icon(button.icon),
                      label: Text(button.label),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedSubMenuIndex == index
                            ? Colors.amber[800]
                            : null,
                        foregroundColor: _selectedSubMenuIndex == index
                            ? Colors.white
                            : null,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],

        // 下：コンテンツエリア（画面の2/3）
        Flexible(
          flex: 2,
          child: _selectedSubMenuIndex == -1
              ? widget.defaultContent
              : widget.subMenuButtons[_selectedSubMenuIndex].content,
        ),
      ],
    );
  }
}

// サブメニューボタンのデータクラス
class SubMenuButton {
  final IconData icon;
  final String label;
  final Widget content;

  SubMenuButton({
    required this.icon,
    required this.label,
    required this.content,
  });
}
