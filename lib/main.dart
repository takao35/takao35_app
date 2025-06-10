// lib/main.dart の一部
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:takao35_app/firebase_options.dart';
import 'pages/home_page.dart'; // このHomePageはAppScaffoldを呼び出すものになる
// 以下に LoginPage が定義されています

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Takao GO',
      theme: ThemeData(useMaterial3: true),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasData) {
            return const HomePage(); // ログイン済みの場合
          }
          return const LoginPage(); // 未ログインの場合
        },
      ),
    );
  }
}

// ****** ここからが LoginPage の内容です ******
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _login() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // ログイン成功後はStreamBuilderが自動的にHomePageへ遷移させる
    } on FirebaseAuthException catch (e) {
      String message = 'ログインに失敗しました。';
      if (e.code == 'user-not-found') {
        message = 'ユーザーが見つかりません。';
      } else if (e.code == 'wrong-password') {
        message = 'パスワードが間違っています。';
      } else if (e.code == 'invalid-email') {
        message = 'メールアドレスの形式が正しくありません。';
      } else if (e.code == 'network-request-failed') {
        message = 'ネットワークエラーが発生しました。';
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('予期せぬエラーが発生しました: $e')));
    }
  }

  void _register() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('新規登録が完了しました！')));
    } on FirebaseAuthException catch (e) {
      String message = '登録に失敗しました。';
      if (e.code == 'weak-password') {
        message = 'パスワードが弱すぎます。6文字以上にしてください。';
      } else if (e.code == 'email-already-in-use') {
        message = 'このメールアドレスは既に使用されています。';
      } else if (e.code == 'invalid-email') {
        message = 'メールアドレスの形式が正しくありません。';
      } else if (e.code == 'network-request-failed') {
        message = 'ネットワークエラーが発生しました。';
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('予期せぬエラーが発生しました: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ログイン / 新規登録')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'メールアドレス'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'パスワード'),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: _login, child: const Text('ログイン')),
            const SizedBox(height: 16),
            TextButton(onPressed: _register, child: const Text('新規登録はこちら')),
          ],
        ),
      ),
    );
  }
}
// ****** ここまでが LoginPage の内容です ******