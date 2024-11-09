/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:test_new/unvells/models/base_model.dart';

part 'guestView.g.dart';

@JsonSerializable()
class GuestView extends BaseModel{
  OrderData? orderData;
  GuestView({this.orderData});

  factory GuestView.fromJson(Map<String, dynamic> json) =>
      _$GuestViewFromJson(json);
  Map<String, dynamic> toJson() => _$GuestViewToJson(this);
}

@JsonSerializable()
class OrderData{
  List<ItemList>? itemList;
  List<Totals>? totals;
  List<OrderInfo>? orderInfo;
  OrderData({this.itemList, this.totals, this.orderInfo});

  factory OrderData.fromJson(Map<String, dynamic> json) =>
      _$OrderDataFromJson(json);
  Map<String, dynamic> toJson() => _$OrderDataToJson(this);
}

@JsonSerializable()
class ItemList{
  String? name;
  String? sku;
  String? price;
  int? qty;
  String? subTotal;
  ItemList({this.name, this.sku, this.price, this.qty, this.subTotal});

  factory ItemList.fromJson(Map<String, dynamic> json) =>
      _$ItemListFromJson(json);
  Map<String, dynamic> toJson() => _$ItemListToJson(this);
}

@JsonSerializable()
class Totals{
  String? code;
  String? label;
  String? value;
  String? formattedValue;
  Totals({this.code, this.label, this.value, this.formattedValue});

  factory Totals.fromJson(Map<String, dynamic> json) =>
      _$TotalsFromJson(json);
  Map<String, dynamic> toJson() => _$TotalsToJson(this);
}

@JsonSerializable()
class OrderInfo{
  String? shippingAddress;
  String? shippingMethod;
  String? billingAddress;
  String? paymentMethod;
  OrderInfo({this.shippingAddress, this.shippingMethod, this.billingAddress, this.paymentMethod});

  factory OrderInfo.fromJson(Map<String, dynamic> json) =>
      _$OrderInfoFromJson(json);
  Map<String, dynamic> toJson() => _$OrderInfoToJson(this);
}