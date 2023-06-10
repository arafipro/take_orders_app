import "package:drift/drift.dart";
import "package:take_orders_app/db_utils/order_db.dart";

final database = OrderDatabase();

class OrdersRepository {
  // MEMO 全検索
  Stream<List<Order>> watchAllOrders() {
    return (database.select(database.orders)).watch();
  }

  Future<List<Order>> getAllOrders() async {
    return await database.select(database.orders).get();
  }

  // MEMO 一件登録
  Future<void> addOrder(int orderNum, DateTime orderTime, int itemId) async {
    await database.into(database.orders).insert(
          OrdersCompanion(
            orderNum: Value(orderNum),
            orderTime: Value(orderTime),
            itemId: Value(itemId),
          ),
        );
  }

  Future<void> addOrdersCompanion(OrdersCompanion order) async {
    await database.into(database.orders).insert(order);
  }

  // MEMO 複数登録
  Future<void> addOrders(List<OrdersCompanion> orders) async {
    await database.batch((batch) {
      batch.insertAll(database.orders, orders);
    });
  }

  // MEMO 更新
  Future<int> updateOrder(
      int id, int orderNum, DateTime orderTime, int itemId) {
    return (database.update(database.orders)
          ..where(
            (tbl) => tbl.id.equals(id),
          ))
        .write(
      OrdersCompanion(
        orderNum: Value(orderNum),
        orderTime: Value(orderTime),
        itemId: Value(itemId),
      ),
    );
  }

  Future<int> updateOrdersCompanion(int id, OrdersCompanion order) {
    return (database.update(database.orders)
          ..where(
            (tbl) => tbl.id.equals(id),
          ))
        .write(order);
  }

  // MEMO 削除
  Future<int> deleteOrder(int id) async {
    return await (database.delete(database.orders)
          ..where(
            (tbl) => tbl.id.equals(id),
          ))
        .go();
  }
}
