import "package:drift/drift.dart";
import "package:take_orders_app/models/items.dart";
import "package:take_orders_app/models/orders.dart";

abstract class OrdersWithItem extends View {
  Orders get orders;
  Items get items;

  @override
  Query as() => select([
        orders.id,
        orders.orderNum,
        orders.orderTime,
        items.itemName,
        items.itemPrice
      ])
          .from(orders)
          .join([innerJoin(items, items.itemId.equalsExp(orders.itemId))]);
}
