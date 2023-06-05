# ORDER APP

## 機能(予定)

思いついたことを忘れないように羅列

- オフラインで使用可能
- 商品登録
- 画像登録
- バーコード読み取り
- オーダーをフリップ入力風に商品選択<br>|あ|か|さ|<br>|た|な|は|<br>|ま|や|ら|
- 受けたオーダーを表示
- 受けたオーダーはリアルタイムで記録するためSQLiteで保存
- 営業終了後、オーダの集計時にSupaBaseに保存して、PCから管理可能
- 締日を決めて過ぎたら月次売上をまとめる

## 使用技術

- SQLite：オフライン記録用
- Supabase：集計した時に記録

## 使用パッケージ

- drift
- hooks_riverpod

## DataBase テーブル

### 商品テーブル

| 項目   | カラム名 | データ型 | データタイプ | 制約                       |
| ------ | -------- | -------- | ------------ | -------------------------- |
| ID     | item_id  | integer  | 整数         | PRIMARY KEY, AUTOINCREMENT |
| 商品名 | item     | text     | 文字列       | NOT NULL, UNIQUE           |
| 価格   | price    | integer  | 整数         | NOT NULL                   |

### 注文テーブル

| 項目     | カラム名   | データ型 | データタイプ | 制約                       |
| -------- | ---------- | -------- | ------------ | -------------------------- |
| ID       | id         | integer  | 整数         | PRIMARY KEY, AUTOINCREMENT |
| 商品 ID  | item_id    | integer  | 整数         | NOT NULL, UNIQUE           |
| 注文数   | order_num  | integer  | 整数         | NOT NULL                   |
| 注文日時 | order_time | text     | 文字列       | NOT NULL                   |
