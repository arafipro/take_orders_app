import "package:take_orders_app/db_utils/order_db.dart";

final dbOrderWItem = OrderDatabase();

class OrdersWithItemRepository {
  // MEMO 全検索
  Stream<List<OrdersWithItemData>> watchAllOrdersWithItems() {
    return dbOrderWItem.select(dbOrderWItem.ordersWithItem).watch();
  }

  Future<List<OrdersWithItemData>> getAllOrdersWithItems() async {
    return await dbOrderWItem.select(dbOrderWItem.ordersWithItem).get();
  }
}
