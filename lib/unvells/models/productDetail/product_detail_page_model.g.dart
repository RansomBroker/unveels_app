// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailPageModel _$ProductDetailPageModelFromJson(
        Map<String, dynamic> json) =>
    ProductDetailPageModel(
      json['id'] as String?,
      json['productUrl'] as String?,
      json['name'] as String?,
      json['formattedMinPrice'] as String?,
      (json['minPrice'] as num?)?.toDouble(),
      json['formattedMaxPrice'] as String?,
      (json['maxPrice'] as num?)?.toDouble(),
      json['formattedPrice'] as String?,
      (json['price'] as num?)?.toDouble(),
      json['formattedFinalPrice'] as String?,
      (json['finalPrice'] as num?)?.toDouble(),
      json['groupedPrice'] as String?,
      (json['rating'] as num?)?.toDouble(),
      json['thumbNail'] as String?,
      json['typeId'] as String?,
      json['is_new'] as bool?,
      (json['msrpEnabled'] as num?)?.toInt(),
      json['msrpDisplayActualPriceType'] as String?,
      (json['msrp'] as num?)?.toDouble(),
      json['formattedMsrp'] as String?,
      json['shortDescription'] as String?,
      json['description'] as String?,
      json['isInRange'] as bool?,
      json['guestCanReview'] as bool?,
      json['availability'] as String?,
      json['isAvailable'] as bool?,
      json['priceFormat'] == null
          ? null
          : PriceFormat.fromJson(json['priceFormat'] as Map<String, dynamic>),
      (json['imageGallery'] as List<dynamic>?)
          ?.map((e) => ImageGallery.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['additionalInformation'] as List<dynamic>?)
          ?.map(
              (e) => AdditionalInformation.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['reviewList'] as List<dynamic>?)
          ?.map((e) => ProductReviewData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['priceView'] as String?,
      (json['tierPrices'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['relatedProductList'] as List<dynamic>?)
          ?.map((e) => ProductTileData.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['groupedData'] as List<dynamic>?)
          ?.map((e) => GroupedData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['links'] == null
          ? null
          : Links.fromJson(json['links'] as Map<String, dynamic>),
      json['samples'] == null
          ? null
          : Samples.fromJson(json['samples'] as Map<String, dynamic>),
      (json['bundleOptions'] as List<dynamic>?)
          ?.map((e) => BundleOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['configurableData'] == null
          ? null
          : ConfigurableData.fromJson(
              json['configurableData'] as Map<String, dynamic>),
      json['isInWishlist'] as bool?,
      (json['wishlistItemId'] as num?)?.toInt(),
      (json['upsellProductList'] as List<dynamic>?)
          ?.map((e) => ProductTileData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['showPriceDropAlert'] as bool?,
      json['showBackInStockAlert'] as bool?,
      json['isCheckoutAllowed'] as bool?,
      json['isAllowedGuestCheckout'] as bool?,
      json['canGuestCheckoutDownloadable'] as bool?,
      json['arType'] as String?,
      json['arUrl'] as String?,
      (json['reviewCount'] as num?)?.toInt(),
      json['isThresholdVisible'] as bool?,
      (json['thresholdQtyLeft'] as num?)?.toInt(),
      (json['ratingsArray'] as List<dynamic>?)
          ?.map((e) => RatingArray.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['customOptions'] as List<dynamic>?)
          ?.map((e) => ProductCustomOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['ratingFormData'] as List<dynamic>?)
          ?.map((e) => RatingFormData.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?
      ..sku = json['sku'] as String?;

Map<String, dynamic> _$ProductDetailPageModelToJson(
        ProductDetailPageModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
      'id': instance.id,
      'sku': instance.sku,
      'productUrl': instance.productUrl,
      'name': instance.name,
      'formattedMinPrice': instance.formattedMinPrice,
      'minPrice': instance.minPrice,
      'formattedMaxPrice': instance.formattedMaxPrice,
      'maxPrice': instance.maxPrice,
      'formattedPrice': instance.formattedPrice,
      'price': instance.price,
      'formattedFinalPrice': instance.formattedFinalPrice,
      'finalPrice': instance.finalPrice,
      'groupedPrice': instance.groupedPrice,
      'rating': instance.rating,
      'thumbNail': instance.thumbNail,
      'typeId': instance.typeId,
      'is_new': instance.isNew,
      'msrpEnabled': instance.msrpEnabled,
      'msrpDisplayActualPriceType': instance.msrpDisplayActualPriceType,
      'msrp': instance.msrp,
      'formattedMsrp': instance.formattedMsrp,
      'shortDescription': instance.shortDescription,
      'description': instance.description,
      'isInRange': instance.isInRange,
      'guestCanReview': instance.guestCanReview,
      'availability': instance.availability,
      'isAvailable': instance.isAvailable,
      'priceFormat': instance.priceFormat,
      'imageGallery': instance.imageGallery,
      'additionalInformation': instance.additionalInformation,
      'reviewList': instance.reviewList,
      'priceView': instance.priceView,
      'tierPrices': instance.tierPrices,
      'relatedProductList': instance.relatedProductList,
      'groupedData': instance.groupedData,
      'links': instance.links,
      'samples': instance.samples,
      'bundleOptions': instance.bundleOptions,
      'configurableData': instance.configurableData,
      'isInWishlist': instance.isInWishlist,
      'wishlistItemId': instance.wishlistItemId,
      'upsellProductList': instance.upsellProductList,
      'showPriceDropAlert': instance.showPriceDropAlert,
      'showBackInStockAlert': instance.showBackInStockAlert,
      'isCheckoutAllowed': instance.isCheckoutAllowed,
      'isAllowedGuestCheckout': instance.isAllowedGuestCheckout,
      'canGuestCheckoutDownloadable': instance.canGuestCheckoutDownloadable,
      'arType': instance.arType,
      'arUrl': instance.arUrl,
      'reviewCount': instance.reviewCount,
      'isThresholdVisible': instance.isThresholdVisible,
      'thresholdQtyLeft': instance.thresholdQtyLeft,
      'ratingsArray': instance.ratingsArray,
      'customOptions': instance.customOptions,
      'ratingFormData': instance.ratingFormData,
    };

RatingFormData _$RatingFormDataFromJson(Map<String, dynamic> json) =>
    RatingFormData(
      json['id'] as String?,
      json['name'] as String?,
      (json['values'] as List<dynamic>?)?.map((e) => e as String).toList(),
    )..selectedRating = (json['selectedRating'] as num?)?.toDouble();

Map<String, dynamic> _$RatingFormDataToJson(RatingFormData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'values': instance.values,
      'selectedRating': instance.selectedRating,
    };
