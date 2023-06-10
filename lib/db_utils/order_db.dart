import "dart:io";

import "package:drift/drift.dart";
import "package:drift/native.dart";
import "package:path_provider/path_provider.dart";
import "package:path/path.dart" as p;
import "package:take_orders_app/models/items.dart";
import "package:take_orders_app/models/orders.dart";
import "package:take_orders_app/models/orders_with_item.dart";

part "order_db.g.dart";

@DriftDatabase(tables: [Orders, Items], views: [OrdersWithItem])
class OrderDatabase extends _$OrderDatabase {
  OrderDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      // MEMO 外部キーを有効にする
      beforeOpen: (details) async {
        if (details.wasCreated) {
          await customStatement("PRAGMA foreign_keys = ON");
        }
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, "db.sqlite"));
    return NativeDatabase.createInBackground(file);
  });
}
