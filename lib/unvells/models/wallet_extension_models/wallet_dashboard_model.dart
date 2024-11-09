import 'package:json_annotation/json_annotation.dart';
import 'package:test_new/unvells/models/base_model.dart';

part 'wallet_dashboard_model.g.dart';

@JsonSerializable()
class WalletDashboardModel extends BaseModel {
  int? maximumAmount;
  int? minimumAmount;
  String? logo;
  String? walletSummaryHeading;
  String? currencyCode;
  String? walletAmount;
  String? walletSummarySubHeading;
  String? rechargeFieldLabel;
  int? walletProductId;
  String? buttonLabel;
  String? mainHeading;
  List<String>? subHeading;
  List<TransactionList>? transactionList;
  List<PayeeList>? payeeList;
  WalletData? walletData;
  List<AccountList>? accountDetails;
  String? messageForAccountDetails;
  int? idd;

  WalletDashboardModel(
      {this.accountDetails,
        this.buttonLabel,
        this.currencyCode,
        this.idd,
        this.logo,
        this.mainHeading,
        this.maximumAmount,
        this.messageForAccountDetails,
        this.minimumAmount,
        this.rechargeFieldLabel,
        this.subHeading,
        this.transactionList,
        this.walletAmount,
        this.walletProductId,
        this.walletSummaryHeading,
        this.walletSummarySubHeading,
        this.payeeList,
        this.walletData
      });
  factory WalletDashboardModel.fromJson(Map<String, dynamic> json) => _$WalletDashboardModelFromJson(json);
}

@JsonSerializable()
class TransactionList {
  int? viewId;
  String? incrementId;
  String? description;
  String? debit;
  String? credit;
  String? status;

  TransactionList(
      {this.viewId,
        this.incrementId,
        this.description,
        this.debit,
        this.credit,
        this.status});

  factory TransactionList.fromJson(Map<String, dynamic> json) => _$TransactionListFromJson(json);
}

@JsonSerializable()
class PayeeList {
  int? id;
  int? customerId;
  String? name;
  String? email;
  String? status;
  PayeeList({this.email, this.name, this.status, this.id, this.customerId});
  factory PayeeList.fromJson(Map<String, dynamic> json) => _$PayeeListFromJson(json);
}

@JsonSerializable()
class WalletData {
  String? formattedLeftInWallet;
  String? formattedPaymentToMade;
  int? unformattedLeftInWallet;
  String? formattedAmountInWallet;
  int? unformattedPaymentToMade;
  String? formattedLeftAmountToPay;
  int? unformattedAmountInWallet;
  int? unformattedLeftAmountToPay;

  WalletData({this.formattedLeftInWallet,
    this.formattedPaymentToMade,
    this.unformattedLeftInWallet,
    this.formattedAmountInWallet,
    this.unformattedPaymentToMade,
    this.formattedLeftAmountToPay,
    this.unformattedAmountInWallet,
    this.unformattedLeftAmountToPay});

  factory WalletData.fromJson(Map<String, dynamic> json) => _$WalletDataFromJson(json);
}

@JsonSerializable()
class AccountList{
  int? id;
  String? bankName;
  String? accountNumber;
  String? accountHolderName;
  AccountList({this.bankName, this.id, this.accountNumber, this.accountHolderName});
  factory AccountList.fromJson(Map<String, dynamic> json) => _$AccountListFromJson(json);
}
