import "package:take_orders_app/constants/imports.dart";

// CSVファイルの有無を確認
Future<List<FileSystemEntity>> checkCsvFiles() async {
  // 保存したテキストファイルのディレクトリ情報を取得
  final directory = await getApplicationDocumentsDirectory();
  // ディレクトリ内にある全てのファイル情報を取得
  List<FileSystemEntity> allFiles = Directory(directory.path).listSync();
  // CSVファイルを抽出
  allFiles.removeWhere((file) => !file.path.endsWith(".csv"));
  // 確認用にパスをログに表示
  for (var file in allFiles) {
    debugPrint(file.path);
  }
  // CSVファイルが有無で分岐
  allFiles.isEmpty ? debugPrint("CSVファイル無し") : debugPrint("CSVファイル有り");
  return allFiles;
}
