/*
 *


 *
 * /
 */

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:test_new/unvells/models/productDetail/product_detail_page_model.dart';

import '../../../models/base_model.dart';
import '../../../models/cart/add_gift_to_cart_response.dart';
import '../../../models/homePage/add_to_wishlist_response.dart';
import '../../../models/productDetail/add_to_cart_response.dart';
import '../../../models/productDetail/product_new_model.dart';
import '../../../network_manager/api_client.dart';

abstract class ProductDetailScreenRepository {
  Future<ProductDetailPageModel> getProductDetailPageData(String productId);

  Future<ProductsNewModel?> getProductDetailTryOnData(String sku);

  Future<ProductDetailPageModel> getProductConfigurableData(String productId);

  Future<ProductDetailPageModel> getProductUpdatedData(String productId);

  Future<AddToWishlistResponse?> addToWishList(String productId);

  Future<BaseModel?> removeFromWishList(String productId);

  Future<BaseModel?> addToCompare(String productId);

  Future<AddToCartResponse?> addToCart(String productId, int qty,
      Map<String, dynamic> productParamsJSON, List<dynamic> relatedProducts);

  Future<AddGiftToCartResponse?> addGiftToCart(
      {required Map<String, dynamic> productParamsJSON, required String sku});
}

class ProductDetailScreenRepositoryImp extends ProductDetailScreenRepository {
  @override
  Future<ProductDetailPageModel> getProductDetailPageData(
      String productId) async {
    ProductDetailPageModel? responseData;
    try {
      responseData = await ApiClient().productPageData(productId);
    } catch (error, stacktrace) {
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
    return responseData!;
  }

  @override
  Future<ProductsNewModel?> getProductDetailTryOnData(String sku) async {
    ProductsNewModel? responseData;
    try {
      responseData = await ApiClient().productPageDataForNew(sku);
    } catch (error, stacktrace) {
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
    return responseData!;
  }

  /// ****AddToWishList**/
  @override
  Future<AddToWishlistResponse?> addToWishList(String productId) async {
    var wishlistAllAllCartData = await ApiClient().addToWishlist(productId);
    return wishlistAllAllCartData!;
  }

  /// ****RemoveFromWishList**/
  @override
  Future<BaseModel?> removeFromWishList(String productId) async {
    var responseData = await ApiClient().removeFromWishlist(productId);
    return responseData!;
  }

  /// ****AddToCompare**/
  @override
  Future<BaseModel?> addToCompare(String productId) async {
    var responseModel = await ApiClient().addToCompare(productId);
    return responseModel!;
  }

  /// ****Add to Cart**/
  @override
  Future<AddToCartResponse?> addToCart(
      String productId,
      int qty,
      Map<String, dynamic> productParamsJSON,
      List<dynamic> relatedProducts) async {
    var responseData = await ApiClient()
        .addToCart(productId, qty, productParamsJSON, relatedProducts);
    return responseData!;
  }

  /// ****Add Gift to Cart**/
  @override
  Future<AddGiftToCartResponse?> addGiftToCart(
      {required Map<String, dynamic> productParamsJSON,
      required String sku}) async {
    var responseData = await ApiClient().addGiftToCart(
      sku: sku,
      productParamsJSON: productParamsJSON,
    );
    return responseData!;
  }

  @override
  Future<ProductDetailPageModel> getProductConfigurableData(
      String productId) async {
    ProductDetailPageModel? responseData;
    try {
      responseData = await ApiClient().productConfigurableData(productId);
    } catch (error, stacktrace) {
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
    return responseData!;
  }

  @override
  Future<ProductDetailPageModel> getProductUpdatedData(String productId) async {
    ProductDetailPageModel? responseData;
    try {
      responseData = await ApiClient().getProductUpdatedData(productId);
    } catch (error, stacktrace) {
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
    return responseData!;
  }
}
