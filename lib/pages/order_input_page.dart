import "package:flutter/material.dart";
import "package:take_orders_app/components/item_text_card.dart";
import "package:take_orders_app/components/item_order_dialog.dart";
import "package:take_orders_app/db_utils/order_db.dart";
import "package:take_orders_app/pages/top_page.dart";

class OrderInputPage extends StatelessWidget {
  /*　引数の詳細
  searchData  : 検索したItemのデータ
  isBackButtonEffect : 戻るボタンの動作
  */
  final List<Item> searchData;
  // 戻るボタンの動作を無効化する
  // isBackButtonEffect = true : 戻るボタンを有効
  // isBackButtonEffect = false : 戻るボタンを無効
  final bool isBackButtonEffect;

  const OrderInputPage({
    super.key,
    required this.searchData,
    this.isBackButtonEffect = false,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // MEMO 戻るボタンの動作を無効化する
      onWillPop: () async => isBackButtonEffect,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const Text(
                "Order Page",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              Expanded(
                child: GridView.builder(
                  primary: true,
                  padding: const EdgeInsets.all(10),
                  itemCount: searchData.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 2.0,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ItemTextCard(
                        itemName: searchData[index].itemName!,
                        itemPrice: searchData[index].itemPrice!,
                        onTap: () => {
                          showDialog<void>(
                            context: context,
                            builder: (_) {
                              return ItemOrderDialog(
                                title: "${searchData[index].itemName}",
                                itemId: searchData[index].itemId,
                              );
                            },
                          )
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: GestureDetector(
          child: FloatingActionButton.extended(
            label: const Text("営業終了"),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("終了するときは長押ししてください"),
                  // MEMO 1秒で閉じる
                  duration: const Duration(seconds: 1),
                  action: SnackBarAction(
                    label: "OK",
                    onPressed: () {
                      debugPrint("タップ");
                    },
                  ),
                ),
              );
            },
          ),
          onLongPress: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TopPage(),
              ),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
        bottomNavigationBar: BottomAppBar(
          child: Container(
            alignment: Alignment.centerLeft,
            child: const Text("終了するときは長押ししてください"),
          ),
        ),
      ),
    );
  }
}
