import "package:flutter/material.dart";
import "package:take_orders_app/components/initial_square_button.dart";
import "package:take_orders_app/db_utils/select_items.dart";
import "package:take_orders_app/pages/order_page.dart";
import "package:take_orders_app/pages/top_page.dart";

class InitialSelectPage extends StatelessWidget {
  const InitialSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // MEMO 戻るボタンの動作を無効化する
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const Text(
                "Initial Select Page",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return InitialSquareButton(
                      text: gojyuon[index][0],
                      onPressed: () {
                        gojyuonItem(index).then(
                          (searchItem) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderPage(
                                  searchData: searchItem,
                                  isBackButtonEffect: true,
                                ),
                              ),
                            );
                          },
                        );
                      },
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
