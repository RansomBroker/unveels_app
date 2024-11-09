
/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';
part 'sort_order.g.dart';

@JsonSerializable()
class SortOrder{

  int? id;
  String? layoutId;
  String? label;
  String? position;
  String? type;

  List<String> getPositionArray(){
    List<String> positionArray=[];
    if(position!=null){
      positionArray = (position??'').split(",");
      if(positionArray.last.isEmpty) {
        positionArray.removeLast();
      }
    }

    return positionArray;
  }

  SortOrder.empty(){
  }

  SortOrder({this.id, this.layoutId, this.label, required this.position, this.type});

  factory SortOrder.fromJson(Map<String, dynamic> json) =>
      _$SortOrderFromJson(json);

  Map<String, dynamic> toJson() => _$SortOrderToJson(this);
}