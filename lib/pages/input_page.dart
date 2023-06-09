import "package:flutter/material.dart";
import "package:take_orders_app/db_utils/order_db.dart";
import "package:take_orders_app/repository/items_repository.dart";

class InputPage extends StatelessWidget {
  InputPage({super.key});
  final itemRepo = ItemsRepository();
  final itemNameController = TextEditingController();
  final itemPriceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Row(
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
                            onChanged: (text) {
                              itemNameController.text = text;
                            },
                            // value!.isEmptyで未入力を警告
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "商品名を入力してください";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 120,
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
                          onChanged: (text) {
                            itemPriceController.text = text;
                          },
                          // value!.isEmptyで未入力を警告
                          // !RegExp(r"^\d+$").hasMatch(value)で数字以外を警告
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "未入力";
                            } else if (!RegExp(r"^\d+$").hasMatch(value)) {
                              return "数字を入力";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await itemRepo.addItem(
                        itemNameController.text,
                        int.parse(itemPriceController.text),
                      );
                      // 保存した後に入力を空欄に
                      itemNameController.text = "";
                      itemPriceController.text = "";
                    }
                  },
                  child: const Text(
                    "登録",
                  ),
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
                              label: Text(
                                "価格",
                                textAlign: TextAlign.end,
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "",
                              ),
                            ),
                          ],
                          rows: List<DataRow>.generate(
                            snapshot.data!.length,
                            (index) => DataRow(
                              cells: <DataCell>[
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
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red.shade600,
                                    ),
                                    onPressed: () async {
                                      await itemRepo.deleteItem(
                                        snapshot.data![index].itemId,
                                      );
                                    },
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
