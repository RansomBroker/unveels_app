// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ViewTransactionModel _$ViewTransactionModelFromJson(
        Map<String, dynamic> json) =>
    ViewTransactionModel(
      transactionData: json['transactionData'] == null
          ? null
          : TransactionData.fromJson(
              json['transactionData'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?;

Map<String, dynamic> _$ViewTransactionModelToJson(
        ViewTransactionModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
      'transactionData': instance.transactionData,
    };

TransactionData _$TransactionDataFromJson(Map<String, dynamic> json) =>
    TransactionData(
      amount: json['amount'] == null
          ? null
          : DetailsModel.fromJson(json['amount'] as Map<String, dynamic>),
      action: json['action'] == null
          ? null
          : DetailsModel.fromJson(json['action'] as Map<String, dynamic>),
      type: json['type'] == null
          ? null
          : DetailsModel.fromJson(json['type'] as Map<String, dynamic>),
      date: json['date'] == null
          ? null
          : DetailsModel.fromJson(json['date'] as Map<String, dynamic>),
      note: json['note'] == null
          ? null
          : DetailsModel.fromJson(json['note'] as Map<String, dynamic>),
      status: json['status'] == null
          ? null
          : DetailsModel.fromJson(json['status'] as Map<String, dynamic>),
      bankDetails: json['bankDetails'] == null
          ? null
          : BankDetails.fromJson(json['bankDetails'] as Map<String, dynamic>),
      order: json['order'] == null
          ? null
          : BankDetails.fromJson(json['order'] as Map<String, dynamic>),
      sender: json['sender'] == null
          ? null
          : BankDetails.fromJson(json['sender'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransactionDataToJson(TransactionData instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'action': instance.action,
      'type': instance.type,
      'date': instance.date,
      'note': instance.note,
      'status': instance.status,
      'bankDetails': instance.bankDetails,
      'order': instance.order,
      'sender': instance.sender,
    };

DetailsModel _$DetailsModelFromJson(Map<String, dynamic> json) => DetailsModel(
      label: json['label'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$DetailsModelToJson(DetailsModel instance) =>
    <String, dynamic>{
      'label': instance.label,
      'value': instance.value,
    };

BankDetails _$BankDetailsFromJson(Map<String, dynamic> json) => BankDetails(
      label: json['label'],
      value: json['value'],
    );

Map<String, dynamic> _$BankDetailsToJson(BankDetails instance) =>
    <String, dynamic>{
      'label': instance.label,
      'value': instance.value,
    };
