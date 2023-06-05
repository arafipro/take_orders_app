import "package:drift/drift.dart";
import "package:take_orders_app/db_utils/order_db.dart";

final database = OrderDatabase();

class ItemsRepository {
  Stream<List<Item>> watchAllItems() {
    return (database.select(database.items)).watch();
  }

  Future<List<Item>> getAllItems() async {
    return await database.select(database.items).get();
  }

  // 一件登録
  Future<void> addItem(String itemName, int itemPrice) async {
    // Simple insert:
    await database
        .into(database.items)
        .insert(ItemsCompanion(itemName: Value(itemName), itemPrice: Value(itemPrice)));
  }

  Future<void> addItemsCompanion(ItemsCompanion item) async {
    // Simple insert:
    await database.into(database.items).insert(item);
  }

  // 複数登録
  Future<void> addItems(List<ItemsCompanion> items) async {
    await database.batch((batch) {
      batch.insertAll(database.items, items);
    });
  }

  // 更新
  Future<int> updateItems(int id, String itemName, int itemPrice) {
    return (database.update(database.items)..where((tbl) => tbl.itemId.equals(id)))
        .write(
      ItemsCompanion(
        itemName: Value(itemName),
        itemPrice: Value(itemPrice),
      ),
    );
  }

  Future<int> updateItemsCompanion(int id, ItemsCompanion item) {
    return (database.update(database.items)..where((tbl) => tbl.itemId.equals(id)))
        .write(item);
  }

  // 削除
  Future<int> deleteItems(int id) async {
    return await (database.delete(database.items)
          ..where((tbl) => tbl.itemId.equals(id)))
        .go();
  }
}
