/*
 *


 *
 * /
 */

import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

import '../base_model.dart';

part 'order_list_model.g.dart';

@JsonSerializable()
class OrderListModel extends BaseModel{

  @JsonKey(name: "orderList")
  List<OrderListData>? orderList;

  @JsonKey(name: "totalCount")
  int? totalCount;

  OrderListModel({this.orderList, this.totalCount});

  factory OrderListModel.fromJson(Map<String, dynamic> json) =>
      _$OrderListModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderListModelToJson(this);

}

@JsonSerializable()
class OrderListData {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "order_id")
  String? orderId;

  @JsonKey(name: "date")
  String? date;

  @JsonKey(name: "ship_to")
  String? shipTo;

  @JsonKey(name: "item_count")
  String? itemCount;

  @JsonKey(name: "order_total")
  String? orderTotal;

  @JsonKey(name: "item_image_url")
  String? itemImageUrl;

  @JsonKey(name: "dominantColor")
  String? dominantColor;

  @JsonKey(name: "status")
  String? status;

  @JsonKey(name: "canReorder")
  bool? canReorder = false;

  @JsonKey(name: "state")
  String? state;

  @JsonKey(name: "statusColorCode")
  String? statusColorCode;



  OrderListData(
      {this.id,
        this.orderId,
        this.date,
        this.shipTo,
        this.itemCount,
        this.orderTotal,
        this.itemImageUrl,
        this.dominantColor,
        this.status,
        this.canReorder,
        this.state,
        this.statusColorCode,
      });


  factory OrderListData.fromJson(Map<String, dynamic> json) =>
      _$OrderListDataFromJson(json);

  Map<String, dynamic> toJson() => _$OrderListDataToJson(this);
}