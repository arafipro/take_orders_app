import "package:drift/drift.dart";
import "package:flutter/material.dart";
import "package:take_orders_app/db_utils/order_db.dart";
import "package:take_orders_app/repository/orders_repository.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final repoitem = OrdersRepository();
  await repoitem.addOrders([
    OrdersCompanion.insert(
      orderNum: const Value(1),
      orderTime: DateTime.now(),
      itemId: const Value(1),
    ),
    OrdersCompanion.insert(
      orderNum: const Value(2),
      orderTime: DateTime.now(),
      itemId: const Value(2),
    ),
  ]);

  // Simple select:
  final allItems = await repoitem.getAllOrders();
  debugPrint("Items in database: $allItems");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text("Hello World!"),
        ),
      ),
    );
  }
}
