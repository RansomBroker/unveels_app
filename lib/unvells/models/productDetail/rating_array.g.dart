// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_array.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingArray _$RatingArrayFromJson(Map<String, dynamic> json) => RatingArray(
      (json['1'] as num?)?.toDouble(),
      (json['2'] as num?)?.toDouble(),
      (json['3'] as num?)?.toDouble(),
      (json['4'] as num?)?.toDouble(),
      (json['5'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$RatingArrayToJson(RatingArray instance) =>
    <String, dynamic>{
      '1': instance.one,
      '2': instance.two,
      '3': instance.three,
      '4': instance.four,
      '5': instance.five,
    };
