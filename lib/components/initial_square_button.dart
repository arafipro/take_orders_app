import "package:flutter/material.dart";

class InitialSquareButton extends StatelessWidget {
  final String text;
  final dynamic onPressed;

  const InitialSquareButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal[50],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // 四角形の角丸半径を指定
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 60,
        ),
      ),
    );
  }
}
