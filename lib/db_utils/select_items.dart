import "package:take_orders_app/constants/imports.dart";

// MEMO 五十音順配列（ひらがな、カタカナ併用）
const gojyuon = [
  ["あ", "い", "う", "え", "お", "ア", "イ", "ウ", "エ", "オ"], // 0
  ["か", "き", "く", "け", "こ", "カ", "キ", "ク", "ケ", "コ"], // 1
  ["さ", "し", "す", "せ", "そ", "サ", "シ", "ス", "セ", "ソ"], // 2
  ["た", "ち", "つ", "て", "と", "タ", "チ", "ツ", "テ", "ト"], // 3
  ["な", "に", "ぬ", "ね", "の", "ナ", "ニ", "ヌ", "ネ", "ノ"], // 4
  ["は", "ひ", "ふ", "へ", "ほ", "ハ", "ヒ", "フ", "ヘ", "ホ"], // 5
  ["ま", "み", "む", "め", "も", "マ", "ミ", "ム", "メ", "モ"], // 6
  ["や", "ゆ", "よ", "ヤ", "ユ", "ヨ"], // 7
  ["ら", "り", "る", "れ", "ろ", "ラ", "リ", "ル", "レ", "ロ"], // 8
  ["わ", "を", "ん", "ワ", "ヲ", "ン"] // 9
];

// MEMO 五十音順で検索
// MEMO iは0から9まで
Future<List<Item>> gojyuonItem(int i) async {
  final itemRepo = ItemsRepository();
  if (i < 0) {
    debugPrint("入力エラー：0から9までの数値を指定してください");
    return [];
  }
  // MEMO iが7か9の時
  else if (i == 7 || i == 9) {
    // MEMO 3文字
    final gojyuonItems = await itemRepo.gojyuonInitial3(gojyuon[i]);
    // debugPrint("gojyuonItems: $gojyuonItems");
    return gojyuonItems;
  }
  // MEMO iが7か9以外の時
  else {
    // MEMO 5文字
    final gojyuonItems = await itemRepo.gojyuonInitial5(gojyuon[i]);
    // debugPrint("gojyuonItems: $gojyuonItems");
    return gojyuonItems;
  }
}
