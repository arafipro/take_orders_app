import "package:drift/drift.dart";

class Items extends Table {
  IntColumn get itemId => integer().autoIncrement()();
  TextColumn get itemName => text().nullable()();
  IntColumn get itemPrice => integer().nullable()();

  // MEMO ジェネレートファイルをビルド後に追加
  List<String> itemToCsvFormat() => [
        "$itemId",
        "$itemName",
        "$itemPrice",
      ];
}
