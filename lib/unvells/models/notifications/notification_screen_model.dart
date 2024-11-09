/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:test_new/unvells/models/base_model.dart';

part 'notification_screen_model.g.dart';

@JsonSerializable()
class NotificationScreenModel extends BaseModel{

  @JsonKey(name: "notificationList")
  List<Notifications>? notificationList;

  int? error;

  NotificationScreenModel({this.notificationList, this.error});
  factory NotificationScreenModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationScreenModelFromJson(json);


}

@JsonSerializable()
class Notifications {
  @JsonKey(name:"id")
  String? id;
  @JsonKey(name:"productId")
  String? productId;
  String? title;
  @JsonKey(name:"banner")
  String? banner;
  @JsonKey(name:"dominantColor")
  String? dominantColor;
  String? notificationType;
  String? content;
  String? subTitle;

  Notifications(
      {this.id,
        this.productId,
        this.title,
        this.banner,
        this.dominantColor,
        this.notificationType,
        this.content,
        this.subTitle});
  factory Notifications.fromJson(Map<String, dynamic> json) =>
      _$NotificationsFromJson(json);

}

