import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // ログアウトのために

// 各メニューに対応するページをインポート
import '../pages/home_page_content.dart'; // メインコンテンツを表示するページ
import '../pages/info_page.dart';
import '../pages/course_page.dart';
import '../pages/nature_page.dart';
import '../pages/my_page.dart'; // マイページ（将来の拡張用）

class AppScaffold extends StatefulWidget {
  // 初期表示するタブのインデックスを受け取れるようにする（任意）
  final int initialIndex;

  const AppScaffold({
    super.key,
    this.initialIndex = 0, // デフォルトはメインページ
  });

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  late int _selectedIndex; // 現在選択されているタブのインデックス

  // 各タブに対応するページリスト
  final List<Widget> _widgetOptions = <Widget>[
    const HomePageContent(), // インデックス0: メイン
    const InfoPage(), // インデックス1: お役立ち情報
    const CoursePage(), // インデックス2: コース別
    const NaturePage(), // インデックス3: 自然
    const MyPage(), // インデックス4: マイページ
  ];

  // AppBarのタイトルリスト
  final List<String> _appBarTitles = const [
    '高尾山GO！', // インデックス0: メイン
    'お役立ち情報', // インデックス1: お役立ち情報
    '高尾山のコース別情報', // インデックス2: コース別
    '高尾山の自然', // インデックス3: 自然
    'マイページ', // インデックス4: マイページ
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  // タブまたはドロワーアイテムがタップされたときの処理
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitles[_selectedIndex]),
        leading: Builder(
          // ハンバーガーメニューアイコン
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // ドロワーを開く
              },
            );
          },
        ),
        actions: [
          // ログアウトボタン
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut(); // ログアウト処理
              // ログアウトするとmain.dartのStreamBuilderが検知してLoginPageへ自動遷移
            },
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'メイン'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'お役立ち情報'),
          BottomNavigationBarItem(icon: Icon(Icons.hiking), label: 'コース別'),
          BottomNavigationBarItem(icon: Icon(Icons.eco), label: '自然'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'マイページ'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
      drawer: Drawer(
        // ドロワー（左上メニュー）
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: const Text(
                'メニュー',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('メイン'),
              selected: _selectedIndex == 0,
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('お役立ち情報'),
              selected: _selectedIndex == 1,
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.hiking),
              title: const Text('コース別'),
              selected: _selectedIndex == 2,
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(2);
              },
            ),
            ListTile(
              leading: const Icon(Icons.eco),
              title: const Text('自然'),
              selected: _selectedIndex == 3,
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(3);
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('マイページ'),
              selected: _selectedIndex == 4,
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(4);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('ログアウト'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                // ログアウトするとStreamBuilderがLoginPageへ自動遷移
                Navigator.pop(context); // ドロワーを閉じる
              },
            ),
          ],
        ),
      ),
    );
  }
}
