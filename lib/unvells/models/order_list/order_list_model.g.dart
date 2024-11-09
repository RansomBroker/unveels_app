// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderListModel _$OrderListModelFromJson(Map<String, dynamic> json) =>
    OrderListModel(
      orderList: (json['orderList'] as List<dynamic>?)
          ?.map((e) => OrderListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num?)?.toInt(),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?;

Map<String, dynamic> _$OrderListModelToJson(OrderListModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
      'orderList': instance.orderList,
      'totalCount': instance.totalCount,
    };

OrderListData _$OrderListDataFromJson(Map<String, dynamic> json) =>
    OrderListData(
      id: json['id'] as String?,
      orderId: json['order_id'] as String?,
      date: json['date'] as String?,
      shipTo: json['ship_to'] as String?,
      itemCount: json['item_count'] as String?,
      orderTotal: json['order_total'] as String?,
      itemImageUrl: json['item_image_url'] as String?,
      dominantColor: json['dominantColor'] as String?,
      status: json['status'] as String?,
      canReorder: json['canReorder'] as bool?,
      state: json['state'] as String?,
      statusColorCode: json['statusColorCode'] as String?,
    );

Map<String, dynamic> _$OrderListDataToJson(OrderListData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_id': instance.orderId,
      'date': instance.date,
      'ship_to': instance.shipTo,
      'item_count': instance.itemCount,
      'order_total': instance.orderTotal,
      'item_image_url': instance.itemImageUrl,
      'dominantColor': instance.dominantColor,
      'status': instance.status,
      'canReorder': instance.canReorder,
      'state': instance.state,
      'statusColorCode': instance.statusColorCode,
    };
