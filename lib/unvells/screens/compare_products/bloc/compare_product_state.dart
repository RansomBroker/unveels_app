/*
 *
  

 *
 * /
 */

import 'package:equatable/equatable.dart';
import 'package:test_new/unvells/models/compare_products/compare_product_model.dart';

import '../../../models/base_model.dart';
import '../../../models/homePage/add_to_wishlist_response.dart';
import '../../../models/productDetail/add_to_cart_response.dart';

abstract class CompareProductState {
  const CompareProductState();

  @override
  List<Object> get props => [];

}

class CompareProductInitial extends CompareProductState{}

class CompareProductSuccess extends CompareProductState{
  final  CompareProductModel model;

  const CompareProductSuccess(this.model);
}

class CompareProductError extends CompareProductState{
  final String? message;
  const CompareProductError(this.message);
}

class AddProductToWishlistStateSuccess extends CompareProductState {
  final AddToWishlistResponse wishListModel;
  final String productId;
  final int index;

  const AddProductToWishlistStateSuccess(this.wishListModel,this.productId, this.index);

  @override
  List<Object> get props => [];
}

class RemoveFromWishlistStateSuccess extends CompareProductState {
  final BaseModel baseModel;
  final String productId;
  final int index;

  const RemoveFromWishlistStateSuccess(this.baseModel,this.productId, this.index);

  @override
  List<Object> get props => [];
}

class RemoveFromCompareStateSuccess extends CompareProductState {
  final BaseModel baseModel;
  final String productId;
  final int index;

  const RemoveFromCompareStateSuccess(this.baseModel,this.productId, this.index);

  @override
  List<Object> get props => [];
}

class WishlistIdleState extends CompareProductState{
}

class AddtoCartState extends CompareProductState{
  bool goToCheckout;
  AddToCartResponse? model;
  AddtoCartState(this.goToCheckout, this.model);

  @override
  List<Object> get props => [];
}

class ItemCardErrorState extends CompareProductState {
  ItemCardErrorState(this._message);

  String? _message;

  String? get message => _message;

  set message(String? message) {
    _message = message;
  }

  @override
  List<Object> get props => [];
}

class AddToCartError extends CompareProductState {
  AddToCartError(this.message);
  String? message;

  @override
  List<Object> get props => [];
}