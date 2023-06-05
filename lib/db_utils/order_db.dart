import "dart:io";

import "package:drift/drift.dart";
import "package:drift/native.dart";
import "package:path_provider/path_provider.dart";
import "package:path/path.dart" as p;
import "package:take_orders_app/models/items.dart";
import "package:take_orders_app/models/orders.dart";

part "order_db.g.dart";

@DriftDatabase(tables: [Orders, Items])
class OrderDatabase extends _$OrderDatabase {
  OrderDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, "db.sqlite"));
    return NativeDatabase.createInBackground(file);
  });
}
