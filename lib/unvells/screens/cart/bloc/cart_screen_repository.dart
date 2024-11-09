/*
 *
  

 *
 * /
 */

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:test_new/unvells/models/cart/cart_details_model.dart';
import 'package:test_new/unvells/screens/cart/bloc/cart_screen_state.dart';

import '../../../models/base_model.dart';
import '../../../network_manager/api_client.dart';



abstract class CartScreenRepository{
  Future<CartDetailsModel> getCartData();
  Future<BaseModel> removeCartItem(String lineId);
  Future<BaseModel> cartToWishlist(String itemId, String productId, String qty);
  Future<BaseModel> setCartEmpty();
  Future<BaseModel> setCartItemQty(List<Map<String, String>> itemIds);
  Future<BaseModel> applyCoupon(String couponCode, int remove);
}

class CartScreenRepositoryImp extends CartScreenRepository{
  @override
  Future<CartDetailsModel> getCartData() async{

    CartDetailsModel? responseData;
    try{
      responseData = await ApiClient().getCartDetails();
    }
    catch(error,stacktrace){
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }

    return responseData!;
  }

  @override
  Future<BaseModel> removeCartItem(String lineId) async{

    BaseModel? responseData;
    try{
      responseData = await ApiClient().removeCartItem(lineId);
    }
    catch(error,stacktrace){
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }

    return responseData!;
  }

  @override
  Future<BaseModel> cartToWishlist(String itemId, String productId, String qty) async{
    BaseModel? responseData;
    try{
      responseData = await ApiClient().wishlistFromCart(itemId, productId, qty);
    }
    catch(error,stacktrace){
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }

    return responseData!;
  }

  @override
  Future<BaseModel> setCartEmpty() async{
    BaseModel? responseData;
    try{
      responseData = await ApiClient().emptyCart();
    }
    catch(error,stacktrace){
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }

    return responseData!;
  }

  @override
  Future<BaseModel> setCartItemQty(List<Map<String, String>> itemIds) async{
    BaseModel? responseData;
    try{
      responseData = await ApiClient().updateCart(itemIds);
    }
    catch(error,stacktrace){
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }

    return responseData!;
  }

  @override
  Future<BaseModel> applyCoupon(String couponCode, int remove) async{
    BaseModel? responseData;
    try{
      responseData = await ApiClient().applyCoupon(couponCode, remove);
    }
    catch(error,stacktrace){
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }

    return responseData!;
  }

}