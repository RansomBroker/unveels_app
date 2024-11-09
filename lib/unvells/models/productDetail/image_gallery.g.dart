// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_gallery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageGallery _$ImageGalleryFromJson(Map<String, dynamic> json) => ImageGallery(
      json['smallImage'] as String?,
      json['largeImage'] as String?,
      json['dominantColor'] as String?,
      json['isVideo'] as bool?,
      json['videoUrl'] as String?,
    );

Map<String, dynamic> _$ImageGalleryToJson(ImageGallery instance) =>
    <String, dynamic>{
      'smallImage': instance.smallImage,
      'largeImage': instance.largeImage,
      'dominantColor': instance.dominantColor,
      'isVideo': instance.isVideo,
      'videoUrl': instance.videoUrl,
    };
