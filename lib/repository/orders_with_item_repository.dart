import "package:take_orders_app/db_utils/order_db.dart";

final database = OrderDatabase();

class OrdersWithItemRepository {
  // MEMO 全検索
  Stream<List<OrdersWithItemData>> watchAllOrdersWithItems() {
    return database.select(database.ordersWithItem).watch();
  }

  Future<List<OrdersWithItemData>> getAllOrdersWithItems() async {
    return await database.select(database.ordersWithItem).get();
  }
}
