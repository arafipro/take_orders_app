import "package:drift/drift.dart";
import "package:take_orders_app/models/items.dart";

class Orders extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get orderNum => integer().nullable()();
  DateTimeColumn get orderTime => dateTime()();
  IntColumn get itemId => integer().nullable().references(Items, #itemId)();

  // MEMO ジェネレートファイルをビルド後に追加
  List<String> orderToCsvFormat() => [
        "$id",
        "$orderNum",
        "$orderTime",
        "$itemId",
      ];
}
