import "package:drift/drift.dart";

class Items extends Table {
  IntColumn get itemId => integer().autoIncrement()();
  TextColumn get itemName => text()();
  IntColumn get itemPrice => integer().nullable()();
}