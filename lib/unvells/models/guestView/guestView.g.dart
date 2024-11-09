// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guestView.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuestView _$GuestViewFromJson(Map<String, dynamic> json) => GuestView(
      orderData: json['orderData'] == null
          ? null
          : OrderData.fromJson(json['orderData'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?;

Map<String, dynamic> _$GuestViewToJson(GuestView instance) => <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
      'orderData': instance.orderData,
    };

OrderData _$OrderDataFromJson(Map<String, dynamic> json) => OrderData(
      itemList: (json['itemList'] as List<dynamic>?)
          ?.map((e) => ItemList.fromJson(e as Map<String, dynamic>))
          .toList(),
      totals: (json['totals'] as List<dynamic>?)
          ?.map((e) => Totals.fromJson(e as Map<String, dynamic>))
          .toList(),
      orderInfo: (json['orderInfo'] as List<dynamic>?)
          ?.map((e) => OrderInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderDataToJson(OrderData instance) => <String, dynamic>{
      'itemList': instance.itemList,
      'totals': instance.totals,
      'orderInfo': instance.orderInfo,
    };

ItemList _$ItemListFromJson(Map<String, dynamic> json) => ItemList(
      name: json['name'] as String?,
      sku: json['sku'] as String?,
      price: json['price'] as String?,
      qty: (json['qty'] as num?)?.toInt(),
      subTotal: json['subTotal'] as String?,
    );

Map<String, dynamic> _$ItemListToJson(ItemList instance) => <String, dynamic>{
      'name': instance.name,
      'sku': instance.sku,
      'price': instance.price,
      'qty': instance.qty,
      'subTotal': instance.subTotal,
    };

Totals _$TotalsFromJson(Map<String, dynamic> json) => Totals(
      code: json['code'] as String?,
      label: json['label'] as String?,
      value: json['value'] as String?,
      formattedValue: json['formattedValue'] as String?,
    );

Map<String, dynamic> _$TotalsToJson(Totals instance) => <String, dynamic>{
      'code': instance.code,
      'label': instance.label,
      'value': instance.value,
      'formattedValue': instance.formattedValue,
    };

OrderInfo _$OrderInfoFromJson(Map<String, dynamic> json) => OrderInfo(
      shippingAddress: json['shippingAddress'] as String?,
      shippingMethod: json['shippingMethod'] as String?,
      billingAddress: json['billingAddress'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
    );

Map<String, dynamic> _$OrderInfoToJson(OrderInfo instance) => <String, dynamic>{
      'shippingAddress': instance.shippingAddress,
      'shippingMethod': instance.shippingMethod,
      'billingAddress': instance.billingAddress,
      'paymentMethod': instance.paymentMethod,
    };
