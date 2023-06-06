import "package:flutter/material.dart";

class SquareButton extends StatelessWidget {
  final String text;

  const SquareButton({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        // backgroundColor: Colors.teal[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // 四角形の角丸半径を指定
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 60,
        ),
      ),
      onPressed: () {
        debugPrint(text);
      },
    );
  }
}
