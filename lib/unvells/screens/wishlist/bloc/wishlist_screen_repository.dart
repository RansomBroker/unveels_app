/*
 *


 *
 * /
 */

import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:test_new/unvells/models/wishlist/wishlist_model.dart';
import 'package:test_new/unvells/models/wishlist/wishlist_movecart_response_model.dart';
import 'package:test_new/unvells/network_manager/api_client.dart';

import '../../../helper/app_storage_pref.dart';
import '../../../models/base_model.dart';
import '../../../models/wishlist/wishlist_addallcart_response_model.dart';


abstract class WishlistScreenRepository {
  Future<WishlistModel?> getWishlistData(int pagenumber);

  Future<WishlistMovecartResponseModel?> moveCartWishlist(int productId, int qty, int itemId);
  Future<WishlistAddallcartResponseModel>? addAllCartWishlist(List<Map<String, String>> itemData);
  Future<BaseModel>? removeCartFromWishlist(String itemId);
}


class WishlistScreenRepositoryImp extends WishlistScreenRepository{

  @override
  Future<WishlistModel?> getWishlistData(int pagenumber) async {

    WishlistModel? wishlistModelData;
    try{
      wishlistModelData = await ApiClient().getWishlist(pagenumber);
    }
    catch(error, stacktrace) {
      print("Error --> " + error.toString());
      print("Stacktrace --> " + stacktrace.toString());
    }
    return wishlistModelData!;

    /*final String response = await rootBundle.loadString('assets/responses/wishlist_data.json');
    Map<String, dynamic> userMap = jsonDecode(response);
    // try{
    var wishlistResponse = WishlistModel.fromJson(userMap);
    // }catch(error, strace){
    //   print("ISSUS$strace");
    // }

    // print("API DATA$response");
    return wishlistResponse;*/
  }


  @override
  Future<WishlistMovecartResponseModel?> moveCartWishlist(int productId, int qty, int itemId) async {
     // int itemId, int productId, int qty
     var wishlistMoveCartData = await ApiClient().moveToCart(itemId, productId,qty);
    return wishlistMoveCartData!;

  }


  @override
  Future<WishlistAddallcartResponseModel>? addAllCartWishlist(List<Map<String, String>> itemData) async {

     var wishlistAllAllCartData = await ApiClient().allToCart(itemData);
    return wishlistAllAllCartData!;

  }

  @override
  Future<BaseModel>? removeCartFromWishlist(String itemId) async {

     var removeCartWishlistData = await ApiClient().removeFromWishlist(itemId);
    return removeCartWishlistData!;

  }

}