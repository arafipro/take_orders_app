import "package:take_orders_app/constants/imports.dart";

class HeightWideButton extends StatelessWidget {
  final String text;
  final dynamic onPressed;

  const HeightWideButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        height: 100,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              primaryColor,
            ),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              letterSpacing: 2.0,
              fontWeight: FontWeight.w600,
              color: textColor,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
