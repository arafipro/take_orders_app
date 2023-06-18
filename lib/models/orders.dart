import "package:drift/drift.dart";
import "package:take_orders_app/models/items.dart";

class Orders extends Table {
  IntColumn get id => integer().autoIncrement()();
  BoolColumn get orderCheck => boolean().nullable()();
  IntColumn get orderNum => integer().nullable()();
  DateTimeColumn get orderTime => dateTime()();
  IntColumn get itemId => integer().nullable().references(Items, #itemId)();

  // MEMO ジェネレートファイルをビルド後に追加
  List<String> orderToCsvFormat() => [
        "$id",
        "$orderCheck",
        "$orderNum",
        "$orderTime",
        "$itemId",
      ];
}
