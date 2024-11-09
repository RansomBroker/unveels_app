/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';
import 'package:test_new/unvells/models/base_model.dart';

import '../../../../models/homePage/add_to_wishlist_response.dart';
import '../../../../models/productDetail/add_to_cart_response.dart';

abstract class ItemCardState extends Equatable {
  const ItemCardState();

  @override
  List<Object> get props => [];
}

class ItemCardInitial extends ItemCardState {}

class AddProductToWishlistStateSuccess extends ItemCardState {
  final AddToWishlistResponse wishListModel;
  final String productId;

  const AddProductToWishlistStateSuccess(this.wishListModel,this.productId);

  @override
  List<Object> get props => [];
}

class RemoveFromWishlistStateSuccess extends ItemCardState {
  final BaseModel baseModel;
  final String productId;
  final bool fromWishlist;

  const RemoveFromWishlistStateSuccess(this.baseModel,this.productId, this.fromWishlist);

  @override
  List<Object> get props => [];
}

class WishlistIdleState extends ItemCardState{
}

//Error State
class ItemCardErrorState extends ItemCardState {
  ItemCardErrorState(this._message);

  String? _message;

  String? get message => _message;

  set message(String? message) {
    _message = message;
  }

  @override
  List<Object> get props => [];
}

class ItemCardEmptyState extends ItemCardState {}

class AddtoCartState extends ItemCardState{
 final AddToCartResponse? model;
  const AddtoCartState( this.model);

  @override
  List<Object> get props => [];
}
class AddToCartError extends ItemCardState {
  const AddToCartError(this.message);
  final String? message;

  @override
  List<Object> get props => [];
}