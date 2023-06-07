import "package:flutter/material.dart";
import "package:take_orders_app/components/square_button.dart";
import "package:take_orders_app/db_utils/select_items.dart";

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
                      onPressed: () async {
                        await gojyuonItem(0);
                      },
                    ),
                    SquareButton(
                      text: "か",
                      onPressed: () async {
                        await gojyuonItem(1);
                      },
                    ),
                    SquareButton(
                      text: "さ",
                      onPressed: () async {
                        await gojyuonItem(2);
                      },
                    ),
                    SquareButton(
                      text: "た",
                      onPressed: () async {
                        await gojyuonItem(3);
                      },
                    ),
                    SquareButton(
                      text: "な",
                      onPressed: () async {
                        await gojyuonItem(4);
                      },
                    ),
                    SquareButton(
                      text: "は",
                      onPressed: () async {
                        await gojyuonItem(5);
                      },
                    ),
                    SquareButton(
                      text: "ま",
                      onPressed: () async {
                        await gojyuonItem(6);
                      },
                    ),
                    SquareButton(
                      text: "や",
                      onPressed: () async {
                        await gojyuonItem(7);
                      },
                    ),
                    SquareButton(
                      text: "ら",
                      onPressed: () async {
                        await gojyuonItem(8);
                      },
                    ),
                    Container(),
                    SquareButton(
                      text: "わ",
                      onPressed: () async {
                        await gojyuonItem(9);
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
