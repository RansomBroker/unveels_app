import 'package:json_annotation/json_annotation.dart';

import '../base_model.dart';

part 'view_transaction_model.g.dart';

@JsonSerializable()
class ViewTransactionModel extends BaseModel {
  TransactionData? transactionData;

  ViewTransactionModel({this.transactionData});

  factory ViewTransactionModel.fromJson(Map<String, dynamic> json) =>
      _$ViewTransactionModelFromJson(json);
}

@JsonSerializable()
class TransactionData {
  DetailsModel? amount;
  DetailsModel? action;
  DetailsModel? type;
  DetailsModel? date;
  DetailsModel? note;
  DetailsModel? status;
  BankDetails? bankDetails;
  BankDetails? order;
  BankDetails? sender;

  TransactionData(
      {this.amount,
      this.action,
      this.type,
      this.date,
      this.note,
      this.status,
      this.bankDetails,
      this.order,
      this.sender});

  factory TransactionData.fromJson(Map<String, dynamic> json) =>
      _$TransactionDataFromJson(json);
}

@JsonSerializable()
class DetailsModel {
  String? label;
  String? value;
  DetailsModel({this.label, this.value});
  factory DetailsModel.fromJson(Map<String, dynamic> json) =>
      _$DetailsModelFromJson(json);
}

@JsonSerializable()
class BankDetails {
  dynamic label;
  dynamic value;
  BankDetails({this.label, this.value});
  factory BankDetails.fromJson(Map<String, dynamic> json) =>
      _$BankDetailsFromJson(json);
}
