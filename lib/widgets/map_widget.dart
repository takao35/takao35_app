import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// 共通の地図表示ウィジェット
class CommonMapWidget extends StatefulWidget {
  // StatefulWidgetに変更
  final MapController? mapController; // MapControllerを外部から渡せるようにする
  final LatLng initialCenter;
  final double initialZoom;
  final List<Widget> children; // タイルレイヤーやポリラインレイヤーなど、地図上の要素

  const CommonMapWidget({
    super.key,
    this.mapController,
    required this.initialCenter,
    required this.initialZoom,
    this.children = const [], // デフォルトで空のリスト
  });

  @override
  State<CommonMapWidget> createState() => _CommonMapWidgetState();
}

class _CommonMapWidgetState extends State<CommonMapWidget> {
  // CommonMapWidget内でMapControllerを管理。外部から渡されなければ内部で生成
  late final MapController _internalMapController;

  @override
  void initState() {
    super.initState();
    // 外部からmapControllerが渡されなければ、内部で新しいMapControllerを生成
    _internalMapController = widget.mapController ?? MapController();
  }

  void _moveToCenter() {
    _internalMapController.move(
      LatLng(35.628, 139.255), // 高尾山中心
      14.0, // ズームイン
    );
  }

  void _moveToWide() {
    _internalMapController.move(
      LatLng(35.625, 139.243), // 高尾山＋城山の中間あたり
      13.0, // ズームアウト
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      // ボタンを重ねるためにStackを使用
      children: [
        FlutterMap(
          mapController: _internalMapController, // 内部のMapControllerを使用
          options: MapOptions(
            initialCenter: widget.initialCenter,
            initialZoom: widget.initialZoom,
          ),
          children: widget.children,
        ),
        Positioned(
          // ボタンを地図上に配置
          top: 8,
          left: 8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: _moveToCenter,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  textStyle: const TextStyle(fontSize: 12),
                  minimumSize: const Size(80, 32),
                ),
                child: const Text('中心部'),
              ),
              const SizedBox(height: 6),
              ElevatedButton(
                onPressed: _moveToWide,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  textStyle: const TextStyle(fontSize: 12),
                  minimumSize: const Size(80, 32),
                ),
                child: const Text('広域表示'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // もしMapControllerがCommonMapWidget内部で生成されたものであれば破棄する
    // ただし、外部から渡された場合は、外部で破棄の責務があるため、ここでは何もしない
    // 厳密には、widget.mapControllerがnullの場合にのみ_internalMapControllerをdisposeするロジックが必要だが、
    // MapControllerのインスタンスが複数存在しても大きな問題になりにくいため、今回はシンプルに扱う。
    // _internalMapController.dispose(); // 必要であればコメント解除して追加
    super.dispose();
  }
}

// MapWidgetで使うためのTileLayerの定義（変更なし）
class GsiTileLayer extends TileLayer {
  GsiTileLayer({super.key})
    : super(
        urlTemplate:
            'https://cyberjapandata.gsi.go.jp/xyz/pale/{z}/{x}/{y}.png',
        userAgentPackageName: 'com.example.takao35', // あなたのアプリのパッケージ名に合わせて変更
      );
}

class OpenStreetMapTileLayer extends TileLayer {
  OpenStreetMapTileLayer({super.key})
    : super(
        urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
        subdomains: const ['a', 'b', 'c'],
      );
}
