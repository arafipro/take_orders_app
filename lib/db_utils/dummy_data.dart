import "package:drift/drift.dart";
import "package:flutter/material.dart";
import "package:take_orders_app/db_utils/order_db.dart";
import "package:take_orders_app/repository/items_repository.dart";
import "package:take_orders_app/repository/orders_repository.dart";

// MEMO ダミー商品データ
const dummyItems = [
  ItemsCompanion(itemName: Value("ハンバーガー"), itemPrice: Value(500)),
  ItemsCompanion(itemName: Value("タコス"), itemPrice: Value(400)),
  ItemsCompanion(itemName: Value("ピザ"), itemPrice: Value(800)),
  ItemsCompanion(itemName: Value("サンドイッチ"), itemPrice: Value(350)),
  ItemsCompanion(itemName: Value("フライドポテト"), itemPrice: Value(300)),
  ItemsCompanion(itemName: Value("テイコス"), itemPrice: Value(450)),
  ItemsCompanion(itemName: Value("サラダ"), itemPrice: Value(600)),
  ItemsCompanion(itemName: Value("ギョウザ"), itemPrice: Value(350)),
  ItemsCompanion(itemName: Value("カレー"), itemPrice: Value(700)),
  ItemsCompanion(itemName: Value("アイスクリーム"), itemPrice: Value(250)),
  ItemsCompanion(itemName: Value("サモサ"), itemPrice: Value(200)),
  ItemsCompanion(itemName: Value("ラーメン"), itemPrice: Value(900)),
  ItemsCompanion(itemName: Value("タコヤキ"), itemPrice: Value(350)),
  ItemsCompanion(itemName: Value("ケバブ"), itemPrice: Value(600)),
  ItemsCompanion(itemName: Value("クレープ"), itemPrice: Value(400)),
  ItemsCompanion(itemName: Value("パエリア"), itemPrice: Value(800)),
  ItemsCompanion(itemName: Value("ジャンバラヤ"), itemPrice: Value(700)),
  ItemsCompanion(itemName: Value("ホットドッグ"), itemPrice: Value(300)),
  ItemsCompanion(itemName: Value("フィッシュ＆チップス"), itemPrice: Value(850)),
  ItemsCompanion(itemName: Value("クッキー"), itemPrice: Value(150)),
  ItemsCompanion(itemName: Value("ステーキ"), itemPrice: Value(1500)),
  ItemsCompanion(itemName: Value("シーフードパスタ"), itemPrice: Value(1200)),
  ItemsCompanion(itemName: Value("ランチプレート"), itemPrice: Value(1000)),
  ItemsCompanion(itemName: Value("フィラデルフィアロール"), itemPrice: Value(800)),
  ItemsCompanion(itemName: Value("ラーメンバーガー"), itemPrice: Value(950)),
  ItemsCompanion(itemName: Value("パンケーキスタック"), itemPrice: Value(700)),
  ItemsCompanion(itemName: Value("ホットボウル"), itemPrice: Value(850)),
  ItemsCompanion(itemName: Value("シュリンプトースト"), itemPrice: Value(600)),
  ItemsCompanion(itemName: Value("ピリ辛チキンウィング"), itemPrice: Value(450)),
  ItemsCompanion(itemName: Value("チョコレートファウンテン"), itemPrice: Value(300)),
  ItemsCompanion(itemName: Value("フレンチフライ"), itemPrice: Value(250)),
  ItemsCompanion(itemName: Value("チーズケーキ"), itemPrice: Value(550)),
  ItemsCompanion(itemName: Value("ナチョス"), itemPrice: Value(400)),
  ItemsCompanion(itemName: Value("ホットワング"), itemPrice: Value(600)),
  ItemsCompanion(itemName: Value("シーザーサラダ"), itemPrice: Value(450)),
  ItemsCompanion(itemName: Value("カルビタコス"), itemPrice: Value(650)),
  ItemsCompanion(itemName: Value("パスタサラダ"), itemPrice: Value(350)),
  ItemsCompanion(itemName: Value("ハムエッグサンドイッチ"), itemPrice: Value(300)),
  ItemsCompanion(itemName: Value("シーフードトースト"), itemPrice: Value(750)),
  ItemsCompanion(itemName: Value("ベジタリアンバーガー"), itemPrice: Value(500)),
  ItemsCompanion(itemName: Value("チキンカレー"), itemPrice: Value(750)),
  ItemsCompanion(itemName: Value("アイスコーヒー"), itemPrice: Value(200)),
  ItemsCompanion(itemName: Value("ポップコーン"), itemPrice: Value(300)),
  ItemsCompanion(itemName: Value("チュロス"), itemPrice: Value(400)),
  ItemsCompanion(itemName: Value("タピオカミルクティー"), itemPrice: Value(450)),
  ItemsCompanion(itemName: Value("ギョーザ"), itemPrice: Value(350)),
  ItemsCompanion(itemName: Value("ライスボウル"), itemPrice: Value(650)),
  ItemsCompanion(itemName: Value("スムージー"), itemPrice: Value(500)),
  ItemsCompanion(itemName: Value("フィッシュタコス"), itemPrice: Value(700)),
  ItemsCompanion(itemName: Value("ワッフル"), itemPrice: Value(350)),
  ItemsCompanion(itemName: Value("やきそば"), itemPrice: Value(700)),
  ItemsCompanion(itemName: Value("やきとり"), itemPrice: Value(350)),
  ItemsCompanion(itemName: Value("ミートパイ"), itemPrice: Value(350)),
  ItemsCompanion(itemName: Value("メロンパン"), itemPrice: Value(200)),
  ItemsCompanion(itemName: Value("モダン焼き"), itemPrice: Value(450)),
];

// MEMO 現在の日時を取得
final nowDateTime = DateTime.now();

// MEMO ダミー注文データ
final dummyOrders = [
  OrdersCompanion(
      orderNum: const Value(5),
      orderTime: Value(nowDateTime),
      itemId: const Value(0)),
  OrdersCompanion(
      orderNum: const Value(5),
      orderTime: Value(nowDateTime),
      itemId: const Value(1)),
  OrdersCompanion(
      orderNum: const Value(5),
      orderTime: Value(nowDateTime),
      itemId: const Value(2))
];

// MEMO データがない場合、ダミーデータを登録
Future<void> dummyItem() async {
  final itemRepo = ItemsRepository();
  final orderRepo = OrdersRepository();
  final allItems = await itemRepo.getAllItems();

  if (allItems.isEmpty) {
    await itemRepo.addItems(dummyItems);
    await orderRepo.addOrders(dummyOrders);
    debugPrint("ダミーデータを登録しました");
  } else {
    debugPrint("ダミーデータ登録済");
  }
}
