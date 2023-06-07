import "package:flutter/material.dart";
import "package:take_orders_app/components/square_button.dart";
import "package:take_orders_app/db_utils/select_items.dart";
import "package:take_orders_app/view/order_page.dart";

class ItemSearchPage extends StatelessWidget {
  const ItemSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // 戻るボタンの動作を無効化する
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const Text(
                "Order Select Page",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              Expanded(
                child: GridView.count(
                  primary: true,
                  padding: const EdgeInsets.all(10),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3,
                  children: <Widget>[
                    SquareButton(
                      text: "あ",
                      onPressed: () {
                        gojyuonItem(0).then((searchItem) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OrderPage(searchData: searchItem),
                            ),
                          );
                        });
                      },
                    ),
                    SquareButton(
                      text: "か",
                      onPressed: () {
                        gojyuonItem(1).then((searchItem) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OrderPage(searchData: searchItem),
                            ),
                          );
                        });
                      },
                    ),
                    SquareButton(
                      text: "さ",
                      onPressed: () {
                        gojyuonItem(2).then((searchItem) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OrderPage(searchData: searchItem),
                            ),
                          );
                        });
                      },
                    ),
                    SquareButton(
                      text: "た",
                      onPressed: () {
                        gojyuonItem(3).then((searchItem) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OrderPage(searchData: searchItem),
                            ),
                          );
                        });
                      },
                    ),
                    SquareButton(
                      text: "な",
                      onPressed: () {
                        gojyuonItem(4).then((searchItem) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OrderPage(searchData: searchItem),
                            ),
                          );
                        });
                      },
                    ),
                    SquareButton(
                      text: "は",
                      onPressed: () {
                        gojyuonItem(5).then((searchItem) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OrderPage(searchData: searchItem),
                            ),
                          );
                        });
                      },
                    ),
                    SquareButton(
                      text: "ま",
                      onPressed: () {
                        gojyuonItem(6).then((searchItem) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OrderPage(searchData: searchItem),
                            ),
                          );
                        });
                      },
                    ),
                    SquareButton(
                      text: "や",
                      onPressed: () {
                        gojyuonItem(7).then((searchItem) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OrderPage(searchData: searchItem),
                            ),
                          );
                        });
                      },
                    ),
                    SquareButton(
                      text: "ら",
                      onPressed: () {
                        gojyuonItem(8).then((searchItem) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OrderPage(searchData: searchItem),
                            ),
                          );
                        });
                      },
                    ),
                    Container(),
                    SquareButton(
                      text: "わ",
                      onPressed: () {
                        gojyuonItem(9).then((searchItem) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OrderPage(searchData: searchItem),
                            ),
                          );
                        });
                      },
                    ),
                    Container()
                  ],
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
