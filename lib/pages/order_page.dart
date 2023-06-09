import "package:flutter/material.dart";
import "package:take_orders_app/components/item_text_card.dart";
import "package:take_orders_app/db_utils/order_db.dart";
import "package:take_orders_app/pages/top_page.dart";

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
                    childAspectRatio: 2.0,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ItemTextCard(
                        itemName: "${searchData[index].itemName}",
                        itemPrice: searchData[index].itemPrice!,
                        onTap: () => {
                          debugPrint(searchData[index].itemName),
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TopPage(),
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
