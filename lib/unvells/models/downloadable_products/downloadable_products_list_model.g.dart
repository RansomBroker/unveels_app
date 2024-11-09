// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'downloadable_products_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DownloadableProductsListModel _$DownloadableProductsListModelFromJson(
        Map<String, dynamic> json) =>
    DownloadableProductsListModel(
      downloadableProductsList: (json['downloadsList'] as List<dynamic>?)
          ?.map((e) =>
              DownloadableProductsListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num?)?.toInt(),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?;

Map<String, dynamic> _$DownloadableProductsListModelToJson(
        DownloadableProductsListModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
      'downloadsList': instance.downloadableProductsList,
      'totalCount': instance.totalCount,
    };

DownloadableProductsListData _$DownloadableProductsListDataFromJson(
        Map<String, dynamic> json) =>
    DownloadableProductsListData(
      incrementId: json['incrementId'] as String?,
      isOrderExist: json['isOrderExist'] as bool?,
      message: json['message'] as String?,
      hash: json['hash'] as String?,
      date: json['date'] as String?,
      proName: json['proName'] as String?,
      status: json['status'] as String?,
      statusColorCode: json['statusColorCode'] as String?,
      state: json['state'] as String?,
      remainingDownloads: json['remainingDownloads'] as String?,
      canReorder: json['canReorder'] as bool?,
    );

Map<String, dynamic> _$DownloadableProductsListDataToJson(
        DownloadableProductsListData instance) =>
    <String, dynamic>{
      'incrementId': instance.incrementId,
      'isOrderExist': instance.isOrderExist,
      'message': instance.message,
      'hash': instance.hash,
      'date': instance.date,
      'proName': instance.proName,
      'status': instance.status,
      'statusColorCode': instance.statusColorCode,
      'state': instance.state,
      'remainingDownloads': instance.remainingDownloads,
      'canReorder': instance.canReorder,
    };
