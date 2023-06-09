import "package:flutter/material.dart";

class ItemOrderDialog extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final orderNumController = TextEditingController();
  /*　引数の詳細
  title       ：ダイアログタイトル
  buttonText  ：ダイアログボタンタイトル
  */
  final String title;
  final String buttonText;

  ItemOrderDialog({
    super.key,
    required this.title,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
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
              // MEMO !RegExp(r"^\d+$").hasMatch(value)で数字以外を警告
            } else if (!RegExp(r"^\d+$").hasMatch(value)) {
              return "数字を入力してください";
            } else {
              return null;
            }
          },
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          // MEMO onPressedがnullの場合はダイアログを閉じる
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              debugPrint(orderNumController.text);
              Navigator.of(context).pop();
            }
          },
          child: Text(buttonText),
        ),
      ],
    );
  }
}
