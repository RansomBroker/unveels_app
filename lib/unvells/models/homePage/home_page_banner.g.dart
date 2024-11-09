// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_banner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Banners _$BannersFromJson(Map<String, dynamic> json) => Banners(
      title: json['title'] as String?,
      type: json['bannerType'] as String?,
      link: json['link'] as String?,
      url: json['url'] as String?,
      bannerImage: json['bannerImage'] as String?,
      dominantColor: json['dominant_color'] as String?,
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    )..route = json['route'] as String?;

Map<String, dynamic> _$BannersToJson(Banners instance) => <String, dynamic>{
      'title': instance.title,
      'bannerType': instance.type,
      'link': instance.link,
      'url': instance.url,
      'bannerImage': instance.bannerImage,
      'dominant_color': instance.dominantColor,
      'id': instance.id,
      'name': instance.name,
      'route': instance.route,
    };
