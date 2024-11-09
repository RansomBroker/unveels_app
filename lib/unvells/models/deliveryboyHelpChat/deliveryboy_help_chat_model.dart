
/*
 *
  

 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:test_new/unvells/models/base_model.dart';
part 'deliveryboy_help_chat_model.g.dart';

@JsonSerializable()
class DeliveryboyHelpChatModel extends BaseModel {

  @JsonKey(name:"apiKey")
  String? apiKey;

  @JsonKey(name:"sellerList")
  List<SellerListData>? sellerList;

  DeliveryboyHelpChatModel({this.sellerList,this.apiKey});

  factory DeliveryboyHelpChatModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveryboyHelpChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryboyHelpChatModelToJson(this);

}


@JsonSerializable()
class SellerListData {
  @JsonKey(name:"customerId")
  int? customerId;

  @JsonKey(name:"customerToken")
  String? customerToken;

  @JsonKey(name:"token")
  String? token;

  @JsonKey(name:"name")
  String? name;

  @JsonKey(name:"email")
  String? email;

  @JsonKey(name:"profileImage")
  String? profileImage;

  SellerListData({this.name,this.customerId,this.customerToken,this.profileImage,this.token,this.email});

  factory SellerListData.fromJson(Map<String, dynamic> json) =>
      _$SellerListDataFromJson(json);

  Map<String, dynamic> toJson() => _$SellerListDataToJson(this);

}