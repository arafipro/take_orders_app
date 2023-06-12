import "dart:io";

import "package:csv/csv.dart";
import "package:flutter/material.dart";
import "package:path_provider/path_provider.dart";
import "package:path/path.dart" as p;
import "package:take_orders_app/repository/items_repository.dart";
import "package:take_orders_app/repository/orders_repository.dart";

final itemRepo = ItemsRepository();
final orderRepo = OrdersRepository();

itemCreateCsv() async {
  final itemHeader = ["itemId", "itemName", "itemPrice"];
  final itemResults = await itemRepo.getAllItems();
  final itemRows = itemResults.map((u) => u.itemToCsvFormat()).toList();
  final csv = const ListToCsvConverter().convert(
    [itemHeader, ...itemRows],
  );
  final directory = await getApplicationDocumentsDirectory();
  debugPrint(directory.path);
  final file = File(p.join(directory.path, "item.csv"));
  debugPrint("$file");
  if (!await file.exists()) {
    await file.create(recursive: true);
    debugPrint("Flie create");
  }
  await file.writeAsString(csv);
  debugPrint("Item:$csv");
}

orderCreateCsv() async {
  final orderHeader = ["id", "orderNum", "orderTime", "itemId"];
  final orderResults = await orderRepo.getAllOrders();
  final orderRows = orderResults.map((u) => u.orderToCsvFormat()).toList();
  final csv = const ListToCsvConverter().convert(
    [orderHeader, ...orderRows],
  );
  final directory = await getApplicationDocumentsDirectory();
  debugPrint(directory.path);
  final file = File(p.join(directory.path, "order.csv"));
  debugPrint("$file");
  if (!await file.exists()) {
    await file.create(recursive: true);
    debugPrint("Flie create");
  }
  await file.writeAsString(csv);
  debugPrint("Order:$csv");
}
