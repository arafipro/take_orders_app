import "package:flutter/material.dart";
import "package:take_orders_app/repository/orders_repository.dart";
import "package:take_orders_app/utils/check_files.dart";
import "package:take_orders_app/utils/create_csv.dart";

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
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                        itemCreateCsv();
                      },
                      child: const Text("Items CSV出力")),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                        orderCreateCsv();
                      },
                      child: const Text("Orders CSV出力")),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                        orderWItemCreateCsv();
                      },
                      child: const Text("Orders with Item CSV出力")),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                        checkFiles();
                      },
                      child: const Text("ファイル確認")),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
