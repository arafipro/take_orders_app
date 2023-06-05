import "package:flutter/material.dart";
import "package:take_orders_app/db_utils/order_db.dart";
import "package:take_orders_app/repository/items_repository.dart";

class InputPage extends StatelessWidget {
  InputPage({super.key});
  final itemRepo = ItemsRepository();
  final itemNameController = TextEditingController();
  final itemPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 2.0),
                        child: TextFormField(
                          controller: itemNameController,
                          keyboardType: TextInputType.text,
                          maxLength: 50,
                          decoration: InputDecoration(
                            hintText: "商品名",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: TextFormField(
                        controller: itemPriceController,
                        keyboardType: TextInputType.number,
                        maxLength: 5,
                        decoration: InputDecoration(
                          hintText: "価格",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text(
                    "仮登録",
                  ),
                  onPressed: () async {
                    await itemRepo.addItem(
                      itemNameController.text,
                      int.parse(itemPriceController.text),
                    );
                    // 保存した後に入力を空欄に
                    itemNameController.text = "";
                    itemPriceController.text = "";
                  },
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: StreamBuilder<List<Item>>(
                      stream: itemRepo.watchAllItems(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return DataTable(
                          columns: const [
                            DataColumn(
                              label: Text(
                                "商品名",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 50,
                                child: Text(
                                  "価格",
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 10,
                                child: Text(
                                  "",
                                ),
                              ),
                            ),
                          ],
                          rows: List<DataRow>.generate(
                            snapshot.data!.length,
                            (index) => DataRow(
                              cells: <DataCell>[
                                DataCell(
                                  Text(
                                    snapshot.data![index].itemName,
                                  ),
                                ),
                                DataCell(
                                  SizedBox(
                                    width: 50,
                                    child: Text(
                                      snapshot.data![index].itemPrice
                                          .toString(),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  SizedBox(
                                    width: 10,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red.shade600,
                                      ),
                                      onPressed: () async {
                                        await itemRepo.deleteItem(
                                            snapshot.data![index].itemId);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
