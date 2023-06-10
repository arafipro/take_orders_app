import "package:flutter/material.dart";
import "package:take_orders_app/db_utils/order_db.dart";
import "package:take_orders_app/repository/orders_with_item_repository.dart";

class OrderListPage extends StatelessWidget {
  OrderListPage({super.key});
  final orderRepo = OrdersWithItemRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: StreamBuilder<List<OrdersWithItemData>>(
            stream: orderRepo.watchAllOrdersWithItems(),
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
                          "受注時間",
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
    );
  }
}
