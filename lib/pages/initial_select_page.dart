import "package:take_orders_app/constants/imports.dart";

class InitialSelectPage extends StatelessWidget {
  const InitialSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // MEMO 戻るボタンの動作を無効化する
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              const Text(
                "商品選択",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: FullWideButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderListPage(),
                      ),
                    );
                  },
                  text: "オーダー表へ",
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
                                builder: (context) => OrderInputPage(
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
              AdBanner(),
            ],
          ),
        ),
        floatingActionButton: const CustomFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
        bottomNavigationBar: const CustomBottomAppBar(),
      ),
    );
  }
}
