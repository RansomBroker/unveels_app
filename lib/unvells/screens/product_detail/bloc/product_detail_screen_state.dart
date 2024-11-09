
/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';
import 'package:test_new/unvells/models/cart/add_gift_to_cart_response.dart';
import 'package:test_new/unvells/models/productDetail/product_detail_page_model.dart';

import '../../../models/base_model.dart';
import '../../../models/homePage/add_to_wishlist_response.dart';
import '../../../models/productDetail/add_to_cart_response.dart';


abstract class ProductDetailScreenState extends Equatable {
  const ProductDetailScreenState();

  @override
  List<Object> get props => [];
}

class ProductDetailScreenInitial extends ProductDetailScreenState {}

class ProductDetailScreenSuccess extends ProductDetailScreenState {
  ProductDetailPageModel productDetailPageData;

  ProductDetailScreenSuccess(this.productDetailPageData);
  @override
  List<Object> get props => [];
}

class ProductDetailScreenError extends ProductDetailScreenState {
  const ProductDetailScreenError(this.message);
 final String? message;

  @override
  List<Object> get props => [];
}

class ProductDetailScreenErrorAlert extends ProductDetailScreenState {
  ProductDetailScreenErrorAlert(this.message);
  String? message;

  @override
  List<Object> get props => [];
}

class AddProductToWishlistStateSuccess extends ProductDetailScreenState {
  final AddToWishlistResponse wishListModel;
  final String productId;

  const AddProductToWishlistStateSuccess(this.wishListModel,this.productId);

  @override
  List<Object> get props => [];
}

class RemoveFromWishlistStateSuccess extends ProductDetailScreenState {
  final BaseModel baseModel;
  final String productId;

  const RemoveFromWishlistStateSuccess(this.baseModel,this.productId);

  @override
  List<Object> get props => [];
}

class AddProductToCompareStateSuccess extends ProductDetailScreenState {
  final BaseModel responseModel;
  final String productId;

  const AddProductToCompareStateSuccess(this.responseModel,this.productId);

  @override
  List<Object> get props => [];
}

class QuantityUpdateState extends ProductDetailScreenState {
  QuantityUpdateState(this.qty);

  int qty = 1;

  @override
  List<Object> get props => [];
}

class AddtoCartState extends ProductDetailScreenState{
  bool goToCheckout;
  AddToCartResponse? model;
  AddtoCartState(this.goToCheckout, this.model);

  @override
  List<Object> get props => [];
}
class AddGiftToCartState extends ProductDetailScreenState{
  AddGiftToCartResponse? model;
  AddGiftToCartState(this.model);

  @override
  List<Object> get props => [];
}

class UpdatePriceState extends ProductDetailScreenState{
  UpdatePriceState();

  @override
  List<Object> get props => [];
}

class UpdateDownloadablePriceState extends ProductDetailScreenState{
  UpdateDownloadablePriceState();

  @override
  List<Object> get props => [];
}

class ProductDetailEmptyState extends ProductDetailScreenState{

}

class ProductConfigurableDataSuccess extends ProductDetailScreenState {
  ProductDetailPageModel productDetailPageData;

  ProductConfigurableDataSuccess(this.productDetailPageData);
  @override
  List<Object> get props => [];
}

class ProductUpdatedDataSuccess extends ProductDetailScreenState {
  ProductDetailPageModel productDetailPageData;

  ProductUpdatedDataSuccess(this.productDetailPageData);
  @override
  List<Object> get props => [];
}
