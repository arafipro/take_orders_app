import "package:take_orders_app/constants/imports.dart";

class DataManagementPage extends StatelessWidget {
  DataManagementPage({super.key});
  final orderRepo = OrdersRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                "データ操作（管理画面）",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Column(
                children: [
                  FullWideButton(
                    onPressed: () async {
                      itemCreateCsv();
                    },
                    text: "Items CSV出力",
                  ),
                  FullWideButton(
                    onPressed: () async {
                      orderCreateCsv();
                    },
                    text: "Orders CSV出力",
                  ),
                  FullWideButton(
                    onPressed: () async {
                      orderWItemCreateCsv();
                    },
                    text: "Orders with Item CSV出力",
                  ),
                  FullWideButton(
                    onPressed: () async {
                      checkCsvFiles();
                    },
                    text: "ファイル確認",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
