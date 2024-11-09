/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:test_new/unvells/models/base_model.dart';

part 'invoice_view_model.g.dart';

@JsonSerializable()
class InvoiceViewModel extends BaseModel {
  @JsonKey(name: "orderId")
  int? orderId;

  @JsonKey(name: "itemList")
  List<ItemListData>? itemList;

  @JsonKey(name: "totals")
  List<TotalsData>? totals;

  @JsonKey(name: "cartTotal")
  String? cartTotal;

  @JsonKey(name: "shippingAddress")
  ShippingAddress? shippingAddress;

  @JsonKey(name: "billingAddress")
  BillingAddress? billingAddress;

  @JsonKey(name: "shippingMethod")
  ShippingMethod? shippingMethod;

  @JsonKey(name: "paymentMethod")
  PaymentMethod? paymentMethod;

  @JsonKey(name: "eTag")
  String? eTag;

  InvoiceViewModel(
      {
        this.orderId,
        this.itemList,
        this.totals,
        this.cartTotal,
        this.shippingAddress,
        this.billingAddress,
        this.shippingMethod,
        this.paymentMethod,
        this.eTag,
      });

  factory InvoiceViewModel.fromJson(Map<String, dynamic> json) =>
      _$InvoiceViewModelFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceViewModelToJson(this);

}

@JsonSerializable()
class ItemListData {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "productId")
  String? productId;

  @JsonKey(name: "sku")
  String? sku;

  @JsonKey(name: "option")
  List<dynamic>? option;

  @JsonKey(name: "qty")
  int? qty;

  @JsonKey(name: "taxAmount")
  String? taxAmount;

  @JsonKey(name: "discountAmount")
  String? discountAmount;

  @JsonKey(name: "price")
  String? price;

  @JsonKey(name: "subTotal")
  String? subTotal;

  @JsonKey(name: "rowTotal")
  String? rowTotal;

  ItemListData(
      {
        this.id,
        this.name,
        this.productId,
        this.sku,
        this.option,
        this.qty,
        this.taxAmount,
        this.discountAmount,
        this.price,
        this.subTotal,
        this.rowTotal,
      });

  factory ItemListData.fromJson(Map<String, dynamic> json) =>
      _$ItemListDataFromJson(json);

  Map<String, dynamic> toJson() => _$ItemListDataToJson(this);
}

@JsonSerializable()
class TotalsData {
  @JsonKey(name: "code")
  String? code;
  @JsonKey(name: "label")
  String? label;
  @JsonKey(name: "value")
  String? value;
  @JsonKey(name: "formattedValue")
  String? formattedValue;

  TotalsData(
      {
        this.code,
        this.label,
        this.value,
        this.formattedValue,
      });

  factory TotalsData.fromJson(Map<String, dynamic> json) =>
      _$TotalsDataFromJson(json);

  Map<String, dynamic> toJson() => _$TotalsDataToJson(this);
}

@JsonSerializable()
class ShippingAddress {
  @JsonKey(name: "firstname")
  String? firstname;
  @JsonKey(name: "lastname")
  String? lastname;
  @JsonKey(name: "city")
  String? city;
  @JsonKey(name: "region")
  String? region;
  @JsonKey(name: "street")
  List<String>? street;
  @JsonKey(name: "country")
  String? country;
  @JsonKey(name: "pincode")
  String? pincode;

  ShippingAddress(
      {
        this.firstname,
        this.lastname,
        this.city,
        this.region,
        this.street,
        this.country,
        this.pincode,
      });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      _$ShippingAddressFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingAddressToJson(this);
}

@JsonSerializable()
class BillingAddress {
  @JsonKey(name: "firstname")
  String? firstname;
  @JsonKey(name: "lastname")
  String? lastname;
  @JsonKey(name: "city")
  String? city;
  @JsonKey(name: "region")
  String? region;
  @JsonKey(name: "street")
  List<String>? street;
  @JsonKey(name: "country")
  String? country;
  @JsonKey(name: "pincode")
  String? pincode;

  BillingAddress(
      {
        this.firstname,
        this.lastname,
        this.city,
        this.region,
        this.street,
        this.country,
        this.pincode,
      });
  factory BillingAddress.fromJson(Map<String, dynamic> json) =>
      _$BillingAddressFromJson(json);

  Map<String, dynamic> toJson() => _$BillingAddressToJson(this);
}
@JsonSerializable()
class ShippingMethod {
  @JsonKey(name: "title")
  String? title;

  ShippingMethod(
      {
        this.title
      });

  factory ShippingMethod.fromJson(Map<String, dynamic> json) =>
      _$ShippingMethodFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingMethodToJson(this);
}

@JsonSerializable()
class PaymentMethod {
  @JsonKey(name: "title")
  String? title;

  PaymentMethod(
      {
        this.title
      });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodToJson(this);
}
