// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
      thresholdQty: json['thresholdQty'] as String?,
      remainingQty: (json['remainingQty'] as num?)?.toDouble(),
      image: json['image'] as String?,
      dominantColor: json['dominantColor'] as String?,
      name: json['name'] as String?,
      sku: json['sku'] as String?,
      price: json['price'],
      finalPrice: (json['finalPrice'] as num?)?.toDouble(),
      formattedPrice: json['formattedPrice'] as String?,
      formattedFinalPrice: json['formattedFinalPrice'] as String?,
      isInRange: json['isInRange'] as bool?,
      qty: (json['qty'] as num?)?.toInt(),
      productId: json['productId'] as String?,
      groupedProductId: (json['groupedProductId'] as num?)?.toInt(),
      typeId: json['typeId'] as String?,
      subTotal: json['subTotal'] as String?,
      id: json['id'] as String?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => OptionsItems.fromJson(e as Map<String, dynamic>))
          .toList(),
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) => Messages.fromJson(e as Map<String, dynamic>))
          .toList(),
      canMoveToWishlist: json['canMoveToWishlist'] as bool?,
      cartItemQtyChanged: json['cartItemQtyChanged'] as bool?,
    )
      ..thumbnail = json['thumbnail'] as String?
      ..productName = json['productName'] as String?
      ..originalPrice = json['originalPrice'] as String?
      ..option = (json['option'] as List<dynamic>?)
          ?.map((e) => OptionsItems.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      'thresholdQty': instance.thresholdQty,
      'remainingQty': instance.remainingQty,
      'image': instance.image,
      'thumbnail': instance.thumbnail,
      'dominantColor': instance.dominantColor,
      'name': instance.name,
      'productName': instance.productName,
      'sku': instance.sku,
      'price': instance.price,
      'originalPrice': instance.originalPrice,
      'finalPrice': instance.finalPrice,
      'formattedPrice': instance.formattedPrice,
      'formattedFinalPrice': instance.formattedFinalPrice,
      'isInRange': instance.isInRange,
      'qty': instance.qty,
      'productId': instance.productId,
      'groupedProductId': instance.groupedProductId,
      'typeId': instance.typeId,
      'subTotal': instance.subTotal,
      'id': instance.id,
      'options': instance.options,
      'option': instance.option,
      'messages': instance.messages,
      'canMoveToWishlist': instance.canMoveToWishlist,
      'cartItemQtyChanged': instance.cartItemQtyChanged,
    };

OptionsItems _$OptionsItemsFromJson(Map<String, dynamic> json) => OptionsItems(
      label: json['label'] as String?,
      value:
          (json['value'] as List<dynamic>?)?.map((e) => e as String).toList(),
      valueIds: (json['valueIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$OptionsItemsToJson(OptionsItems instance) =>
    <String, dynamic>{
      'label': instance.label,
      'value': instance.value,
      'valueIds': instance.valueIds,
    };

Messages _$MessagesFromJson(Map<String, dynamic> json) => Messages(
      text: json['text'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$MessagesToJson(Messages instance) => <String, dynamic>{
      'text': instance.text,
      'type': instance.type,
    };
