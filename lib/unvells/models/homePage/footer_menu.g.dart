// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'footer_menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FooterMenu _$FooterMenuFromJson(Map<String, dynamic> json) => FooterMenu(
      informationId: json['information_id'] as String?,
      title: json['title'] as String?,
      status: json['status'] as String?,
      sortOrder: json['sortOrder'] as String?,
    );

Map<String, dynamic> _$FooterMenuToJson(FooterMenu instance) =>
    <String, dynamic>{
      'information_id': instance.informationId,
      'title': instance.title,
      'status': instance.status,
      'sortOrder': instance.sortOrder,
    };
