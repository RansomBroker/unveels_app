/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';

abstract class CompareProductEvent extends Equatable{
  const CompareProductEvent();

  @override
  List<Object> get props => [];
}

class CompareProductDataFetchEvent extends CompareProductEvent {
  const CompareProductDataFetchEvent();

  @override
  List<Object> get props => [];
}


//add to wishlist
class AddToWishlistEvent extends CompareProductEvent{
  String? productId;
  int? index;
  AddToWishlistEvent(this.productId, this.index);

}

//remove from wishlist
class RemoveFromWishlistEvent extends CompareProductEvent{
  String? productId;
  int? index;
  RemoveFromWishlistEvent(this.productId, this.index);

}

//remove from wishlist
class RemoveFromCompareEvent extends CompareProductEvent{
  String? productId;
  int? index;
  RemoveFromCompareEvent(this.productId, this.index);

}

class AddtoCartEvent extends CompareProductEvent{
  bool goToCheckout;
  String productId;
  int addQty;
  Map<String, dynamic> productParamsJSON;

  AddtoCartEvent(this.goToCheckout, this.productId,this.addQty, this.productParamsJSON);
}