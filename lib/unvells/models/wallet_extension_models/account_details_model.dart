import 'package:json_annotation/json_annotation.dart';

import '../base_model.dart';
part 'account_details_model.g.dart';

@JsonSerializable()

class AccountDetailsModel extends BaseModel {
  List<AccountDetails>? accountDetails;
  AccountDetailsModel({this.accountDetails});

  factory AccountDetailsModel.fromJson(Map<String, dynamic> json) => _$AccountDetailsModelFromJson(json);
}

@JsonSerializable()
class AccountDetails {
  int? id;
  String? customerName;
  String? customerEmail;
  String? acholderName;
  String? acNumber;
  String? bankName;
  String? accountHolderName;
  String? bankCode;
  String? additionalInformation;
  bool? requestForDelete;

  AccountDetails(
      {this.id,
        this.customerName,
        this.customerEmail,
        this.acholderName,
        this.acNumber,
        this.bankName,
        this.accountHolderName,
        this.bankCode,
        this.additionalInformation,
        this.requestForDelete});

  factory AccountDetails.fromJson(Map<String, dynamic> json) => _$AccountDetailsFromJson(json);
}