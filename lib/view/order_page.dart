import "package:flutter/material.dart";
import "package:take_orders_app/db_utils/order_db.dart";

class OrderPage extends StatelessWidget {
  final List<Item> searchData;

  const OrderPage({
    super.key,
    required this.searchData,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true, // 戻るボタンの動作を無効化する
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
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Text(searchData[index].itemName),
                        Text(searchData[index].itemPrice.toString()),
                      ],
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
                  content: const Text("長押しして終了してください"),
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
            debugPrint("営業終了");
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
        bottomNavigationBar: BottomAppBar(
          child: Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              "終了するときは長押ししてください",
            ),
          ),
        ),
      ),
    );
  }
}
