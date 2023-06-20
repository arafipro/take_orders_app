import "package:take_orders_app/constants/imports.dart";

import "package:path/path.dart" as p;

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
  final header = ["id", "orderCheck", "orderNum", "orderTime", "itemId"];
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
    "orderCheck",
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
