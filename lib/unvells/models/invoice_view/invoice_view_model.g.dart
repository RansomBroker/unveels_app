// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_view_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceViewModel _$InvoiceViewModelFromJson(Map<String, dynamic> json) =>
    InvoiceViewModel(
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

Map<String, dynamic> _$InvoiceViewModelToJson(InvoiceViewModel instance) =>
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

ItemListData _$ItemListDataFromJson(Map<String, dynamic> json) => ItemListData(
      id: json['id'] as String?,
      name: json['name'] as String?,
      productId: json['productId'] as String?,
      sku: json['sku'] as String?,
      option: json['option'] as List<dynamic>?,
      qty: (json['qty'] as num?)?.toInt(),
      taxAmount: json['taxAmount'] as String?,
      discountAmount: json['discountAmount'] as String?,
      price: json['price'] as String?,
      subTotal: json['subTotal'] as String?,
      rowTotal: json['rowTotal'] as String?,
    );

Map<String, dynamic> _$ItemListDataToJson(ItemListData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'productId': instance.productId,
      'sku': instance.sku,
      'option': instance.option,
      'qty': instance.qty,
      'taxAmount': instance.taxAmount,
      'discountAmount': instance.discountAmount,
      'price': instance.price,
      'subTotal': instance.subTotal,
      'rowTotal': instance.rowTotal,
    };

TotalsData _$TotalsDataFromJson(Map<String, dynamic> json) => TotalsData(
      code: json['code'] as String?,
      label: json['label'] as String?,
      value: json['value'] as String?,
      formattedValue: json['formattedValue'] as String?,
    );

Map<String, dynamic> _$TotalsDataToJson(TotalsData instance) =>
    <String, dynamic>{
      'code': instance.code,
      'label': instance.label,
      'value': instance.value,
      'formattedValue': instance.formattedValue,
    };

ShippingAddress _$ShippingAddressFromJson(Map<String, dynamic> json) =>
    ShippingAddress(
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      city: json['city'] as String?,
      region: json['region'] as String?,
      street:
          (json['street'] as List<dynamic>?)?.map((e) => e as String).toList(),
      country: json['country'] as String?,
      pincode: json['pincode'] as String?,
    );

Map<String, dynamic> _$ShippingAddressToJson(ShippingAddress instance) =>
    <String, dynamic>{
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'city': instance.city,
      'region': instance.region,
      'street': instance.street,
      'country': instance.country,
      'pincode': instance.pincode,
    };

BillingAddress _$BillingAddressFromJson(Map<String, dynamic> json) =>
    BillingAddress(
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      city: json['city'] as String?,
      region: json['region'] as String?,
      street:
          (json['street'] as List<dynamic>?)?.map((e) => e as String).toList(),
      country: json['country'] as String?,
      pincode: json['pincode'] as String?,
    );

Map<String, dynamic> _$BillingAddressToJson(BillingAddress instance) =>
    <String, dynamic>{
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'city': instance.city,
      'region': instance.region,
      'street': instance.street,
      'country': instance.country,
      'pincode': instance.pincode,
    };

ShippingMethod _$ShippingMethodFromJson(Map<String, dynamic> json) =>
    ShippingMethod(
      title: json['title'] as String?,
    );

Map<String, dynamic> _$ShippingMethodToJson(ShippingMethod instance) =>
    <String, dynamic>{
      'title': instance.title,
    };

PaymentMethod _$PaymentMethodFromJson(Map<String, dynamic> json) =>
    PaymentMethod(
      title: json['title'] as String?,
    );

Map<String, dynamic> _$PaymentMethodToJson(PaymentMethod instance) =>
    <String, dynamic>{
      'title': instance.title,
    };
