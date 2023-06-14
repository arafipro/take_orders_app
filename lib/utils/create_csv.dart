import "dart:io";

import "package:csv/csv.dart";
import "package:flutter/material.dart";
import "package:path_provider/path_provider.dart";
import "package:path/path.dart" as p;
import "package:take_orders_app/repository/items_repository.dart";
import "package:take_orders_app/repository/orders_repository.dart";
import "package:take_orders_app/repository/orders_with_item_repository.dart";

final itemRepo = ItemsRepository();
final orderRepo = OrdersRepository();
final owiRepo = OrdersWithItemRepository();

Future<void> itemCreateCsv() async {
  final header = ["itemId", "itemName", "itemPrice"];
  final results = await itemRepo.getAllItems();
  final rows = results.map((u) => u.itemToCsvFormat()).toList();
  final csv = const ListToCsvConverter().convert(
    [header, ...rows],
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

Future<void> orderCreateCsv() async {
  final header = ["id", "orderNum", "orderTime", "itemId"];
  final results = await orderRepo.getAllOrders();
  final rows = results.map((u) => u.orderToCsvFormat()).toList();
  final csv = const ListToCsvConverter().convert(
    [header, ...rows],
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

Future<void> orderWItemCreateCsv() async {
  final header = [
    "id",
    "orderNum",
    "orderTime",
    "itemName",
    "itemPrice"
  ];
  final results = await owiRepo.getAllOrdersWithItems();
  final rows = results.map((u) => u.owiToCsvFormat()).toList();
  final csv = const ListToCsvConverter().convert(
    [header, ...rows],
  );
  final directory = await getApplicationDocumentsDirectory();
  debugPrint(directory.path);
  final file = File(p.join(directory.path, "order_with_item.csv"));
  debugPrint("$file");
  if (!await file.exists()) {
    await file.create(recursive: true);
    debugPrint("Flie create");
  }
  await file.writeAsString(csv);
  debugPrint("OrderWItem:$csv");
}
