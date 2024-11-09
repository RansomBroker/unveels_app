// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipping_methods_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShippingMethodsModel _$ShippingMethodsModelFromJson(
        Map<String, dynamic> json) =>
    ShippingMethodsModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      cartCount: (json['cartCount'] as num?)?.toInt(),
      cartTotal: json['cartTotal'] as String?,
      shippingMethods: (json['shippingMethods'] as List<dynamic>?)
          ?.map((e) => ShippingMethods.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ShippingMethodsModelToJson(
        ShippingMethodsModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'cartTotal': instance.cartTotal,
      'cartCount': instance.cartCount,
      'shippingMethods': instance.shippingMethods,
    };

ShippingMethods _$ShippingMethodsFromJson(Map<String, dynamic> json) =>
    ShippingMethods(
      title: json['title'] as String?,
      isSelected: json['isSelected'] as bool?,
      method: (json['method'] as List<dynamic>?)
          ?.map((e) => Method.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ShippingMethodsToJson(ShippingMethods instance) =>
    <String, dynamic>{
      'isSelected': instance.isSelected,
      'title': instance.title,
      'method': instance.method,
    };

Method _$MethodFromJson(Map<String, dynamic> json) => Method(
      code: json['code'] as String?,
      label: json['label'] as String?,
      price: json['price'] as String?,
    );

Map<String, dynamic> _$MethodToJson(Method instance) => <String, dynamic>{
      'code': instance.code,
      'label': instance.label,
      'price': instance.price,
    };
