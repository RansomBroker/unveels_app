
/*
 *
  

 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';

import '../base_model.dart';
part 'wishlist_model.g.dart';


@JsonSerializable()
class WishlistModel extends BaseModel{

  @JsonKey(name: "wishList")
  List<WishlistData>? wishList;

  @JsonKey(name: "totalCount")
  int? totalCount;

  WishlistModel({this.wishList, this.totalCount});

  factory WishlistModel.fromJson(Map<String, dynamic> json) =>
      _$WishlistModelFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistModelToJson(this);

}

@JsonSerializable()
class WishlistData {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "qty")
  int? qty;

  @JsonKey(name: "sku")
  String? sku;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "price")
  dynamic? price;

  @JsonKey(name: "productId")
  String? productId;

  @JsonKey(name: "thumbNail")
  String? thumbNail;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "options")
  List<OptionsData>? options;

  @JsonKey(name: "reviewCount")
  int? reviewCount;

  @JsonKey(name: "configurableData")
  ConfigurableData? configurableData;

  @JsonKey(name: "isInWishlist")
  bool? isInWishlist;

  @JsonKey(name: "typeId")
  String? typeId;

  @JsonKey(name: "entityId")
  int? entityId;

  @JsonKey(name: "rating")
  String? rating;

  @JsonKey(name: "isAvailable")
  bool? isAvailable;

  @JsonKey(name: "finalPrice")
  String? finalPrice;

  @JsonKey(name: "formattedPrice")
  String? formattedPrice;

  @JsonKey(name: "formattedFinalPrice")
  String? formattedFinalPrice;

  @JsonKey(name: "hasRequiredOptions")
  bool? hasRequiredOptions;

  @JsonKey(name: "isNew")
  bool? isNew;

  @JsonKey(name: "isInRange")
  bool? isInRange;

  @JsonKey(name: "dominantColor")
  String? dominantColor;

  @JsonKey(name: "tierPrice")
  String? tierPrice;

  @JsonKey(name: "formattedTierPrice")
  String? formattedTierPrice;

  @JsonKey(name: "minAddToCartQty")
  int? minAddToCartQty;

  @JsonKey(name: "availability")
  String? availability;

  @JsonKey(name: "arUrl")
  String? arUrl;

  @JsonKey(name: "arType")
  String? arType;

  // @JsonKey(name: "arTextureImages")
  // List<ArTextureImagesData>? arTextureImages;


  WishlistData(
      {this.id,
        this.qty,
        this.sku,
        this.name,
        this.price,
        this.productId,
        this.thumbNail,
        this.description,
        this.options,
        this.reviewCount,
        this.configurableData,
        this.isInWishlist,
        this.typeId,
        this.entityId,
        this.rating,
        this.isAvailable,
        this.finalPrice,
        this.formattedPrice,
        this.formattedFinalPrice,
        this.hasRequiredOptions,
        this.isNew,
        this.isInRange,
        this.dominantColor,
        this.tierPrice,
        this.formattedTierPrice,
        this.minAddToCartQty,
        this.availability,
        this.arUrl,
        this.arType,
        // this.arTextureImages,
      });


  factory WishlistData.fromJson(Map<String, dynamic> json) =>
      _$WishlistDataFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistDataToJson(this);
}


@JsonSerializable()
class OptionsData {

  @JsonKey(name: "optionMessage")
  String? optionMessage;

  OptionsData({this.optionMessage});

  factory OptionsData.fromJson(Map<String, dynamic> json) =>
      _$OptionsDataFromJson(json);

  Map<String, dynamic> toJson() => _$OptionsDataToJson(this);
}

@JsonSerializable()
class ConfigurableData {

  @JsonKey(name: "configurableMessage")
  String? configurableMessage;

  ConfigurableData({this.configurableMessage});

  factory ConfigurableData.fromJson(Map<String, dynamic> json) =>
      _$ConfigurableDataFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigurableDataToJson(this);
}


@JsonSerializable()
class ArTextureImagesData {

  @JsonKey(name: "arTextureMessage")
  String? arTextureMessage;

  ArTextureImagesData({this.arTextureMessage});

  factory ArTextureImagesData.fromJson(Map<String, dynamic> json) =>
      _$ArTextureImagesDataFromJson(json);

  Map<String, dynamic> toJson() => _$ArTextureImagesDataToJson(this);
}



