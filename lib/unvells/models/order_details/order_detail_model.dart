/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';

import '../base_model.dart';
part 'order_detail_model.g.dart';

@JsonSerializable()
class OrderDetailModel extends BaseModel{
  @JsonKey(name:"incrementId")
  String? incrementId;

  @JsonKey(name:"statusColorCode")
  String? statusColorCode;

  @JsonKey(name:"statusLabel")
  String? statusLabel;

  @JsonKey(name:"orderDate")
  String? orderDate;

  @JsonKey(name:"shippingAddress")
  String? shippingAddress;

  @JsonKey(name:"shippingMethod")
  String? shippingMethod;

  @JsonKey(name:"billingAddress")
  String? billingAddress;

  @JsonKey(name:"paymentMethod")
  String? paymentMethod;

  @JsonKey(name: "orderData")
  OrderData? orderData;

  @JsonKey(name: "canReorder")
  bool? canReorder = false;

  @JsonKey(name:"state")
  String? state;

  @JsonKey(name:"customerName")
  String? customerName;

  @JsonKey(name:"customerEmail")
  String? customerEmail;

  @JsonKey(name:"invoiceList")
  List<InvoiceListData>? invoiceList;

  @JsonKey(name:"shipmentList")
  List<ShipmentListData>? shipmentList;

  @JsonKey(name:"creditmemoList")
  List<Creditmemo>? creditmemoList;

  @JsonKey(name: "adminAddress")
  String? adminAddress;

  int? error;


  OrderDetailModel({
    this.incrementId,
    this.statusColorCode,
    this.statusLabel,
    this.orderDate,
    this.shippingAddress,
    this.shippingMethod,
    this.billingAddress,
    this.paymentMethod,
    this.orderData,
    this.canReorder,
    this.state,
    this.customerName,
    this.customerEmail,
    this.invoiceList,
    this.shipmentList,
    this.creditmemoList,
    this.adminAddress

  });
  factory OrderDetailModel.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailModelToJson(this);
}

@JsonSerializable()
class OrderData {
  @JsonKey(name:"itemList")
  List<OrderItem>? itemList;

  @JsonKey(name:"totals")
  List<TotalItem>? totals;

  OrderData(
      {this.itemList,
        this.totals,});

  factory OrderData.fromJson(Map<String, dynamic> json) =>
      _$OrderDataFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDataToJson(this);
}

@JsonSerializable()
class OrderItem {
  @JsonKey(name:"productId")
  String? productId;

  @JsonKey(name:"name")
  String? name;

  @JsonKey(name:"sku")
  String? sku;

  @JsonKey(name:"image")
  String? image;

  @JsonKey(name:"dominantColor")
  String? dominantColor;

  @JsonKey(name:"price")
  String? price;

  @JsonKey(name:"qty")
  OrderQty? qty;

  @JsonKey(name:"subTotal")
  String? subTotal;

  @JsonKey(name:"options")
  List<OptionsItem>? options;


  OrderItem(
      {this.productId,
        this.name,
        this.sku,
        this.image,
        this.dominantColor,
        this.price,
        this.qty,
        this.subTotal,
        this.options
      });

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}


@JsonSerializable()
class OrderQty {
  @JsonKey(name:"Ordered")
  dynamic ordered;

  @JsonKey(name:"Shipped")
  dynamic shipped;

  @JsonKey(name:"Canceled")
  dynamic canceled;

  @JsonKey(name:"Refunded")
  dynamic refunded;

  OrderQty({this.ordered, this.shipped, this.canceled, this.refunded});

  factory OrderQty.fromJson(Map<String, dynamic> json) =>
      _$OrderQtyFromJson(json);

  Map<String, dynamic> toJson() => _$OrderQtyToJson(this);
}

@JsonSerializable()
class OptionsItem {
  @JsonKey(name:"label")
  String? label;

  @JsonKey(name:"value")
  dynamic? value;

  @JsonKey(name:"valueIds")
  List<String>? valueIds;

  OptionsItem({this.label, this.value, this.valueIds});

  factory OptionsItem.fromJson(Map<String, dynamic> json) =>
      _$OptionsItemFromJson(json);

  Map<String, dynamic> toJson() => _$OptionsItemToJson(this);
}


@JsonSerializable()
class TotalItem {
  @JsonKey(name:"code")
  String? code;

  @JsonKey(name:"label")
  String? label;

  @JsonKey(name:"value")
  String? value;

  @JsonKey(name:"formattedValue")
  String? formattedValue;

  TotalItem({this.code, this.label, this.value, this.formattedValue});

  factory TotalItem.fromJson(Map<String, dynamic> json) =>
      _$TotalItemFromJson(json);

  Map<String, dynamic> toJson() => _$TotalItemToJson(this);
}

@JsonSerializable()
class ShipmentListData {
  @JsonKey(name:"id")
  String? id;

  @JsonKey(name:"incrementId")
  String? incrementId;

  @JsonKey(name:"items")
  List<ShipmentItemsData>? itemsData;

  ShipmentListData({this.id, this.incrementId, this.itemsData});

  factory ShipmentListData.fromJson(Map<String, dynamic> json) =>
      _$ShipmentListDataFromJson(json);

  Map<String, dynamic> toJson() => _$ShipmentListDataToJson(this);
}



@JsonSerializable()
class ShipmentItemsData {
  @JsonKey(name:"name")
  String? name;

  @JsonKey(name:"option")
  List<dynamic>? option;

  @JsonKey(name:"qty")
  int? qty;

  @JsonKey(name:"sku")
  String? sku;

  ShipmentItemsData({this.name, this.option, this.qty, this.sku});

  factory ShipmentItemsData.fromJson(Map<String, dynamic> json) =>
      _$ShipmentItemsDataFromJson(json);

  Map<String, dynamic> toJson() => _$ShipmentItemsDataToJson(this);
}



@JsonSerializable()
class InvoiceListData {
  @JsonKey(name:"id")
  String? id;

  @JsonKey(name:"incrementId")
  String? incrementId;

  @JsonKey(name:"items")
  List<ItemsData>? itemsData;

  @JsonKey(name:"price")
  String? price;

  @JsonKey(name:"qty")
  int? qty;

  @JsonKey(name:"sku")
  String? sku;

  @JsonKey(name:"subTotal")
  String? subTotal;

  @JsonKey(name:"totals")
  List<TotalsData>? totals;

  InvoiceListData({this.id, this.incrementId, this.itemsData, this.price, this.qty, this.sku, this.subTotal});

  factory InvoiceListData.fromJson(Map<String, dynamic> json) =>
      _$InvoiceListDataFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceListDataToJson(this);
}

@JsonSerializable()
class ItemsData {
  @JsonKey(name:"dominantColor")
  String? dominantColor;

  @JsonKey(name:"image")
  String? image;

  @JsonKey(name:"option")
  List<String>? option;

  @JsonKey(name:"name")
  String? name;

  @JsonKey(name:"price")
  String? price;

  @JsonKey(name:"productId")
  String? productId;

  @JsonKey(name:"qty")
  List<QtyData>? qty;

  @JsonKey(name:"sku")
  String? sku;

  @JsonKey(name:"subTotal")
  String? subTotal;

  ItemsData({this.dominantColor, this.image, this.option, this.name, this.price, this.productId, this.qty,this.sku,this.subTotal});

  factory ItemsData.fromJson(Map<String, dynamic> json) =>
      _$ItemsDataFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsDataToJson(this);
}


@JsonSerializable()
class QtyData {
  @JsonKey(name:"canceled")
  String? canceled;

  @JsonKey(name:"ordered")
  String? ordered;

  @JsonKey(name:"refunded")
  String? refunded;

  @JsonKey(name:"shipped")
  String? shipped;

  QtyData({this.canceled, this.ordered, this.refunded, this.shipped});

  factory QtyData.fromJson(Map<String, dynamic> json) =>
      _$QtyDataFromJson(json);

  Map<String, dynamic> toJson() => _$QtyDataToJson(this);
}


@JsonSerializable()
class TotalsData {
  @JsonKey(name:"code")
  String? code;

  @JsonKey(name:"formattedValue")
  String? formattedValue;

  @JsonKey(name:"label")
  String? label;

  @JsonKey(name:"value")
  String? value;

  TotalsData({this.code, this.formattedValue, this.label, this.value});

  factory TotalsData.fromJson(Map<String, dynamic> json) =>
      _$TotalsDataFromJson(json);

  Map<String, dynamic> toJson() => _$TotalsDataToJson(this);
}

@JsonSerializable()
class Creditmemo {
  @JsonKey(name:"incrementId")
  String? incrementId;

  @JsonKey(name:"items")
  List<CreditmemoItem>? items;

  Creditmemo({this.incrementId, this.items});

  factory Creditmemo.fromJson(Map<String, dynamic> json) =>
      _$CreditmemoFromJson(json);

  Map<String, dynamic> toJson() => _$CreditmemoToJson(this);
}


@JsonSerializable()
class CreditmemoItem {
  @JsonKey(name:"name")
  String? name;

  @JsonKey(name:"sku")
  String? sku;

  @JsonKey(name:"price")
  String? price;

  @JsonKey(name:"qty")
  int? qty;

  @JsonKey(name:"subTotal")
  String? subTotal;

  @JsonKey(name:"discountAmount")
  String? discountAmount;

  @JsonKey(name:"rowTotal")
  String? rowTotal;


  CreditmemoItem(
      {this.name,
        this.sku,
        this.price,
        this.qty,
        this.subTotal,
        this.discountAmount,
        this.rowTotal});

  factory CreditmemoItem.fromJson(Map<String, dynamic> json) =>
      _$CreditmemoItemFromJson(json);

  Map<String, dynamic> toJson() => _$CreditmemoItemToJson(this);
}
