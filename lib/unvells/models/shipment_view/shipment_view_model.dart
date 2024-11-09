/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:test_new/unvells/models/base_model.dart';

part 'shipment_view_model.g.dart';

@JsonSerializable()
class ShipmentViewModel extends BaseModel {
  @JsonKey(name: "orderId")
  int? orderId;

  @JsonKey(name: "itemList")
  List<ItemShipmentListData>? itemList;

  @JsonKey(name: "trackingData")
  List<TrackingListData>? trackingData;

  @JsonKey(name:"eTag")
  String? eTag;

  ShipmentViewModel(
      {
        this.orderId,
        this.itemList,
        this.trackingData,
        this.eTag
      });

  factory ShipmentViewModel.fromJson(Map<String, dynamic> json) =>
      _$ShipmentViewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShipmentViewModelToJson(this);

}

@JsonSerializable()
class ItemShipmentListData {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "productId")
  String? productId;

  @JsonKey(name: "sku")
  String? sku;

  @JsonKey(name: "option")
  List<dynamic>? option;

  @JsonKey(name: "qty")
  int? qty;

  ItemShipmentListData(
      {
        this.id,
        this.name,
        this.productId,
        this.sku,
        this.option,
        this.qty
      });

  factory ItemShipmentListData.fromJson(Map<String, dynamic> json) =>
      _$ItemShipmentListDataFromJson(json);

  Map<String, dynamic> toJson() => _$ItemShipmentListDataToJson(this);
}

@JsonSerializable()
class TrackingListData {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "number")
  String? number;

  @JsonKey(name: "carrier")
  String? carrier;

  TrackingListData(
      {
        this.id,
        this.title,
        this.number,
        this.carrier
      });

  factory TrackingListData.fromJson(Map<String, dynamic> json) =>
      _$TrackingListDataFromJson(json);

  Map<String, dynamic> toJson() => _$TrackingListDataToJson(this);
}

