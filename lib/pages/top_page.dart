import "package:flutter/material.dart";
import "package:take_orders_app/components/full_wide_button.dart";
import "package:take_orders_app/pages/data_mgmt_page.dart";
import "package:take_orders_app/pages/google_drive_upload_page.dart";
import "package:take_orders_app/pages/initial_select_page.dart";
import "package:take_orders_app/pages/item_input_page.dart";
import "package:take_orders_app/pages/order_input_page.dart";
import "package:take_orders_app/pages/google_drive_ops_page.dart";
import "package:take_orders_app/pages/sales_list_page.dart";
import "package:take_orders_app/repository/items_repository.dart";

class TopPage extends StatelessWidget {
  TopPage({super.key});

  final itemRepo = ItemsRepository();
  // isInitialSelected = false : OrderPage()
  // isInitialSelected = true : InitialSelectPage() => OrderPage()
  final bool isInitialSelected = false;
  // isGoogleDriveSelected = false : GoogleDriveOperationPage()非表示
  // isGoogleDriveSelected = true : GoogleDriveOperationPage()表示
  final bool isGoogleDriveSelected = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // MEMO 戻るボタンの動作を無効化する
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              FullWideButton(
                text: "注文一覧（全商品）",
                // isSelectedで切り替え機能を
                onPressed: () => isInitialSelected
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const InitialSelectPage(),
                        ),
                      )
                    : itemRepo.getAllAscItems().then(
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
              FullWideButton(
                text: "注文一覧（五十音順）",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InitialSelectPage(),
                    ),
                  );
                },
              ),
              FullWideButton(
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
              FullWideButton(
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
              FullWideButton(
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
              FullWideButton(
                text: "データ操作（管理画面）",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DataManagementPage(),
                    ),
                  );
                },
              ),
              isGoogleDriveSelected
                  ? FullWideButton(
                      text: "Google Drive 操作テスト（管理画面）",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GoogleDriveOpsPage(),
                          ),
                        );
                      },
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
