import "package:take_orders_app/constants/imports.dart";

class TopDevPage extends StatelessWidget {
  TopDevPage({super.key});

  final itemRepo = ItemsRepository();

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
              FullWideButton(
                text: "注文一覧（五十音順）",
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InitialSelectPage(),
                  ),
                ),
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
              FullWideButton(
                text: "Google Drive 操作テスト（管理画面）",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GoogleDriveOpsPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
