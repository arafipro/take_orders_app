// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_db.dart';

// ignore_for_file: type=lint
class $ItemsTable extends Items with TableInfo<$ItemsTable, Item> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<int> itemId = GeneratedColumn<int>(
      'item_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _itemNameMeta =
      const VerificationMeta('itemName');
  @override
  late final GeneratedColumn<String> itemName = GeneratedColumn<String>(
      'item_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _itemPriceMeta =
      const VerificationMeta('itemPrice');
  @override
  late final GeneratedColumn<int> itemPrice = GeneratedColumn<int>(
      'item_price', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [itemId, itemName, itemPrice];
  @override
  String get aliasedName => _alias ?? 'items';
  @override
  String get actualTableName => 'items';
  @override
  VerificationContext validateIntegrity(Insertable<Item> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta));
    }
    if (data.containsKey('item_name')) {
      context.handle(_itemNameMeta,
          itemName.isAcceptableOrUnknown(data['item_name']!, _itemNameMeta));
    } else if (isInserting) {
      context.missing(_itemNameMeta);
    }
    if (data.containsKey('item_price')) {
      context.handle(_itemPriceMeta,
          itemPrice.isAcceptableOrUnknown(data['item_price']!, _itemPriceMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {itemId};
  @override
  Item map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Item(
      itemId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}item_id'])!,
      itemName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}item_name'])!,
      itemPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}item_price']),
    );
  }

  @override
  $ItemsTable createAlias(String alias) {
    return $ItemsTable(attachedDatabase, alias);
  }
}

class Item extends DataClass implements Insertable<Item> {
  final int itemId;
  final String itemName;
  final int? itemPrice;
  const Item({required this.itemId, required this.itemName, this.itemPrice});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['item_id'] = Variable<int>(itemId);
    map['item_name'] = Variable<String>(itemName);
    if (!nullToAbsent || itemPrice != null) {
      map['item_price'] = Variable<int>(itemPrice);
    }
    return map;
  }

  ItemsCompanion toCompanion(bool nullToAbsent) {
    return ItemsCompanion(
      itemId: Value(itemId),
      itemName: Value(itemName),
      itemPrice: itemPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(itemPrice),
    );
  }

  factory Item.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Item(
      itemId: serializer.fromJson<int>(json['itemId']),
      itemName: serializer.fromJson<String>(json['itemName']),
      itemPrice: serializer.fromJson<int?>(json['itemPrice']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'itemId': serializer.toJson<int>(itemId),
      'itemName': serializer.toJson<String>(itemName),
      'itemPrice': serializer.toJson<int?>(itemPrice),
    };
  }

  Item copyWith(
          {int? itemId,
          String? itemName,
          Value<int?> itemPrice = const Value.absent()}) =>
      Item(
        itemId: itemId ?? this.itemId,
        itemName: itemName ?? this.itemName,
        itemPrice: itemPrice.present ? itemPrice.value : this.itemPrice,
      );
  @override
  String toString() {
    return (StringBuffer('Item(')
          ..write('itemId: $itemId, ')
          ..write('itemName: $itemName, ')
          ..write('itemPrice: $itemPrice')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(itemId, itemName, itemPrice);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Item &&
          other.itemId == this.itemId &&
          other.itemName == this.itemName &&
          other.itemPrice == this.itemPrice);
}

class ItemsCompanion extends UpdateCompanion<Item> {
  final Value<int> itemId;
  final Value<String> itemName;
  final Value<int?> itemPrice;
  const ItemsCompanion({
    this.itemId = const Value.absent(),
    this.itemName = const Value.absent(),
    this.itemPrice = const Value.absent(),
  });
  ItemsCompanion.insert({
    this.itemId = const Value.absent(),
    required String itemName,
    this.itemPrice = const Value.absent(),
  }) : itemName = Value(itemName);
  static Insertable<Item> custom({
    Expression<int>? itemId,
    Expression<String>? itemName,
    Expression<int>? itemPrice,
  }) {
    return RawValuesInsertable({
      if (itemId != null) 'item_id': itemId,
      if (itemName != null) 'item_name': itemName,
      if (itemPrice != null) 'item_price': itemPrice,
    });
  }

  ItemsCompanion copyWith(
      {Value<int>? itemId, Value<String>? itemName, Value<int?>? itemPrice}) {
    return ItemsCompanion(
      itemId: itemId ?? this.itemId,
      itemName: itemName ?? this.itemName,
      itemPrice: itemPrice ?? this.itemPrice,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
    }
    if (itemName.present) {
      map['item_name'] = Variable<String>(itemName.value);
    }
    if (itemPrice.present) {
      map['item_price'] = Variable<int>(itemPrice.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemsCompanion(')
          ..write('itemId: $itemId, ')
          ..write('itemName: $itemName, ')
          ..write('itemPrice: $itemPrice')
          ..write(')'))
        .toString();
  }
}

class $OrdersTable extends Orders with TableInfo<$OrdersTable, Order> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _orderNumMeta =
      const VerificationMeta('orderNum');
  @override
  late final GeneratedColumn<int> orderNum = GeneratedColumn<int>(
      'order_num', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _orderTimeMeta =
      const VerificationMeta('orderTime');
  @override
  late final GeneratedColumn<DateTime> orderTime = GeneratedColumn<DateTime>(
      'order_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _itemsMeta = const VerificationMeta('items');
  @override
  late final GeneratedColumn<int> items = GeneratedColumn<int>(
      'items', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES items (item_id)'));
  @override
  List<GeneratedColumn> get $columns => [id, orderNum, orderTime, items];
  @override
  String get aliasedName => _alias ?? 'orders';
  @override
  String get actualTableName => 'orders';
  @override
  VerificationContext validateIntegrity(Insertable<Order> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('order_num')) {
      context.handle(_orderNumMeta,
          orderNum.isAcceptableOrUnknown(data['order_num']!, _orderNumMeta));
    }
    if (data.containsKey('order_time')) {
      context.handle(_orderTimeMeta,
          orderTime.isAcceptableOrUnknown(data['order_time']!, _orderTimeMeta));
    } else if (isInserting) {
      context.missing(_orderTimeMeta);
    }
    if (data.containsKey('items')) {
      context.handle(
          _itemsMeta, items.isAcceptableOrUnknown(data['items']!, _itemsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Order map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Order(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      orderNum: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_num']),
      orderTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}order_time'])!,
      items: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}items']),
    );
  }

  @override
  $OrdersTable createAlias(String alias) {
    return $OrdersTable(attachedDatabase, alias);
  }
}

class Order extends DataClass implements Insertable<Order> {
  final int id;
  final int? orderNum;
  final DateTime orderTime;
  final int? items;
  const Order(
      {required this.id, this.orderNum, required this.orderTime, this.items});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || orderNum != null) {
      map['order_num'] = Variable<int>(orderNum);
    }
    map['order_time'] = Variable<DateTime>(orderTime);
    if (!nullToAbsent || items != null) {
      map['items'] = Variable<int>(items);
    }
    return map;
  }

  OrdersCompanion toCompanion(bool nullToAbsent) {
    return OrdersCompanion(
      id: Value(id),
      orderNum: orderNum == null && nullToAbsent
          ? const Value.absent()
          : Value(orderNum),
      orderTime: Value(orderTime),
      items:
          items == null && nullToAbsent ? const Value.absent() : Value(items),
    );
  }

  factory Order.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Order(
      id: serializer.fromJson<int>(json['id']),
      orderNum: serializer.fromJson<int?>(json['orderNum']),
      orderTime: serializer.fromJson<DateTime>(json['orderTime']),
      items: serializer.fromJson<int?>(json['items']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'orderNum': serializer.toJson<int?>(orderNum),
      'orderTime': serializer.toJson<DateTime>(orderTime),
      'items': serializer.toJson<int?>(items),
    };
  }

  Order copyWith(
          {int? id,
          Value<int?> orderNum = const Value.absent(),
          DateTime? orderTime,
          Value<int?> items = const Value.absent()}) =>
      Order(
        id: id ?? this.id,
        orderNum: orderNum.present ? orderNum.value : this.orderNum,
        orderTime: orderTime ?? this.orderTime,
        items: items.present ? items.value : this.items,
      );
  @override
  String toString() {
    return (StringBuffer('Order(')
          ..write('id: $id, ')
          ..write('orderNum: $orderNum, ')
          ..write('orderTime: $orderTime, ')
          ..write('items: $items')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, orderNum, orderTime, items);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Order &&
          other.id == this.id &&
          other.orderNum == this.orderNum &&
          other.orderTime == this.orderTime &&
          other.items == this.items);
}

class OrdersCompanion extends UpdateCompanion<Order> {
  final Value<int> id;
  final Value<int?> orderNum;
  final Value<DateTime> orderTime;
  final Value<int?> items;
  const OrdersCompanion({
    this.id = const Value.absent(),
    this.orderNum = const Value.absent(),
    this.orderTime = const Value.absent(),
    this.items = const Value.absent(),
  });
  OrdersCompanion.insert({
    this.id = const Value.absent(),
    this.orderNum = const Value.absent(),
    required DateTime orderTime,
    this.items = const Value.absent(),
  }) : orderTime = Value(orderTime);
  static Insertable<Order> custom({
    Expression<int>? id,
    Expression<int>? orderNum,
    Expression<DateTime>? orderTime,
    Expression<int>? items,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderNum != null) 'order_num': orderNum,
      if (orderTime != null) 'order_time': orderTime,
      if (items != null) 'items': items,
    });
  }

  OrdersCompanion copyWith(
      {Value<int>? id,
      Value<int?>? orderNum,
      Value<DateTime>? orderTime,
      Value<int?>? items}) {
    return OrdersCompanion(
      id: id ?? this.id,
      orderNum: orderNum ?? this.orderNum,
      orderTime: orderTime ?? this.orderTime,
      items: items ?? this.items,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (orderNum.present) {
      map['order_num'] = Variable<int>(orderNum.value);
    }
    if (orderTime.present) {
      map['order_time'] = Variable<DateTime>(orderTime.value);
    }
    if (items.present) {
      map['items'] = Variable<int>(items.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdersCompanion(')
          ..write('id: $id, ')
          ..write('orderNum: $orderNum, ')
          ..write('orderTime: $orderTime, ')
          ..write('items: $items')
          ..write(')'))
        .toString();
  }
}

abstract class _$OrderDatabase extends GeneratedDatabase {
  _$OrderDatabase(QueryExecutor e) : super(e);
  late final $ItemsTable items = $ItemsTable(this);
  late final $OrdersTable orders = $OrdersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [items, orders];
}
