import "package:take_orders_app/constants/imports.dart";

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
    return Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                ),
                child: Text(
                  "${checkToday()} 注文一覧",
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: StreamBuilder<List<OrdersWithItemData>>(
                    stream: owiRepo.watchAllOrdersWithItemsFromDate(
                      DateTime.now(),
                    ),
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
        floatingActionButton: const CustomFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
        bottomNavigationBar: const CustomBottomAppBar());
  }
}
