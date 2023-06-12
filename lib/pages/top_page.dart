import "package:flutter/material.dart";
import "package:take_orders_app/pages/data_mgmt_page.dart";
import "package:take_orders_app/pages/initial_select_page.dart";
import "package:take_orders_app/pages/input_page.dart";
import "package:take_orders_app/pages/order_list_page.dart";
import "package:take_orders_app/pages/order_page.dart";
import "package:take_orders_app/repository/items_repository.dart";

class TopPage extends StatelessWidget {
  TopPage({super.key});

  final itemRepo = ItemsRepository();
  // isSelected = false : OrderPage()
  // isSelected = true : InitialSelectPage() => OrderPage()
  final bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // MEMO 戻るボタンの動作を無効化する
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text("注文一覧（全商品）"),
                  // isSelectedで切り替え機能を
                  onPressed: () => isSelected
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const InitialSelectPage(),
                          ),
                        )
                      : itemRepo.getAllItems().then(
                          (allItems) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    OrderPage(searchData: allItems),
                              ),
                            );
                          },
                        ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text("注文一覧（五十音順）"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InitialSelectPage(),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text("商品登録"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InputPage(),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text("売上一覧"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderListPage(),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text("データ管理"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DataManagementPage(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
