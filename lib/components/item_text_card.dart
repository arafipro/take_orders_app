import "package:flutter/material.dart";

class ItemTextCard extends StatelessWidget {
  final String itemName;
  final int? itemPrice;
  final dynamic onTap;

  const ItemTextCard({
    super.key,
    required this.itemName,
    required this.itemPrice,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                itemName,
                overflow: TextOverflow.clip,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                "¥${itemPrice.toString()}",
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
