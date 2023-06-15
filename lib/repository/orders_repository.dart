import "package:drift/drift.dart";
import "package:take_orders_app/db_utils/order_db.dart";

final dbOrder = OrderDatabase();

class OrdersRepository {
  // MEMO 全検索
  Stream<List<Order>> watchAllOrders() {
    return (dbOrder.select(dbOrder.orders)).watch();
  }

  Future<List<Order>> getAllOrders() async {
    return await dbOrder.select(dbOrder.orders).get();
  }

  // MEMO 一件登録
  Future<void> addOrder(
      bool orderCheck, int orderNum, DateTime orderTime, int itemId) async {
    await dbOrder.into(dbOrder.orders).insert(
          OrdersCompanion(
            orderCheck: Value(orderCheck),
            orderNum: Value(orderNum),
            orderTime: Value(orderTime),
            itemId: Value(itemId),
          ),
        );
  }

  Future<void> addOrdersCompanion(OrdersCompanion order) async {
    await dbOrder.into(dbOrder.orders).insert(order);
  }

  // MEMO 複数登録
  Future<void> addOrders(List<OrdersCompanion> orders) async {
    await dbOrder.batch((batch) {
      batch.insertAll(dbOrder.orders, orders);
    });
  }

  // MEMO 更新
  Future<int> updateOrder(
      int id, int orderNum, DateTime orderTime, int itemId) {
    return (dbOrder.update(dbOrder.orders)
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
    return (dbOrder.update(dbOrder.orders)
          ..where(
            (tbl) => tbl.id.equals(id),
          ))
        .write(order);
  }

  // MEMO 削除
  Future<int> deleteOrder(int id) async {
    return await (dbOrder.delete(dbOrder.orders)
          ..where(
            (tbl) => tbl.id.equals(id),
          ))
        .go();
  }
}
