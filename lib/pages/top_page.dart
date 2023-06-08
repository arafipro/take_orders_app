import "package:flutter/material.dart";
import "package:take_orders_app/pages/initial_select_page.dart";
import "package:take_orders_app/pages/input_page.dart";

class TopPage extends StatelessWidget {
  const TopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // 戻るボタンの動作を無効化する
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text("営業開始"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InitialSelectPage(),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text("商品登録"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InputPage(),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text("売上集計"),
                  onPressed: () {
                    debugPrint("売上集計");
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
