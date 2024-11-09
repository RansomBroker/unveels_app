/*
 *
  

 *
 * /
 */

import 'package:equatable/equatable.dart';
import 'package:test_new/unvells/models/wishlist/wishlist_model.dart';

import '../../../models/wishlist/request/wishlist_product_request.dart';

abstract class WishlistScreenEvents extends Equatable{
  const WishlistScreenEvents();

  @override
  List<Object> get props => [];
}

class WishlistDataFetchEvent extends WishlistScreenEvents{
  const WishlistDataFetchEvent(this.pagenumber);

  final int pagenumber;

  @override
  List<Object> get props => [pagenumber];

  // final WishlistData wishlistmodel;
  //
  // const WishlistDataFetchEvent(this.wishlistmodel);
  //
  // @override
  // List<Object?> get props => [wishlistmodel];
}

class MoveToCartEvent extends WishlistScreenEvents{

  const MoveToCartEvent(this.productId,this.quantity, this.itemId);
  final int productId;
  final int quantity;
  final int itemId;

  @override
  List<Object> get props => [productId,quantity,itemId];

}

class MoveAllToCartEvent extends WishlistScreenEvents{

  const MoveAllToCartEvent(this.itemData);
  final List<Map<String, String>> itemData;

  @override
  List<Object> get props => [itemData];

}

class RemoveItemEvent extends WishlistScreenEvents{
  final String productId;

  const RemoveItemEvent(this.productId);

  @override
  List<Object> get props => [];
}