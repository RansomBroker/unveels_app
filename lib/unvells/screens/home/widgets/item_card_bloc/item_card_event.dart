

/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';

abstract class ItemCardEvent extends Equatable {
  @override
  List<Object> get props => [];
}


//add to wishlist
class AddToWishlistEvent extends ItemCardEvent{
 final String? productId;
  AddToWishlistEvent(this.productId);

}

//remove from wishlist
class RemoveFromWishlistEvent extends ItemCardEvent{
 final String? productId;
   bool? fromWishlist=false;

  RemoveFromWishlistEvent(this.productId, {this.fromWishlist});

}
class AddtoCartEvent extends ItemCardEvent{
  String productId;
  int addQty;
  Map<String, dynamic> productParamsJSON;

  AddtoCartEvent( this.productId,this.addQty, this.productParamsJSON);
}