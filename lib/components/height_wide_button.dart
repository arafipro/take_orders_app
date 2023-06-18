import "package:flutter/material.dart";

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
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
