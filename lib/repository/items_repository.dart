import "package:take_orders_app/constants/imports.dart";

import "package:drift/drift.dart";

final dbItem = OrderDatabase();

class ItemsRepository {
  // MEMO 全検索
  Stream<List<Item>> watchAllItems() {
    return (dbItem.select(dbItem.items)).watch();
  }

  Future<List<Item>> getAllItems() async {
    return await dbItem.select(dbItem.items).get();
  }

  // MEMO 全検索昇順
  Stream<List<Item>> watchAllAscItems() {
    return (dbItem.select(dbItem.items)
          ..orderBy([(t) => OrderingTerm.asc(t.itemName)]))
        .watch();
  }

  Future<List<Item>> getAllAscItems() async {
    return await (dbItem.select(dbItem.items)
          ..orderBy([(t) => OrderingTerm.asc(t.itemName)]))
        .get();
  }

  // MEMO 一件登録
  Future<void> addItem(String itemName, int itemPrice) async {
    await dbItem.into(dbItem.items).insert(
        ItemsCompanion(itemName: Value(itemName), itemPrice: Value(itemPrice)));
  }

  Future<void> addItemsCompanion(ItemsCompanion item) async {
    await dbItem.into(dbItem.items).insert(item);
  }

  // MEMO 複数登録
  Future<void> addItems(List<ItemsCompanion> items) async {
    await dbItem.batch((batch) {
      batch.insertAll(dbItem.items, items);
    });
  }

  // MEMO 更新
  Future<int> updateItem(int id, String itemName, int itemPrice) {
    return (dbItem.update(dbItem.items)
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
    return (dbItem.update(dbItem.items)
          ..where(
            (tbl) => tbl.itemId.equals(id),
          ))
        .write(item);
  }

  // MEMO 削除
  Future<int> deleteItem(int id) async {
    return await (dbItem.delete(dbItem.items)
          ..where(
            (tbl) => tbl.itemId.equals(id),
          ))
        .go();
  }

  // MEMO 商品の頭文字gojyuonInitialが「あかさたなはまら」の時に検索で使用
  // MEMO 検索条件を正規表現で
  Future<List<Item>> gojyuonInitial5(List<String> gojyuonInitial) async {
    return await (dbItem.select(dbItem.items)
          ..where(
            (tbl) => tbl.itemName.regexp(
              "^(${gojyuonInitial[0]}|${gojyuonInitial[1]}|${gojyuonInitial[2]}|${gojyuonInitial[3]}|${gojyuonInitial[4]}|${gojyuonInitial[5]}|${gojyuonInitial[6]}|${gojyuonInitial[7]}|${gojyuonInitial[8]}|${gojyuonInitial[9]}).+",
            ),
          ))
        .get();
  }

  // MEMO 検索条件を論理演算子で
  // Future<List<Item>> gojyuonInitial5(List<String> gojyuonInitial) async {
  //   return await (dbItem.select(dbItem.items)
  //         ..where(
  //           (tbl) =>
  //               tbl.itemName.like("${gojyuonInitial[0]}%") |
  //               tbl.itemName.like("${gojyuonInitial[1]}%") |
  //               tbl.itemName.like("${gojyuonInitial[2]}%") |
  //               tbl.itemName.like("${gojyuonInitial[3]}%") |
  //               tbl.itemName.like("${gojyuonInitial[4]}%") |
  //               tbl.itemName.like("${gojyuonInitial[5]}%") |
  //               tbl.itemName.like("${gojyuonInitial[6]}%") |
  //               tbl.itemName.like("${gojyuonInitial[7]}%") |
  //               tbl.itemName.like("${gojyuonInitial[8]}%") |
  //               tbl.itemName.like("${gojyuonInitial[9]}%"),
  //         ))
  //       .get();
  // }

  // MEMO 商品の頭文字が「やわ」の時に検索で使用
  // MEMO 検索条件を正規表現で
  Future<List<Item>> gojyuonInitial3(List<String> gojyuonInitial) async {
    return await (dbItem.select(dbItem.items)
          ..where(
            (tbl) => tbl.itemName.regexp(
              "^(${gojyuonInitial[0]}|${gojyuonInitial[1]}|${gojyuonInitial[2]}|${gojyuonInitial[3]}|${gojyuonInitial[4]}|${gojyuonInitial[5]}).+",
            ),
          ))
        .get();
  }

  // MEMO 検索条件を論理演算子で
  // Future<List<Item>> gojyuonInitial3(List<String> gojyuonInitial) async {
  //   return await (dbItem.select(dbItem.items)
  //         ..where(
  //           (tbl) =>
  //               tbl.itemName.like("${gojyuonInitial[0]}%") |
  //               tbl.itemName.like("${gojyuonInitial[1]}%") |
  //               tbl.itemName.like("${gojyuonInitial[2]}%") |
  //               tbl.itemName.like("${gojyuonInitial[3]}%") |
  //               tbl.itemName.like("${gojyuonInitial[4]}%") |
  //               tbl.itemName.like("${gojyuonInitial[5]}%"),
  //         ))
  //       .get();
  // }
}
