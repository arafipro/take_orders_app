import "package:drift/drift.dart";
import "package:take_orders_app/db_utils/order_db.dart";

final database = OrderDatabase();

class ItemsRepository {
  // 全検索
  Stream<List<Item>> watchAllItems() {
    return (database.select(database.items)).watch();
  }

  Future<List<Item>> getAllItems() async {
    return await database.select(database.items).get();
  }

  // 一件登録
  Future<void> addItem(String itemName, int itemPrice) async {
    // Simple insert:
    await database.into(database.items).insert(
        ItemsCompanion(itemName: Value(itemName), itemPrice: Value(itemPrice)));
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
  Future<int> updateItem(int id, String itemName, int itemPrice) {
    return (database.update(database.items)
          ..where(
            (tbl) => tbl.itemId.equals(id),
          ))
        .write(
      ItemsCompanion(
        itemName: Value(itemName),
        itemPrice: Value(itemPrice),
      ),
    );
  }

  Future<int> updateItemsCompanion(int id, ItemsCompanion item) {
    return (database.update(database.items)
          ..where(
            (tbl) => tbl.itemId.equals(id),
          ))
        .write(item);
  }

  // 削除
  Future<int> deleteItem(int id) async {
    return await (database.delete(database.items)
          ..where(
            (tbl) => tbl.itemId.equals(id),
          ))
        .go();
  }

  // 商品の頭文字が「あかさたなはまら」の時に検索で使用
  Future<List<Item>> gojyuonItem5(List<String> itemNames) async {
    return await (database.select(database.items)
          ..where(
            (tbl) =>
                tbl.itemName.like("${itemNames[0]}%") |
                tbl.itemName.like("${itemNames[1]}%") |
                tbl.itemName.like("${itemNames[2]}%") |
                tbl.itemName.like("${itemNames[3]}%") |
                tbl.itemName.like("${itemNames[4]}%") |
                tbl.itemName.like("${itemNames[5]}%") |
                tbl.itemName.like("${itemNames[6]}%") |
                tbl.itemName.like("${itemNames[7]}%") |
                tbl.itemName.like("${itemNames[8]}%") |
                tbl.itemName.like("${itemNames[9]}%"),
          ))
        .get();
  }

  // 商品の頭文字が「やわ」の時に検索で使用
  Future<List<Item>> gojyuonItem3(List<String> itemNames) async {
    return await (database.select(database.items)
          ..where(
            (tbl) =>
                tbl.itemName.like("${itemNames[0]}%") |
                tbl.itemName.like("${itemNames[1]}%") |
                tbl.itemName.like("${itemNames[2]}%") |
                tbl.itemName.like("${itemNames[3]}%") |
                tbl.itemName.like("${itemNames[4]}%") |
                tbl.itemName.like("${itemNames[5]}%"),
          ))
        .get();
  }
}
