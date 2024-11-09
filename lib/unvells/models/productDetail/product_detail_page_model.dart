/*
 *


 *
 * /
 */

import 'dart:ffi';

import 'package:test_new/unvells/models/categoryPage/product_tile_data.dart';
import 'package:test_new/unvells/models/productDetail/price_format.dart';
import 'package:test_new/unvells/models/productDetail/product_custom_option.dart';
import 'package:test_new/unvells/models/productDetail/product_review_data.dart';
import 'package:test_new/unvells/models/productDetail/rating_array.dart';
import 'package:test_new/unvells/models/productDetail/samples.dart';

import '../base_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'additional_information.dart';
import 'bundle_option.dart';
import 'configurable_data.dart';
import 'grouped_data.dart';
import 'image_gallery.dart';
import 'links.dart';
part 'product_detail_page_model.g.dart';

@JsonSerializable()
class ProductDetailPageModel extends BaseModel{

  String? id;
  String? sku;
  String? productUrl;
  String? name;
  // int?  is_product_try_on;
  String? formattedMinPrice;
  double? minPrice;
  String? formattedMaxPrice;
  double? maxPrice;
  String? formattedPrice;
  double? price;
  String? formattedFinalPrice;
  double? finalPrice;
  String? groupedPrice;
  double? rating;
  String? thumbNail;
  String? typeId;
  @JsonKey(name: "is_new")
  @JsonKey(name: "isNew")
  bool? isNew;
  int? msrpEnabled;
  String? msrpDisplayActualPriceType;
  double? msrp;
  String? formattedMsrp;
  String? shortDescription;
  String? description;
  bool? isInRange;
  bool? guestCanReview;
  String? availability;
  bool? isAvailable;
  PriceFormat? priceFormat;
  List<ImageGallery>? imageGallery;
  List<AdditionalInformation>? additionalInformation;
  List<ProductReviewData>? reviewList;
  String? priceView;
  List<String>? tierPrices;
  List<ProductTileData>? relatedProductList;
  List<GroupedData>? groupedData;
  Links? links;
  Samples? samples;
  List<BundleOption>? bundleOptions;

  @JsonKey(name: "configurableData")
  ConfigurableData? configurableData;

  bool? isInWishlist;
  int? wishlistItemId;
  List<ProductTileData>? upsellProductList;
  bool? showPriceDropAlert;
  bool? showBackInStockAlert;
  bool? isCheckoutAllowed;
  bool? isAllowedGuestCheckout;
  bool? canGuestCheckoutDownloadable;
  String? arType;
  String? arUrl;
  int? reviewCount;
  bool? isThresholdVisible;
  int? thresholdQtyLeft;
  List<RatingArray>? ratingsArray;
  List<ProductCustomOption>? customOptions;
  List<RatingFormData>? ratingFormData;

  ProductDetailPageModel(
      this.id,
      this.productUrl,
      this.name,
      this.formattedMinPrice,
      this.minPrice,
      this.formattedMaxPrice,
      this.maxPrice,
      this.formattedPrice,
      this.price,
      this.formattedFinalPrice,
      this.finalPrice,
      this.groupedPrice,
      this.rating,
      this.thumbNail,
      this.typeId,
      this.isNew,
      this.msrpEnabled,
      this.msrpDisplayActualPriceType,
      this.msrp,
      this.formattedMsrp,
      this.shortDescription,
      this.description,
      this.isInRange,
      this.guestCanReview,
      this.availability,
      this.isAvailable,
      this.priceFormat,
      this.imageGallery,
      this.additionalInformation,
      this.reviewList,
      this.priceView,
      this.tierPrices,
      this.relatedProductList,
      this.groupedData,
      this.links,
      this.samples,
      this.bundleOptions,
      this.configurableData,
      this.isInWishlist,
      this.wishlistItemId,
      this.upsellProductList,
      this.showPriceDropAlert,
      this.showBackInStockAlert,
      this.isCheckoutAllowed,
      this.isAllowedGuestCheckout,
      this.canGuestCheckoutDownloadable,
      this.arType,
      this.arUrl,
      this.reviewCount,
      this.isThresholdVisible,
      this.thresholdQtyLeft,
      this.ratingsArray,
      this.customOptions,
      this.ratingFormData
      );

  factory ProductDetailPageModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailPageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailPageModelToJson(this);


  // bool hasSpecialPrice(){
  //   return  double.parse(finalPrice) != 0.0 && double.parse(finalPrice) < double.parse(price!) && isInRange!;
  // }
  bool hasSpecialPrice(){
    // if (finalPrice != null) {
      return  finalPrice != 0.0 && finalPrice! < price! ;

  }

  bool hasPrice(){
    return !(hasMinPrice() || hasGroupedPrice());

  }

  bool hasMinPrice(){
    return ((minPrice??0.0) != 0.0);

  }

  bool hasMaxPrice(){
    return ((maxPrice??0.0) != 0.0)??false;

  }

  bool hasGroupedPrice(){
    return (groupedPrice?.isNotEmpty??false);

  }


  String getDiscountPercentage(){
    return "${(100 - finalPrice! / price! * 100).round()}";
  }

}
@JsonSerializable()
class RatingFormData{
  String? id;
  String? name;
  List<String>? values;
  double? selectedRating = 1.0;


  RatingFormData(this.id, this.name, this.values);

  factory RatingFormData.fromJson(Map<String, dynamic> json) =>
      _$RatingFormDataFromJson(json);

  Map<String, dynamic> toJson() => _$RatingFormDataToJson(this);
}