import "package:flutter/material.dart";
import "package:take_orders_app/components/height_wide_button.dart";
import "package:take_orders_app/pages/google_drive_upload_page.dart";
import "package:take_orders_app/pages/initial_select_page.dart";
import "package:take_orders_app/pages/item_input_page.dart";
import "package:take_orders_app/pages/order_input_page.dart";
import "package:take_orders_app/pages/sales_list_page.dart";
import "package:take_orders_app/repository/items_repository.dart";

class TopPage extends StatelessWidget {
  TopPage({super.key});

  final itemRepo = ItemsRepository();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // MEMO 戻るボタンの動作を無効化する
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                HeightWideButton(
                  text: "注文一覧（五十音順）",
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InitialSelectPage(),
                    ),
                  ),
                ),
                HeightWideButton(
                  text: "注文一覧（全商品）",
                  onPressed: () => itemRepo.getAllAscItems().then(
                    (allItems) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              OrderInputPage(searchData: allItems),
                        ),
                      );
                    },
                  ),
                ),
                HeightWideButton(
                  text: "商品登録",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemInputPage(),
                      ),
                    );
                  },
                ),
                HeightWideButton(
                  text: "売上一覧",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SalesListPage(),
                      ),
                    );
                  },
                ),
                HeightWideButton(
                  text: "売上データアップロード",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GoogleDriveUploadPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
