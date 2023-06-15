import "dart:io";
import "package:flutter/material.dart";
import "package:google_sign_in/google_sign_in.dart" as signin;
import "package:googleapis/drive/v3.dart" as drive;
import "package:googleapis_auth/googleapis_auth.dart";
import "package:path_provider/path_provider.dart";
import "package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart";
import "package:path/path.dart";

class GoogleDriveOpsPage extends StatefulWidget {
  const GoogleDriveOpsPage({super.key});

  @override
  State<GoogleDriveOpsPage> createState() => _GoogleDriveOpsPageState();
}

class _GoogleDriveOpsPageState extends State<GoogleDriveOpsPage> {
  String savedFileName = "";
  late signin.GoogleSignIn googleSignIn;
  signin.GoogleSignInAccount? account;
  late drive.DriveApi googleDriveApi;
  late drive.FileList list;
  String signInStatus = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const Text(
              "Google Drive 操作テスト（管理画面）",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _getListFromGoogleDrive(),
                child: const Text(
                  "Googleドライブ内の全ファイル情報を取得",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _backUpToGoogleDrive(),
                child: const Text(
                  "Googleドライブに全ファイルをバックアップ",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _importFromGoogleDrive(),
                child: const Text(
                  "Googleドライブから全ファイルをインポート",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _deleteGoogleDriveFiles(),
                child: const Text(
                  "Googleドライブ内の全ファイルを削除",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _signOutFromGoogle(),
                child: const Text(
                  "サインアウト",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(signInStatus),
          ],
        ),
      ),
    );
  }

  /// Google SignIn処理をするメソッド
  Future<bool> _googleSignInMethod() async {
    googleSignIn = signin.GoogleSignIn(scopes: [
      // Google Drive内のアプリ専用領域へのアクセス権を要求
      drive.DriveApi.driveAppdataScope,
      // // Google Drive内のユーザー領域へのアクセス権を要求
      // drive.DriveApi.driveScope,
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

  /// ステップ②
  Future<void> _backUpToGoogleDrive() async {
    final savedFileDirectory = await getApplicationDocumentsDirectory();
    // ディレクトリ内にある全てのファイル情報を取得
    List<FileSystemEntity> fileEntity =
        Directory(savedFileDirectory.path).listSync();
    // バックアップ対象であるCSVファイル以外をリストから削除
    fileEntity.removeWhere((element) => !element.path.endsWith(".csv"));
    for (var element in fileEntity) {
      debugPrint(element.path);
    }
    if (fileEntity.isEmpty) {
      debugPrint("バックアップ対象のファイル無し");
      setState(() {
        signInStatus = "バックアップ対象のファイル無し";
      });
      return;
    }

    final signInResult = await _googleSignInMethod();
    if (!signInResult) {
      return;
    }
    late AuthClient httpClient;
    httpClient = (await googleSignIn.authenticatedClient())!;
    googleDriveApi = drive.DriveApi(httpClient);
    final uploadedFile = drive.File();
    // Google Drive内のアプリ専用領域に保存する事を指定
    uploadedFile.parents = ["appDataFolder"];
    // ※スコープを「drive.DriveApi.driveScope」に設定し、ユーザーが見える場所に
    //  ファイルを保存する場合は、上記1文を削除する
    // 端末のアプリ専用フォルダ内のファイルを、forループで順次Google Driveに保存
    for (int i = 0; i < fileEntity.length; i++) {
      final File file = File(fileEntity[i].path);
      uploadedFile.name = "googleDrive_${basename(fileEntity[i].path)}";
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
      signInStatus = "Google Driveに全ファイルのバックアップ完了";
    });
    debugPrint("Google Driveに全ファイルのバックアップ完了");
  }

  /// ステップ③
  Future<void> _getListFromGoogleDrive() async {
    final signInResult = await _googleSignInMethod();
    if (!signInResult) {
      return;
    }
    late AuthClient httpClient;
    httpClient = (await googleSignIn.authenticatedClient())!;
    googleDriveApi = drive.DriveApi(httpClient);
    // Google Driveのアプリ専用領域（appDataFolder）からファイル情報を取得
    // listメソッドに、$fields:の引数として、取得したい情報を指定（ここではid、ファイル名、作成日時を指定）
    // ※取得できる情報は、v3.dartのFileクラスにあるプロパティまたは以下で確認可能
    //  https://developers.google.com/drive/api/v3/reference/files
    await googleDriveApi.files
        .list(spaces: "appDataFolder", $fields: "files(id, name, createdTime)")
        .then((value) {
      list = value;
      if (list.files!.isNotEmpty) {
        for (var i = 0; i < list.files!.length; i++) {
          debugPrint(
              "Id: ${list.files![i].id} File Name:${list.files![i].name} Created Time: ${list.files![i].createdTime!.toLocal()}");
        }
        setState(() {
          signInStatus = "Google Drive内にデータ有り";
        });
      } else {
        setState(() {
          signInStatus = "Google Drive内にデータなし";
        });
        // debugPrint("Google Drive内にデータなし");
      }
    });
  }

  /// ステップ④
  Future<void> _importFromGoogleDrive() async {
    await _getListFromGoogleDrive();
    final importDirectory = await getApplicationDocumentsDirectory();
    int importCount = 0;
    if (list.files!.isNotEmpty) {
      for (var i = 0; i < list.files!.length; i++) {
        final importFilePath = join(importDirectory.path, list.files![i].name);
        debugPrint("インポート先のフルパス: $importFilePath");
        final importFile = File(importFilePath);
        drive.Media? file = (await googleDriveApi.files.get(list.files![i].id!,
            downloadOptions: drive.DownloadOptions.fullMedia)) as drive.Media?;
        List<int> downLoadedData = [];
        file!.stream.listen(
          (data) {
            debugPrint("DataReceived: ${data.length}");
            downLoadedData.insertAll(downLoadedData.length, data);
          },
          onDone: () async {
            importCount++;
            debugPrint("forループのindex値 ${i + 1}");
            debugPrint("カウンター値 $importCount");
            await importFile.writeAsBytes(downLoadedData);
            if (importCount == list.files!.length) {
              setState(() {
                signInStatus = "Googleドライブから全ファイルのインポート完了";
              });
              debugPrint("Googleドライブから全ファイルのインポート完了");
            }
          },
          onError: (error) {
            debugPrint("エラーでインポートできず $error");
          },
        );
      }
    } else {
      setState(() {
        signInStatus = "インポートするファイル無し";
      });
      debugPrint("インポートするファイル無し");
    }
  }

  /// ステップ⑤
  Future<void> _deleteGoogleDriveFiles() async {
    await _getListFromGoogleDrive();
    if (list.files!.isNotEmpty) {
      for (var i = 0; i < list.files!.length; i++) {
        await googleDriveApi.files.delete(list.files![i].id!);
        setState(() {
          signInStatus = "$i/${list.files!.length}個のファイルを削除";
        });
      }
      setState(() {
        signInStatus = "データ削除完了";
      });
      debugPrint("データ削除完了");
      return;
    }
  }

  /// ステップ⑥
  Future<void> _signOutFromGoogle() async {
    googleSignIn = signin.GoogleSignIn(scopes: [
      drive.DriveApi.driveAppdataScope,
    ]);
    try {
      await googleSignIn.signOut();
      // // 再サインインするときに再度、同意画面を表示させたい場合は、上記1文を以下に変更（完全サインアウト）
      // await googleSignIn.disconnect();
      // // firebase上にサインインしたユーザー情報を記録している場合は以下を追加
      // // ※firebase_auth、firebase_coreのインポートが必要
      // await FirebaseAuth.instance.signOut();
      setState(() {
        signInStatus = "サインアウト";
      });
    } catch (e) {
      debugPrint("サインアウトできず $e");
    }
  }
}
