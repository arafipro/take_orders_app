import "package:drift/drift.dart";
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

  // MEMO 更新
  Future<int> updateOrdersWithItems(
      int id, bool orderCheck) {
    return (dbOrderWItem.update(dbOrderWItem.orders)
          ..where(
            (tbl) => tbl.id.equals(id),
          ))
        .write(
      OrdersCompanion(
        orderCheck: Value(orderCheck),
      ),
    );
  }
}
