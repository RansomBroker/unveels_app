// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_dashboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletDashboardModel _$WalletDashboardModelFromJson(
        Map<String, dynamic> json) =>
    WalletDashboardModel(
      accountDetails: (json['accountDetails'] as List<dynamic>?)
          ?.map((e) => AccountList.fromJson(e as Map<String, dynamic>))
          .toList(),
      buttonLabel: json['buttonLabel'] as String?,
      currencyCode: json['currencyCode'] as String?,
      idd: (json['idd'] as num?)?.toInt(),
      logo: json['logo'] as String?,
      mainHeading: json['mainHeading'] as String?,
      maximumAmount: (json['maximumAmount'] as num?)?.toInt(),
      messageForAccountDetails: json['messageForAccountDetails'] as String?,
      minimumAmount: (json['minimumAmount'] as num?)?.toInt(),
      rechargeFieldLabel: json['rechargeFieldLabel'] as String?,
      subHeading: (json['subHeading'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      transactionList: (json['transactionList'] as List<dynamic>?)
          ?.map((e) => TransactionList.fromJson(e as Map<String, dynamic>))
          .toList(),
      walletAmount: json['walletAmount'] as String?,
      walletProductId: (json['walletProductId'] as num?)?.toInt(),
      walletSummaryHeading: json['walletSummaryHeading'] as String?,
      walletSummarySubHeading: json['walletSummarySubHeading'] as String?,
      payeeList: (json['payeeList'] as List<dynamic>?)
          ?.map((e) => PayeeList.fromJson(e as Map<String, dynamic>))
          .toList(),
      walletData: json['walletData'] == null
          ? null
          : WalletData.fromJson(json['walletData'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?;

Map<String, dynamic> _$WalletDashboardModelToJson(
        WalletDashboardModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
      'maximumAmount': instance.maximumAmount,
      'minimumAmount': instance.minimumAmount,
      'logo': instance.logo,
      'walletSummaryHeading': instance.walletSummaryHeading,
      'currencyCode': instance.currencyCode,
      'walletAmount': instance.walletAmount,
      'walletSummarySubHeading': instance.walletSummarySubHeading,
      'rechargeFieldLabel': instance.rechargeFieldLabel,
      'walletProductId': instance.walletProductId,
      'buttonLabel': instance.buttonLabel,
      'mainHeading': instance.mainHeading,
      'subHeading': instance.subHeading,
      'transactionList': instance.transactionList,
      'payeeList': instance.payeeList,
      'walletData': instance.walletData,
      'accountDetails': instance.accountDetails,
      'messageForAccountDetails': instance.messageForAccountDetails,
      'idd': instance.idd,
    };

TransactionList _$TransactionListFromJson(Map<String, dynamic> json) =>
    TransactionList(
      viewId: (json['viewId'] as num?)?.toInt(),
      incrementId: json['incrementId'] as String?,
      description: json['description'] as String?,
      debit: json['debit'] as String?,
      credit: json['credit'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$TransactionListToJson(TransactionList instance) =>
    <String, dynamic>{
      'viewId': instance.viewId,
      'incrementId': instance.incrementId,
      'description': instance.description,
      'debit': instance.debit,
      'credit': instance.credit,
      'status': instance.status,
    };

PayeeList _$PayeeListFromJson(Map<String, dynamic> json) => PayeeList(
      email: json['email'] as String?,
      name: json['name'] as String?,
      status: json['status'] as String?,
      id: (json['id'] as num?)?.toInt(),
      customerId: (json['customerId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PayeeListToJson(PayeeList instance) => <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'name': instance.name,
      'email': instance.email,
      'status': instance.status,
    };

WalletData _$WalletDataFromJson(Map<String, dynamic> json) => WalletData(
      formattedLeftInWallet: json['formattedLeftInWallet'] as String?,
      formattedPaymentToMade: json['formattedPaymentToMade'] as String?,
      unformattedLeftInWallet:
          (json['unformattedLeftInWallet'] as num?)?.toInt(),
      formattedAmountInWallet: json['formattedAmountInWallet'] as String?,
      unformattedPaymentToMade:
          (json['unformattedPaymentToMade'] as num?)?.toInt(),
      formattedLeftAmountToPay: json['formattedLeftAmountToPay'] as String?,
      unformattedAmountInWallet:
          (json['unformattedAmountInWallet'] as num?)?.toInt(),
      unformattedLeftAmountToPay:
          (json['unformattedLeftAmountToPay'] as num?)?.toInt(),
    );

Map<String, dynamic> _$WalletDataToJson(WalletData instance) =>
    <String, dynamic>{
      'formattedLeftInWallet': instance.formattedLeftInWallet,
      'formattedPaymentToMade': instance.formattedPaymentToMade,
      'unformattedLeftInWallet': instance.unformattedLeftInWallet,
      'formattedAmountInWallet': instance.formattedAmountInWallet,
      'unformattedPaymentToMade': instance.unformattedPaymentToMade,
      'formattedLeftAmountToPay': instance.formattedLeftAmountToPay,
      'unformattedAmountInWallet': instance.unformattedAmountInWallet,
      'unformattedLeftAmountToPay': instance.unformattedLeftAmountToPay,
    };

AccountList _$AccountListFromJson(Map<String, dynamic> json) => AccountList(
      bankName: json['bankName'] as String?,
      id: (json['id'] as num?)?.toInt(),
      accountNumber: json['accountNumber'] as String?,
      accountHolderName: json['accountHolderName'] as String?,
    );

Map<String, dynamic> _$AccountListToJson(AccountList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bankName': instance.bankName,
      'accountNumber': instance.accountNumber,
      'accountHolderName': instance.accountHolderName,
    };
