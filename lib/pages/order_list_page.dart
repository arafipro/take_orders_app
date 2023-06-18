import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:take_orders_app/components/adbanner.dart";
import "package:take_orders_app/db_utils/order_db.dart";
import "package:take_orders_app/pages/top_page.dart";
import "package:take_orders_app/repository/orders_with_item_repository.dart";

class OrderListPage extends StatefulWidget {
  const OrderListPage({super.key});

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  final owiRepo = OrdersWithItemRepository();
  bool isTextStrikeThrough = false;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat("yyyy/MM/dd");
    String today = formatter.format(now);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("$today - オーダー一覧"),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: StreamBuilder<List<OrdersWithItemData>>(
                  stream: owiRepo.watchAllOrdersWithItems(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                          columns: const [
                            // DataColumn(
                            //   label: Text(
                            //     "受注時間",
                            //     textAlign: TextAlign.center,
                            //   ),
                            // ),
                            DataColumn(
                              label: Text(
                                "商品名",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            // DataColumn(
                            //   label: Text(
                            //     "価格",
                            //     textAlign: TextAlign.end,
                            //   ),
                            // ),
                            DataColumn(
                              label: Text(
                                "注文数",
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "合計",
                              ),
                            ),
                          ],
                          rows: List<DataRow>.generate(
                            snapshot.data!.length,
                            (index) => DataRow(
                              selected: snapshot.data![index].orderCheck!,
                              onSelectChanged: (bool? value) {
                                owiRepo.updateOrdersWithItems(
                                  snapshot.data![index].id,
                                  value!,
                                );
                                // debugPrint(snapshot.data![index].id.toString());
                              },
                              cells: <DataCell>[
                                // DataCell(
                                //   Text(
                                //     "${snapshot.data![index].orderTime}",
                                //   ),
                                // ),
                                DataCell(
                                  Text(
                                    "${snapshot.data![index].itemName}",
                                  ),
                                ),
                                // DataCell(
                                //   Text(
                                //     "${snapshot.data![index].itemPrice}",
                                //     textAlign: TextAlign.end,
                                //   ),
                                // ),
                                DataCell(
                                  Text(
                                    "${snapshot.data![index].orderNum}",
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    "${snapshot.data![index].orderNum! * snapshot.data![index].itemPrice!}",
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            AdBanner()
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
    );
  }
}
