変更点とポイント

main 関数:
async を追加し、WidgetsFlutterBinding.ensureInitialized() と Firebase.initializeApp() を await で呼び出すように変更しました。これにより、Flutter アプリ起動前に Firebase の初期化が完了することを保証します。
MyApp クラス:
home に StreamBuilder<User?> を追加しました。これは FirebaseAuth.instance.authStateChanges() を監視し、Firebase の認証状態（ログインしているか、していないか）が変化するたびに UI を自動的に再構築します。
初期ロード中は CircularProgressIndicator を表示します。
ユーザーがログインしている (snapshot.hasData が true) 場合は HomePage を表示します。
ユーザーがログインしていない (snapshot.hasData が false または null) 場合は LoginPage を表示します。
LoginPage クラス:
入力フィールドの変更: _idController を _emailController に変更し、認証にはメールアドレスを使用するようにしました。TextField の labelText も「メールアドレス」に変更し、keyboardType も TextInputType.emailAddress に設定しました。
FirebaseAuth インスタンスの取得: _auth インスタンスを取得しました。
_login メソッド:
Firebase Authentication によるログイン: _auth.signInWithEmailAndPassword() を使って、入力されたメールアドレスとパスワードで Firebase にログインを試みます。
エラーハンドリング: FirebaseAuthException を try-catch で捕捉し、Firebase から返されるエラーコード（例: user-not-found, wrong-password など）に基づいてユーザーフレンドリーなメッセージを SnackBar で表示します。
ログインが成功した場合、StreamBuilder が認証状態の変化を検知し、自動的に HomePage へ遷移するため、ここでの Navigator.pushReplacement は削除しました。
_register メソッドの追加:
_auth.createUserWithEmailAndPassword() を使って、入力されたメールアドレスとパスワードで新しいユーザーを Firebase に登録します。
登録が成功すると、ユーザーは自動的にログイン状態になるため、こちらも StreamBuilder が HomePage へ遷移させます。
登録時のエラーハンドリングも追加しています。
UIの変更: 新規登録用の TextButton を追加しました。

