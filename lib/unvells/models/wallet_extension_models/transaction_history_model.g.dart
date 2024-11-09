// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionDetails _$TransactionDetailsFromJson(Map<String, dynamic> json) =>
    TransactionDetails(
      lastTransaction: (json['lasttransactions'] as List<dynamic>?)
          ?.map((e) => TransactionHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TransactionDetailsToJson(TransactionDetails instance) =>
    <String, dynamic>{
      'lasttransactions': instance.lastTransaction,
    };

TransactionHistory _$TransactionHistoryFromJson(Map<String, dynamic> json) =>
    TransactionHistory(
      status: json['status'] as String?,
      credit: json['credit'] as String?,
      debit: json['debit'] as String?,
      reference: json['reference'] as String?,
    );

Map<String, dynamic> _$TransactionHistoryToJson(TransactionHistory instance) =>
    <String, dynamic>{
      'reference': instance.reference,
      'debit': instance.debit,
      'credit': instance.credit,
      'status': instance.status,
    };
