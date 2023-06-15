import "package:drift/drift.dart";
import "package:flutter/material.dart";
import "package:take_orders_app/db_utils/order_db.dart";
import "package:take_orders_app/pages/order_list_page.dart";
import "package:take_orders_app/repository/orders_repository.dart";

class ItemOrderDialog extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final orderNumController = TextEditingController();
  final orderRepo = OrdersRepository();
  /*　引数の詳細
  title      : ダイアログタイトル
  itemId     : テーブルitemsのitemId
  */
  final String title;
  final int itemId;

  ItemOrderDialog({
    super.key,
    required this.title,
    required this.itemId,
  });

  @override
  Widget build(BuildContext context) {
    // MEMO ダイアログを閉じる関数
    void closeDialog() {
      Future.delayed(Duration.zero, () {
        Navigator.of(context).pop();
      });
    }

    return AlertDialog(
      title: Text(
        title,
      ),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: orderNumController,
          keyboardType: TextInputType.number,
          maxLength: 2,
          // MEMO ダイアログが開いたときに自動でフォーカスを当てる
          autofocus: true,
          // MEMO エンターを押したときに実行される
          onFieldSubmitted: (_) {
            if (_formKey.currentState!.validate()) {
              debugPrint(orderNumController.text);
              Navigator.of(context).pop();
            }
          },
          decoration: InputDecoration(
            hintText: "注文数を入力してください",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          onChanged: (text) {
            orderNumController.text = text;
          },
          validator: (value) {
            // MEMO value!.isEmptyで未入力を警告
            if (value!.isEmpty) {
              return "注文数を入力してください";
              // MEMO 正規表現で0以上の数字以外を警告
            } else if (!RegExp(r"^[1-9]\d*$").hasMatch(value)) {
              return "0以上の数字を入力してください";
            } else {
              return null;
            }
          },
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              debugPrint(orderNumController.text);
              final order = OrdersCompanion(
                orderNum: Value(int.parse(orderNumController.text)),
                orderTime: Value(DateTime.now()),
                itemId: Value(itemId),
              );
              await orderRepo.addOrdersCompanion(order);
              closeDialog();
            }
          },
          child: const Text("続ける"),
        ),
        ElevatedButton(
          // MEMO onPressedがnullの場合はダイアログを閉じる
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final navigator = Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderListPage(),
                ),
              );
              debugPrint(orderNumController.text);
              final order = OrdersCompanion(
                orderNum: Value(int.parse(orderNumController.text)),
                orderTime: Value(DateTime.now()),
                itemId: Value(itemId),
              );
              await orderRepo.addOrdersCompanion(order);
              await navigator;
              closeDialog();
            }
          },
          child: const Text("受注一覧に戻る"),
        ),
      ],
    );
  }
}
