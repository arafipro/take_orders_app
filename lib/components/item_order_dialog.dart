import "package:take_orders_app/constants/imports.dart";

import "package:drift/drift.dart";

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
      backgroundColor: backgroundColor,
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
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(
                color: primaryColor,
                width: 3.0,
              ),
            ),
            labelText: "注文数",
            labelStyle: const TextStyle(
              color: primaryColor,
            ),
          ),
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
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              primaryColor,
            ),
          ),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              debugPrint(orderNumController.text);
              final order = OrdersCompanion(
                orderCheck: const Value(false),
                orderNum: Value(int.parse(orderNumController.text)),
                orderTime: Value(DateTime.now()),
                itemId: Value(itemId),
              );
              await orderRepo.addOrdersCompanion(order);
              closeDialog();
            }
          },
          child: const Text("OK"),
        ),
        // MEMO 実機テストで画面遷移後に表示されない
        // ElevatedButton(
        //   // MEMO onPressedがnullの場合はダイアログを閉じる
        //   onPressed: () async {
        //     if (_formKey.currentState!.validate()) {
        //       final navigator = Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => const OrderListPage(),
        //         ),
        //       );
        //       debugPrint(orderNumController.text);
        //       final order = OrdersCompanion(
        //         orderCheck: const Value(false),
        //         orderNum: Value(int.parse(orderNumController.text)),
        //         orderTime: Value(DateTime.now()),
        //         itemId: Value(itemId),
        //       );
        //       await orderRepo.addOrdersCompanion(order);
        //       await navigator;
        //       closeDialog();
        //     }
        //   },
        //   child: const Text("受注一覧に戻る"),
        // ),
      ],
    );
  }
}
