import "package:take_orders_app/constants/imports.dart";

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
              FullWideButton(
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
