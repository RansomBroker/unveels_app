// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailModel _$OrderDetailModelFromJson(Map<String, dynamic> json) =>
    OrderDetailModel(
      incrementId: json['incrementId'] as String?,
      statusColorCode: json['statusColorCode'] as String?,
      statusLabel: json['statusLabel'] as String?,
      orderDate: json['orderDate'] as String?,
      shippingAddress: json['shippingAddress'] as String?,
      shippingMethod: json['shippingMethod'] as String?,
      billingAddress: json['billingAddress'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
      orderData: json['orderData'] == null
          ? null
          : OrderData.fromJson(json['orderData'] as Map<String, dynamic>),
      canReorder: json['canReorder'] as bool?,
      state: json['state'] as String?,
      customerName: json['customerName'] as String?,
      customerEmail: json['customerEmail'] as String?,
      invoiceList: (json['invoiceList'] as List<dynamic>?)
          ?.map((e) => InvoiceListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      shipmentList: (json['shipmentList'] as List<dynamic>?)
          ?.map((e) => ShipmentListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      creditmemoList: (json['creditmemoList'] as List<dynamic>?)
          ?.map((e) => Creditmemo.fromJson(e as Map<String, dynamic>))
          .toList(),
      adminAddress: json['adminAddress'] as String?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?
      ..error = (json['error'] as num?)?.toInt();

Map<String, dynamic> _$OrderDetailModelToJson(OrderDetailModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
      'incrementId': instance.incrementId,
      'statusColorCode': instance.statusColorCode,
      'statusLabel': instance.statusLabel,
      'orderDate': instance.orderDate,
      'shippingAddress': instance.shippingAddress,
      'shippingMethod': instance.shippingMethod,
      'billingAddress': instance.billingAddress,
      'paymentMethod': instance.paymentMethod,
      'orderData': instance.orderData,
      'canReorder': instance.canReorder,
      'state': instance.state,
      'customerName': instance.customerName,
      'customerEmail': instance.customerEmail,
      'invoiceList': instance.invoiceList,
      'shipmentList': instance.shipmentList,
      'creditmemoList': instance.creditmemoList,
      'adminAddress': instance.adminAddress,
      'error': instance.error,
    };

OrderData _$OrderDataFromJson(Map<String, dynamic> json) => OrderData(
      itemList: (json['itemList'] as List<dynamic>?)
          ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totals: (json['totals'] as List<dynamic>?)
          ?.map((e) => TotalItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderDataToJson(OrderData instance) => <String, dynamic>{
      'itemList': instance.itemList,
      'totals': instance.totals,
    };

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
      productId: json['productId'] as String?,
      name: json['name'] as String?,
      sku: json['sku'] as String?,
      image: json['image'] as String?,
      dominantColor: json['dominantColor'] as String?,
      price: json['price'] as String?,
      qty: json['qty'] == null
          ? null
          : OrderQty.fromJson(json['qty'] as Map<String, dynamic>),
      subTotal: json['subTotal'] as String?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => OptionsItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'productId': instance.productId,
      'name': instance.name,
      'sku': instance.sku,
      'image': instance.image,
      'dominantColor': instance.dominantColor,
      'price': instance.price,
      'qty': instance.qty,
      'subTotal': instance.subTotal,
      'options': instance.options,
    };

OrderQty _$OrderQtyFromJson(Map<String, dynamic> json) => OrderQty(
      ordered: json['Ordered'],
      shipped: json['Shipped'],
      canceled: json['Canceled'],
      refunded: json['Refunded'],
    );

Map<String, dynamic> _$OrderQtyToJson(OrderQty instance) => <String, dynamic>{
      'Ordered': instance.ordered,
      'Shipped': instance.shipped,
      'Canceled': instance.canceled,
      'Refunded': instance.refunded,
    };

OptionsItem _$OptionsItemFromJson(Map<String, dynamic> json) => OptionsItem(
      label: json['label'] as String?,
      value: json['value'],
      valueIds: (json['valueIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$OptionsItemToJson(OptionsItem instance) =>
    <String, dynamic>{
      'label': instance.label,
      'value': instance.value,
      'valueIds': instance.valueIds,
    };

TotalItem _$TotalItemFromJson(Map<String, dynamic> json) => TotalItem(
      code: json['code'] as String?,
      label: json['label'] as String?,
      value: json['value'] as String?,
      formattedValue: json['formattedValue'] as String?,
    );

Map<String, dynamic> _$TotalItemToJson(TotalItem instance) => <String, dynamic>{
      'code': instance.code,
      'label': instance.label,
      'value': instance.value,
      'formattedValue': instance.formattedValue,
    };

ShipmentListData _$ShipmentListDataFromJson(Map<String, dynamic> json) =>
    ShipmentListData(
      id: json['id'] as String?,
      incrementId: json['incrementId'] as String?,
      itemsData: (json['items'] as List<dynamic>?)
          ?.map((e) => ShipmentItemsData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ShipmentListDataToJson(ShipmentListData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'incrementId': instance.incrementId,
      'items': instance.itemsData,
    };

ShipmentItemsData _$ShipmentItemsDataFromJson(Map<String, dynamic> json) =>
    ShipmentItemsData(
      name: json['name'] as String?,
      option: json['option'] as List<dynamic>?,
      qty: (json['qty'] as num?)?.toInt(),
      sku: json['sku'] as String?,
    );

Map<String, dynamic> _$ShipmentItemsDataToJson(ShipmentItemsData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'option': instance.option,
      'qty': instance.qty,
      'sku': instance.sku,
    };

InvoiceListData _$InvoiceListDataFromJson(Map<String, dynamic> json) =>
    InvoiceListData(
      id: json['id'] as String?,
      incrementId: json['incrementId'] as String?,
      itemsData: (json['items'] as List<dynamic>?)
          ?.map((e) => ItemsData.fromJson(e as Map<String, dynamic>))
          .toList(),
      price: json['price'] as String?,
      qty: (json['qty'] as num?)?.toInt(),
      sku: json['sku'] as String?,
      subTotal: json['subTotal'] as String?,
    )..totals = (json['totals'] as List<dynamic>?)
        ?.map((e) => TotalsData.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$InvoiceListDataToJson(InvoiceListData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'incrementId': instance.incrementId,
      'items': instance.itemsData,
      'price': instance.price,
      'qty': instance.qty,
      'sku': instance.sku,
      'subTotal': instance.subTotal,
      'totals': instance.totals,
    };

ItemsData _$ItemsDataFromJson(Map<String, dynamic> json) => ItemsData(
      dominantColor: json['dominantColor'] as String?,
      image: json['image'] as String?,
      option:
          (json['option'] as List<dynamic>?)?.map((e) => e as String).toList(),
      name: json['name'] as String?,
      price: json['price'] as String?,
      productId: json['productId'] as String?,
      qty: (json['qty'] as List<dynamic>?)
          ?.map((e) => QtyData.fromJson(e as Map<String, dynamic>))
          .toList(),
      sku: json['sku'] as String?,
      subTotal: json['subTotal'] as String?,
    );

Map<String, dynamic> _$ItemsDataToJson(ItemsData instance) => <String, dynamic>{
      'dominantColor': instance.dominantColor,
      'image': instance.image,
      'option': instance.option,
      'name': instance.name,
      'price': instance.price,
      'productId': instance.productId,
      'qty': instance.qty,
      'sku': instance.sku,
      'subTotal': instance.subTotal,
    };

QtyData _$QtyDataFromJson(Map<String, dynamic> json) => QtyData(
      canceled: json['canceled'] as String?,
      ordered: json['ordered'] as String?,
      refunded: json['refunded'] as String?,
      shipped: json['shipped'] as String?,
    );

Map<String, dynamic> _$QtyDataToJson(QtyData instance) => <String, dynamic>{
      'canceled': instance.canceled,
      'ordered': instance.ordered,
      'refunded': instance.refunded,
      'shipped': instance.shipped,
    };

TotalsData _$TotalsDataFromJson(Map<String, dynamic> json) => TotalsData(
      code: json['code'] as String?,
      formattedValue: json['formattedValue'] as String?,
      label: json['label'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$TotalsDataToJson(TotalsData instance) =>
    <String, dynamic>{
      'code': instance.code,
      'formattedValue': instance.formattedValue,
      'label': instance.label,
      'value': instance.value,
    };

Creditmemo _$CreditmemoFromJson(Map<String, dynamic> json) => Creditmemo(
      incrementId: json['incrementId'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => CreditmemoItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreditmemoToJson(Creditmemo instance) =>
    <String, dynamic>{
      'incrementId': instance.incrementId,
      'items': instance.items,
    };

CreditmemoItem _$CreditmemoItemFromJson(Map<String, dynamic> json) =>
    CreditmemoItem(
      name: json['name'] as String?,
      sku: json['sku'] as String?,
      price: json['price'] as String?,
      qty: (json['qty'] as num?)?.toInt(),
      subTotal: json['subTotal'] as String?,
      discountAmount: json['discountAmount'] as String?,
      rowTotal: json['rowTotal'] as String?,
    );

Map<String, dynamic> _$CreditmemoItemToJson(CreditmemoItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'sku': instance.sku,
      'price': instance.price,
      'qty': instance.qty,
      'subTotal': instance.subTotal,
      'discountAmount': instance.discountAmount,
      'rowTotal': instance.rowTotal,
    };
