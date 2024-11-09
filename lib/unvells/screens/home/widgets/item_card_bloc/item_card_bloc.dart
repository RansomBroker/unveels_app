/*
 *


 *
 * /
 */

import 'package:bloc/bloc.dart';

import 'item_card_event.dart';
import 'item_card_repository.dart';
import 'item_card_state.dart';

class ItemCardBloc extends Bloc<ItemCardEvent, ItemCardState> {
  ItemCardRepository? repository;

  ItemCardBloc({this.repository}) : super(ItemCardInitial()) {
    on<ItemCardEvent>(mapEventToState);
  }

  bool isLoadingAction = false;

  void mapEventToState(ItemCardEvent event, Emitter<ItemCardState> emit) async {
    emit(ItemCardInitial());
    //AddToWishList
    if (event is AddToWishlistEvent) {
      try {
        isLoadingAction = true;

        var model = await repository?.addToWishList(event.productId ?? "");
        isLoadingAction = false;

        if (model != null) {
          emit(AddProductToWishlistStateSuccess(model, event.productId ?? ''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(ItemCardErrorState(error.toString()));
      }
    } else if (event is AddtoCartEvent) {
      emit(ItemCardInitial());
      try {
        isLoadingAction = true;

        var model = await repository?.addToCart(
            event.productId, event.addQty, event.productParamsJSON);
        isLoadingAction = false;

        if (model != null) {
          if (model.success == true) {
            emit(AddtoCartState(model));
          } else {
            emit(AddToCartError(model.message ?? ""));
          }
        }
      } catch (error, _) {
        print(error.toString());
        emit(AddToCartError(error.toString()));
      }
    } else if (event is RemoveFromWishlistEvent) {
      try {
        isLoadingAction = true;

        var model = await repository?.removeFromWishList(event.productId ?? "");
        isLoadingAction = false;

        if (model != null) {
          emit(RemoveFromWishlistStateSuccess(
              model, event.productId ?? '', event.fromWishlist ?? false));
        }
      } catch (error, _) {
        print(error.toString());
        emit(ItemCardErrorState(error.toString()));
      }
    }
  }
}
