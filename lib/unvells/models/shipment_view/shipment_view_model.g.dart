// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipment_view_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShipmentViewModel _$ShipmentViewModelFromJson(Map<String, dynamic> json) =>
    ShipmentViewModel(
      orderId: (json['orderId'] as num?)?.toInt(),
      itemList: (json['itemList'] as List<dynamic>?)
          ?.map((e) => ItemShipmentListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      trackingData: (json['trackingData'] as List<dynamic>?)
          ?.map((e) => TrackingListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      eTag: json['eTag'] as String?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?;

Map<String, dynamic> _$ShipmentViewModelToJson(ShipmentViewModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
      'orderId': instance.orderId,
      'itemList': instance.itemList,
      'trackingData': instance.trackingData,
      'eTag': instance.eTag,
    };

ItemShipmentListData _$ItemShipmentListDataFromJson(
        Map<String, dynamic> json) =>
    ItemShipmentListData(
      id: json['id'] as String?,
      name: json['name'] as String?,
      productId: json['productId'] as String?,
      sku: json['sku'] as String?,
      option: json['option'] as List<dynamic>?,
      qty: (json['qty'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ItemShipmentListDataToJson(
        ItemShipmentListData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'productId': instance.productId,
      'sku': instance.sku,
      'option': instance.option,
      'qty': instance.qty,
    };

TrackingListData _$TrackingListDataFromJson(Map<String, dynamic> json) =>
    TrackingListData(
      id: json['id'] as String?,
      title: json['title'] as String?,
      number: json['number'] as String?,
      carrier: json['carrier'] as String?,
    );

Map<String, dynamic> _$TrackingListDataToJson(TrackingListData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'number': instance.number,
      'carrier': instance.carrier,
    };
