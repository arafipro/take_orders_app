import "package:flutter/material.dart";
import "package:take_orders_app/repository/orders_repository.dart";
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
              "データ関連",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    const Text("Items CSV出力"),
                    ElevatedButton(
                        onPressed: () async {
                          itemCreateCsv();
                        },
                        child: const Text("出力"))
                  ],
                ),
                Row(
                  children: [
                    const Text("Orders CSV出力"),
                    ElevatedButton(
                        onPressed: () async {
                          orderCreateCsv();
                        },
                        child: const Text("出力"))
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
