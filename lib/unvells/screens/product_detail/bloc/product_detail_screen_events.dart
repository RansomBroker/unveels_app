/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';

abstract class ProductDetailScreenEvent extends Equatable {
  const ProductDetailScreenEvent();

  @override
  List<Object> get props => [];
}

class ProductDetailScreenDataFetchEvent extends ProductDetailScreenEvent {
  final String productId;

  const ProductDetailScreenDataFetchEvent(this.productId);

  @override
  List<Object> get props => [];
}

//add to wishlist
class AddToWishlistEvent extends ProductDetailScreenEvent {
  String? productId;

  AddToWishlistEvent(this.productId);
}

//remove from wishlist
class RemoveFromWishlistEvent extends ProductDetailScreenEvent {
  String? productId;

  RemoveFromWishlistEvent(this.productId);
}

//add to compare
class AddToCompareEvent extends ProductDetailScreenEvent {
  String? productId;

  AddToCompareEvent(this.productId);
}

//Qty update
class QuantityUpdateEvent extends ProductDetailScreenEvent {
  int? qty;

  QuantityUpdateEvent(this.qty);
}

class AddtoCartEvent extends ProductDetailScreenEvent {
  bool goToCheckout;
  String productId;
  int addQty;
  Map<String, dynamic> productParamsJSON;
  List<dynamic>? relatedProducts;

  AddtoCartEvent(this.goToCheckout, this.productId, this.addQty,
      this.productParamsJSON, this.relatedProducts);
}

class AddGiftToCartEvent extends ProductDetailScreenEvent {
  final Map<String, dynamic> productParamsJSON;
  final String sku;

  const AddGiftToCartEvent({
    required this.productParamsJSON,
    required this.sku,
  });
}

//Update price
class UpdatePriceEvent extends ProductDetailScreenEvent {
  const UpdatePriceEvent();
}

//Update price
class UpdateDownloadablePriceEvent extends ProductDetailScreenEvent {
  const UpdateDownloadablePriceEvent();
}

class ProductConfigurableDataFetchEvent extends ProductDetailScreenEvent {
  final String productId;

  const ProductConfigurableDataFetchEvent(this.productId);

  @override
  List<Object> get props => [];
}

class ProductUpdatedDataFetchEvent extends ProductDetailScreenEvent {
  final String productId;

  const ProductUpdatedDataFetchEvent(this.productId);

  @override
  List<Object> get props => [];
}
