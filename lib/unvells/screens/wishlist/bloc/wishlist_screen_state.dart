

/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';
import 'package:test_new/unvells/models/wishlist/wishlist_addallcart_response_model.dart';
import 'package:test_new/unvells/models/wishlist/wishlist_model.dart';
import 'package:test_new/unvells/models/wishlist/wishlist_movecart_response_model.dart';

import '../../../models/base_model.dart';

abstract class WishlistScreenState  {
  const WishlistScreenState();

  @override
  List<Object?> get props => [];
}

class WishlistInitialState extends WishlistScreenState{

}

class WishlistFetchState extends WishlistScreenState {
  final WishlistModel wishlistmodel;

  WishlistFetchState(this.wishlistmodel);

  @override
  List<Object?> get props => [wishlistmodel];
}


class WishlistScreenSuccess extends WishlistScreenState{
  final WishlistModel wishlistModel;
  WishlistScreenSuccess(this.wishlistModel);

  @override
  List<Object?> get props => [];
}

class MoveToCartSuccess extends WishlistScreenState{

  WishlistMovecartResponseModel wishlistMovecartResponseModel;
  MoveToCartSuccess(this.wishlistMovecartResponseModel);

  @override
  List<Object> get props => [];
}

class MoveAllToCartSuccess extends WishlistScreenState{

  WishlistAddallcartResponseModel wishlistAddallcartResponseModel;
  MoveAllToCartSuccess(this.wishlistAddallcartResponseModel);

  @override
  List<Object> get props => [];
}

class WishlistActionState extends WishlistScreenState{

}

class RemoveItemSuccess extends WishlistScreenState{
  BaseModel? baseModel;

  RemoveItemSuccess(this.baseModel);

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class WishlistScreenError extends WishlistScreenState {
  WishlistScreenError(this._message);

  String? _message;

  // ignore: unnecessary_getters_setters
  String? get message => _message;

  // ignore: unnecessary_getters_setters
  set message(String? message) {
    _message = message;
  }

  @override
  List<Object> get props => [];
}

class CompleteState extends WishlistScreenState{}
