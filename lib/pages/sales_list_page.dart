import "package:take_orders_app/constants/imports.dart";

class SalesListPage extends StatelessWidget {
  SalesListPage({super.key});
  final owiRepo = OrdersWithItemRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                top: 8.0,
              ),
              child: Text(
                "売上一覧",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
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
                            DataColumn(
                              label: Text(
                                "受注日時",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "商品名",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "価格",
                                textAlign: TextAlign.end,
                              ),
                            ),
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
                              cells: <DataCell>[
                                DataCell(
                                  Text(
                                    "${snapshot.data![index].orderTime}",
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    "${snapshot.data![index].itemName}",
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    "${snapshot.data![index].itemPrice}",
                                    textAlign: TextAlign.end,
                                  ),
                                ),
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
    );
  }
}
