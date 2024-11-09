// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refund_view_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefundViewModel _$RefundViewModelFromJson(Map<String, dynamic> json) =>
    RefundViewModel(
      orderId: (json['orderId'] as num?)?.toInt(),
      itemList: (json['itemList'] as List<dynamic>?)
          ?.map((e) => ItemListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      totals: (json['totals'] as List<dynamic>?)
          ?.map((e) => TotalsData.fromJson(e as Map<String, dynamic>))
          .toList(),
      cartTotal: json['cartTotal'] as String?,
      shippingAddress: json['shippingAddress'] == null
          ? null
          : ShippingAddress.fromJson(
              json['shippingAddress'] as Map<String, dynamic>),
      billingAddress: json['billingAddress'] == null
          ? null
          : BillingAddress.fromJson(
              json['billingAddress'] as Map<String, dynamic>),
      shippingMethod: json['shippingMethod'] == null
          ? null
          : ShippingMethod.fromJson(
              json['shippingMethod'] as Map<String, dynamic>),
      paymentMethod: json['paymentMethod'] == null
          ? null
          : PaymentMethod.fromJson(
              json['paymentMethod'] as Map<String, dynamic>),
      eTag: json['eTag'] as String?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?;

Map<String, dynamic> _$RefundViewModelToJson(RefundViewModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
      'orderId': instance.orderId,
      'itemList': instance.itemList,
      'totals': instance.totals,
      'cartTotal': instance.cartTotal,
      'shippingAddress': instance.shippingAddress,
      'billingAddress': instance.billingAddress,
      'shippingMethod': instance.shippingMethod,
      'paymentMethod': instance.paymentMethod,
      'eTag': instance.eTag,
    };
