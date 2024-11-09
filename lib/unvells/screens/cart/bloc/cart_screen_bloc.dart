/*
 *


 *
 * /
 */

import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_screen_event.dart';
import 'cart_screen_repository.dart';
import 'cart_screen_state.dart';

class CartScreenBloc extends Bloc<CartScreenEvent, CartScreenState>{
  CartScreenRepository? repository;
  CartScreenBloc({this.repository}) : super(CartScreenInitial()){
    on<CartScreenEvent>(mapEventToState);
  }

  void mapEventToState(
      CartScreenEvent event, Emitter<CartScreenState> emit) async {
    switch(event.runtimeType){
      case CartScreenDataFetchEvent:
        try {
          emit( CartScreenInitial());
          var model = await repository?.getCartData();
          if (model != null) {
            emit( CartScreenSuccess(model));
          } else {
            emit(CartScreenError(''));
          }
        } catch (error, str) {
          print(str.toString());
          emit(CartScreenError(error.toString()));
        }
        break;

      case RemoveCartItem:
        try {
          var model = await repository?.removeCartItem((event as RemoveCartItem).lineId);
          if (model != null) {
            emit( RemoveCartItemSuccess(model));
          } else {
            emit(CartScreenError(''));
          }
        } catch (error, _) {
          print(error.toString());
          emit(CartScreenError(error.toString()));
        }
        break;
      case CartToWishlistEvent:
        try {
          var model = await repository?.cartToWishlist((event as CartToWishlistEvent).itemId, (event).productId, (event).qty );
          if (model != null) {
            emit( CartToWishlistState(model));
          } else {
            emit(CartScreenError(''));
          }
        } catch (error, _) {
          print(error.toString());
          emit(CartScreenError(error.toString()));
        }
        break;
      case SetCartEmpty:
        try {
          var model = await repository?.setCartEmpty();
          if (model != null) {
            emit( SetCartEmptyState(model));
          } else {
            emit(CartScreenError(''));
          }
        } catch (error, _) {
          print(error.toString());
          emit(CartScreenError(error.toString()));
        }
        break;
      case SetCartItemQuantityEvent:
        try {
          List<Map<String, String>> itemData = [];
          Map<String, String> item = {};
          item["id"] = (event as SetCartItemQuantityEvent).lineId;
          item["qty"] = event.qty.toString();
          itemData.add(item);

          var model = await repository?.setCartItemQty(itemData);
          if (model != null) {
            emit( SetCartItemQtyState(model));
          } else {
            emit(CartScreenError(''));
          }
        } catch (error, _) {
          print(error.toString());
          emit(CartScreenError(error.toString()));
        }
        break;
      case ApplyCouponEvent:
        try {
          emit(CartScreenInitial());
          var model = await repository?.applyCoupon((event as ApplyCouponEvent).couponCode, event.remove);
          if (model != null) {
            if (model?.success??false) {
              emit( ApplyCouponState(model));
            } else {
              emit(CartScreenError(model?.message??''));
            }
          } else {
            emit(CartScreenError(''));
          }
        } catch (error, _) {
          print(error.toString());
          emit(CartScreenError(error.toString()));
        }
        break;
    }

  }

}