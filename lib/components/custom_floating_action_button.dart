import "package:take_orders_app/constants/imports.dart";

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: FloatingActionButton.extended(
        backgroundColor: primaryColor,
        label: const Text(
          "営業終了",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 3.0,
          ),
        ),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("終了するときは長押ししてください"),
              // MEMO 1秒で閉じる
              duration: const Duration(seconds: 1),
              action: SnackBarAction(
                textColor: textColor,
                label: "OK",
                onPressed: () {
                  debugPrint("タップ");
                },
              ),
            ),
          );
        },
      ),
      onLongPress: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TopPage(),
          ),
        );
      },
    );
  }
}
