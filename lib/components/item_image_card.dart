import "package:flutter/material.dart";

class ItemImageCard extends StatelessWidget {
  final String itemName;
  final int itemPrice;
  final String itemImage;
  final dynamic onTap;

  const ItemImageCard({
    super.key,
    required this.itemName,
    required this.itemPrice,
    required this.itemImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                "images/coffee.jpg",
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                itemName,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                "¥${itemPrice.toString()}",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
