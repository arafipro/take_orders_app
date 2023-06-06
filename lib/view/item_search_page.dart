import "package:flutter/material.dart";
import "package:take_orders_app/components/square_button.dart";

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
                "Order Page",
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
                    const SquareButton(text: "あ"),
                    const SquareButton(text: "か"),
                    const SquareButton(text: "さ"),
                    const SquareButton(text: "た"),
                    const SquareButton(text: "な"),
                    const SquareButton(text: "は"),
                    const SquareButton(text: "ま"),
                    const SquareButton(text: "や"),
                    const SquareButton(text: "ら"),
                    Container(),
                    const SquareButton(text: "わ"),
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
