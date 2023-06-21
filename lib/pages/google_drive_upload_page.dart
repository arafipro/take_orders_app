import "package:take_orders_app/constants/imports.dart";

import "package:intl/intl.dart";
import "package:google_sign_in/google_sign_in.dart" as signin;
import "package:googleapis/drive/v3.dart" as drive;

class GoogleDriveUploadPage extends StatefulWidget {
  const GoogleDriveUploadPage({super.key});

  @override
  State<GoogleDriveUploadPage> createState() => _GoogleDriveUploadPageState();
}

class _GoogleDriveUploadPageState extends State<GoogleDriveUploadPage> {
  String savedFileName = "";
  late signin.GoogleSignIn googleSignIn;
  signin.GoogleSignInAccount? account;
  late drive.DriveApi googleDriveApi;
  late drive.FileList list;
  String signInStatus = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  const Text(
                    "売上データアップロード",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  FullWideButton(
                    onPressed: () => _upLoadToGoogleDrive(),
                    text: "売上データアップロード",
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(signInStatus),
                ],
              ),
            ),
            const Spacer(),
            AdBanner()
          ],
        ),
      ),
    );
  }

  // Google SignIn処理をするメソッド
  Future<bool> _googleSignInMethod() async {
    googleSignIn = signin.GoogleSignIn(scopes: [
      // Google Drive内のユーザー領域へのアクセス権を要求
      drive.DriveApi.driveScope,
    ]);
    try {
      // サインイン済か否か確認
      final checkSignInResult = await googleSignIn.isSignedIn();
      debugPrint("サインインしているか否か $checkSignInResult");
      // サインイン済の場合は、サインインのポップアップを出さずにサインイン処理
      // ※iOSの場合はsignInSilentlyにしないと、毎回サインインのポップアップが出てしまうため
      if (checkSignInResult) {
        account = await googleSignIn.signInSilently();
        if (account == null) {
          debugPrint("認証情報を初期化する必要が生じたため、もう一度ボタンを押してください。");
          await googleSignIn.disconnect();
          throw Exception();
        }
      } else {
        account = await googleSignIn.signIn();
        if (account == null) {
          debugPrint("キャンセル");
          throw Exception();
        }
      }

      // signin.GoogleSignInAuthentication auth = await account!.authentication;
      // final AuthCredential credential = GoogleAuthProvider.credential(
      //   idToken: auth.idToken,
      //   accessToken: auth.accessToken,
      // );
      // User? user =
      //     (await FirebaseAuth.instance.signInWithCredential(credential)).user;
      // debugPrint("ユーザーUID: ${user!.uid}");

      // サインイン表示に変更し、再描画
      setState(() {
        signInStatus = "サインイン中";
      });
      // 返り値trueを返す
      return true;
    } catch (e) {
      // サインアウト表示に変更し、再描画
      setState(() {
        signInStatus = "サインアウト中";
      });
      // 返り値falseを返す
      debugPrint("サインインできず $e");
      return false;
    }
  }

  // 売上データをGoogle Driveにアップロード
  Future<void> _upLoadToGoogleDrive() async {
    // MEMO CSVファイルの有無をチェック
    List<FileSystemEntity> fileEntity = await checkCsvFiles();
    // MEMO CSVファイルがない場合はファイルを作成
    orderWItemCreateCsv();
    // MEMO サインインしているかチェック
    final signInResult = await _googleSignInMethod();
    if (!signInResult) {
      return;
    }
    late AuthClient httpClient;
    httpClient = (await googleSignIn.authenticatedClient())!;
    googleDriveApi = drive.DriveApi(httpClient);
    final uploadedFile = drive.File();
    for (int i = 0; i < fileEntity.length; i++) {
      final File file = File(fileEntity[i].path);
      DateTime now = DateTime.now();
      DateFormat formatter = DateFormat("yyyy-MM-dd_HH:mm:ss");
      String formattedDate = formatter.format(now);
      uploadedFile.name = "${formattedDate}_${basename(fileEntity[i].path)}";
      await googleDriveApi.files.create(
        uploadedFile,
        uploadMedia: drive.Media(file.openRead(), file.lengthSync()),
      );
      setState(() {
        signInStatus = "${i + 1}/${fileEntity.length}番目のファイルを保存";
      });
      // debugPrint("${i + 1}番目のファイルを保存");
    }
    setState(() {
      signInStatus = "売上データアップロード完了";
    });
    debugPrint("売上データアップロード完了");
  }
}
