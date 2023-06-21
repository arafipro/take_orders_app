import "package:take_orders_app/constants/imports.dart";

class ItemInputPage extends StatelessWidget {
  ItemInputPage({super.key});
  final itemRepo = ItemsRepository();
  final itemNameController = TextEditingController();
  final itemPriceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: itemNameController,
                            keyboardType: TextInputType.text,
                            maxLength: 20,
                            decoration: InputDecoration(
                              hintText: "商品名（カタカナ）",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                  color: primaryColor,
                                  width: 3.0,
                                ),
                              ),
                              labelText: "商品名（カタカナ）",
                              labelStyle: const TextStyle(
                                color: primaryColor,
                              ),
                            ),
                            // MEMO value!.isEmptyで未入力を警告
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "商品名を入力してください";
                              } else if (!RegExp(r"^[\u30A0-\u30FF]+$")
                                  .hasMatch(value)) {
                                return "カタカナで入力してください";
                              } else {
                                return null;
                              }
                            },
                          ),
                          TextFormField(
                            controller: itemPriceController,
                            keyboardType: TextInputType.number,
                            maxLength: 5,
                            decoration: InputDecoration(
                              hintText: "価格",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                  color: primaryColor,
                                  width: 3.0,
                                ),
                              ),
                              labelText: "価格",
                              labelStyle: const TextStyle(
                                color: primaryColor,
                              ),
                            ),
                            // MEMO value!.isEmptyで未入力を警告
                            // MEMO !RegExp(r"^\d+$").hasMatch(value)で数字以外を警告
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "価格を入力してください";
                              } else if (!RegExp(r"^\d+$").hasMatch(value)) {
                                return "数字を入力してください";
                              } else {
                                return null;
                              }
                            },
                          ),
                          FullWideButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await itemRepo.addItem(
                                  itemNameController.text,
                                  int.parse(itemPriceController.text),
                                );
                                // MEMO 保存した後に入力を空欄に
                                itemNameController.text = "";
                                itemPriceController.text = "";
                              }
                            },
                            text: "登録",
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: StreamBuilder<List<Item>>(
                        stream: itemRepo.watchAllAscItems(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AdBanner()
          ],
        ),
      ),
    );
  }
}
