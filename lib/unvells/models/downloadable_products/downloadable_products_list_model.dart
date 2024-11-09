/*
 *


 *
 * /
 */

import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

import '../base_model.dart';

part 'downloadable_products_list_model.g.dart';

@JsonSerializable()
class DownloadableProductsListModel extends BaseModel{

  @JsonKey(name: "downloadsList")
  List<DownloadableProductsListData>? downloadableProductsList;

  @JsonKey(name: "totalCount")
  int? totalCount;

  DownloadableProductsListModel({this.downloadableProductsList, this.totalCount});

  factory DownloadableProductsListModel.fromJson(Map<String, dynamic> json) =>
      _$DownloadableProductsListModelFromJson(json);

  Map<String, dynamic> toJson() => _$DownloadableProductsListModelToJson(this);

}

@JsonSerializable()
class DownloadableProductsListData {

  @JsonKey(name: "incrementId")
  String? incrementId;

  @JsonKey(name: "isOrderExist")
  bool? isOrderExist = false;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "hash")
  String? hash;

  @JsonKey(name: "date")
  String? date;

  @JsonKey(name: "proName")
  String? proName;

  @JsonKey(name: "status")
  String? status;

  @JsonKey(name: "statusColorCode")
  String? statusColorCode;

  @JsonKey(name: "state")
  String? state;

  @JsonKey(name: "remainingDownloads")
  String? remainingDownloads;

  @JsonKey(name: "canReorder")
  bool? canReorder = false;

  DownloadableProductsListData(
      {this.incrementId,
        this.isOrderExist,
        this.message,
        this.hash,
        this.date,
        this.proName,
        this.status,
        this.statusColorCode,
        this.state,
        this.remainingDownloads,
        this.canReorder,
      });


  factory DownloadableProductsListData.fromJson(Map<String, dynamic> json) =>
      _$DownloadableProductsListDataFromJson(json);

  Map<String, dynamic> toJson() => _$DownloadableProductsListDataToJson(this);
}