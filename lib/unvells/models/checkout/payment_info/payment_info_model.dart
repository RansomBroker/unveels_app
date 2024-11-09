/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:test_new/unvells/models/base_model.dart';
import 'package:test_new/unvells/models/cart/cart_item.dart';
import 'package:test_new/unvells/models/cart/price_details.dart';

part 'payment_info_model.g.dart';

@JsonSerializable()
class PaymentInfoModel extends BaseModel {
  @JsonKey(name: "billingAddress")
  String? billingAddress;

  @JsonKey(name: "shippingAddress")
  String? shippingAddress;

  @JsonKey(name: "shippingMethod")
  String? shippingMethod;

  @JsonKey(name: "couponCode")
  String? couponCode;

  @JsonKey(name: "giftCode")
  String? giftCode;
  @JsonKey(name: "giftCodeId")
  int? giftCodeId;

  @JsonKey(name: "currencyCode")
  String? currencyCode;
  @JsonKey(name: "spendAmount")
  String? spendAmount;

  @JsonKey(name: "orderReviewData")
  OrderReviewData? orderReviewData;

  @JsonKey(name: "paymentMethods")
  List<PaymentMethods>? paymentMethods;

  @JsonKey(name: "cartCount")
  int? cartCount;

  @JsonKey(name: "cartTotal")
  String? total;

  PaymentInfoModel(
      {this.orderReviewData,
      this.cartCount,
      this.billingAddress,
      this.couponCode,
      this.currencyCode,
      this.paymentMethods,
      this.shippingAddress,
      this.shippingMethod,
      this.giftCode});

  factory PaymentInfoModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentInfoModelToJson(this);
}

@JsonSerializable()
class OrderReviewData {
  @JsonKey(name: "items")
  List<CartItem>? items;

  @JsonKey(name: "totals")
  List<PriceDetails>? totals;

  @JsonKey(name: "cartTotal")
  int? cartTotal;

  OrderReviewData({this.cartTotal, this.items, this.totals});

  factory OrderReviewData.fromJson(Map<String, dynamic> json) =>
      _$OrderReviewDataFromJson(json);

  Map<String, dynamic> toJson() => _$OrderReviewDataToJson(this);
}

@JsonSerializable()
class PaymentMethods {
  @JsonKey(name: "code")
  String? code;

  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "extraInformation")
  String? extraInformation;

  PaymentMethods({this.code, this.title, this.extraInformation});

  factory PaymentMethods.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodsFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodsToJson(this);
}
