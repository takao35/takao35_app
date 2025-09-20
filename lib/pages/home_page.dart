import 'package:flutter/material.dart';
import '../widgets/app_scaffold.dart'; // 新しく作ったAppScaffoldをインポート

// アプリのメインナビゲーションを担うページ
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(); // AppScaffold を呼び出すだけ
  }
}
