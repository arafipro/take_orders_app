import "package:flutter/material.dart";

class InputPage extends StatelessWidget {
  const InputPage({super.key});

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
                  onPressed: () {},
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: DataTable(
                  columns: const [
                    DataColumn(
                      label: Text(
                        "商品名",
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "価格",
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "",
                      ),
                    ),
                  ],
                  rows: const [
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Text(
                            "itemName1",
                          ),
                        ),
                        DataCell(
                          Text(
                            "itemPrice1",
                          ),
                        ),
                        DataCell(
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: null,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
