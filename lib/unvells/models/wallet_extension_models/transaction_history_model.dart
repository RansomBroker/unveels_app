import 'package:json_annotation/json_annotation.dart';
part 'transaction_history_model.g.dart';

@JsonSerializable()
class TransactionDetails {
  @JsonKey(name: "lasttransactions")
  List<TransactionHistory>? lastTransaction;
  TransactionDetails({this.lastTransaction});
  factory TransactionDetails.fromJson(Map<String, dynamic> json) => _$TransactionDetailsFromJson(json);
}

@JsonSerializable()
class TransactionHistory {
  String? reference;
  String? debit;
  String? credit;
  String? status;
  TransactionHistory({this.status, this.credit, this.debit, this.reference});
  factory TransactionHistory.fromJson(Map<String, dynamic> json) => _$TransactionHistoryFromJson(json);
}