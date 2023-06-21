import "package:take_orders_app/constants/imports.dart";

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
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          // MEMO 四角形の角丸半径を指定
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 60,
          color: textColor,
        ),
      ),
    );
  }
}
