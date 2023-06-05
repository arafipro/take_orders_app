import "package:flutter/material.dart";
import "package:drift/drift.dart";
import "package:take_orders_app/db_utils/order_db.dart";
import "package:take_orders_app/repository/items_repository.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final repoitem = ItemsRepository();
  await repoitem.addItems([
    ItemsCompanion.insert(
      itemName: "grape",
      itemPrice: const Value(100),
    ),
    ItemsCompanion.insert(
      itemName: "banana",
      itemPrice: const Value(200),
    ),
  ]);

  // Simple select:
  final allItems = await database.select(database.items).get();
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
