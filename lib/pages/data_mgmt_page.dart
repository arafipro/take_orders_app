import "package:flutter/material.dart";
import "package:take_orders_app/components/full_wide_button.dart";
import "package:take_orders_app/repository/orders_repository.dart";
import "package:take_orders_app/utils/check_csv_files.dart";
import "package:take_orders_app/utils/create_csv_files.dart";

class DataManagementPage extends StatelessWidget {
  DataManagementPage({super.key});
  final orderRepo = OrdersRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
    );
  }
}
