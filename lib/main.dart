import "package:flutter/material.dart";
import "package:flutter_localizations/flutter_localizations.dart";
// import "package:take_orders_app/db_utils/dummy_data.dart";
import "package:take_orders_app/pages/top_page.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // MEMO 商品データがない場合、ダミー商品データを登録
  // await dummyItem();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("ja", "JP"),
      ],
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: TopPage(),
    );
  }
}
