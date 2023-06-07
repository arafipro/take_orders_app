import "package:flutter/material.dart";
import "package:take_orders_app/db_utils/dummy_items.dart";
import "package:take_orders_app/pages/item_search_page.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 商品データがない場合、ダミー商品データを登録
  await dummyItem();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const ItemSearchPage(),
    );
  }
}
