import "package:flutter/material.dart";
import "package:take_orders_app/db_utils/dummy_items.dart";
import "package:take_orders_app/db_utils/select_items.dart";
import "package:take_orders_app/view/order_page.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 商品データがない場合、ダミー商品データを登録
  await dummyItem();

  // 五十音順検索テスト用
  final gojyuonItems = await gojyuonItem(7);
  debugPrint("gojyuonItems: $gojyuonItems");

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
      home: const OrderPage(),
    );
  }
}
