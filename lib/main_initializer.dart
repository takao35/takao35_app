import 'package:firebase_core/firebase_core.dart';
import 'package:takao35_app/firebase_options.dart'; // あなたのプロジェクト名に合わせてパスを調整
import 'package:flutter/material.dart'; // MaterialAppなどを使っている場合

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // この行がエラーの原因
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp()); // MyAppはあなたのアプリのウィジェットに置き換えてください
}

// MyAppなどのクラス定義が続く...
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Text('Hello Firebase!'), // 仮のウィジェット
    );
  }
}
