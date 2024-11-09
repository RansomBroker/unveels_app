/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:test_new/unvells/models/base_model.dart';

import '../invoice_view/invoice_view_model.dart';

part 'refund_view_model.g.dart';

@JsonSerializable()
class RefundViewModel extends BaseModel {
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

  RefundViewModel(
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

  factory RefundViewModel.fromJson(Map<String, dynamic> json) =>
      _$RefundViewModelFromJson(json);

  Map<String, dynamic> toJson() => _$RefundViewModelToJson(this);

}