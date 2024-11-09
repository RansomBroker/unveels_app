/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/screens/wishlist/bloc/wishlist_screen_event.dart';
import 'package:test_new/unvells/screens/wishlist/bloc/wishlist_screen_repository.dart';
import 'package:test_new/unvells/screens/wishlist/bloc/wishlist_screen_state.dart';

class WishlistScreenBloc
    extends Bloc<WishlistScreenEvents, WishlistScreenState> {
  WishlistScreenRepository? repository;
  static const String Tag = "WishlistScreenBloc:- ";

  WishlistScreenBloc({this.repository}) : super(WishlistInitialState()) {
    on<WishlistScreenEvents>(mapEventToState);
  }

  static WishlistScreenBloc of(BuildContext context) {
    return BlocProvider.of<WishlistScreenBloc>(context);
  }



  bool isLoadingAction = false;


  @override
  void mapEventToState(
      WishlistScreenEvents event, Emitter<WishlistScreenState> emit) async {
    if (event is WishlistDataFetchEvent) {
      // emit(WishlistInitialState());
      try {
        var model = await repository?.getWishlistData(event.pagenumber);
        if (model != null) {
          print(Tag + " success ");
          emit(WishlistScreenSuccess(model));
        } else {
          print(Tag + " api wishlist api Fail");
          emit(WishlistScreenError(''));
        }
      } catch (error, _) {
        print(Tag + " Exception " + error.toString());
        emit(WishlistScreenError(error.toString()));
      }
    } else if (event is MoveToCartEvent) {
      try {
         isLoadingAction = true;

        var model = await repository?.moveCartWishlist(
            event.productId ?? 0, event.quantity ?? 0, event.itemId ?? 0);
          isLoadingAction = false;

         if (model != null) {
          if (model.success ?? false) {
            emit(MoveToCartSuccess(model));
          } else {
            emit(WishlistScreenError(model?.message));
          }
        } else {
          emit(WishlistScreenError(model?.message));
        }
      } catch (error, _) {
        print(error.toString());
        emit(WishlistScreenError(error.toString()));
      }

    } else if (event is MoveAllToCartEvent) {
      try {
        var model = await repository?.addAllCartWishlist(event.itemData ?? []);
        if (model != null) {
          if (model.success ?? false) {
            emit(MoveAllToCartSuccess(model));
          } else {
            emit(WishlistScreenError(model?.message));
          }
        } else {
          emit(WishlistScreenError(model?.message));
        }
      } catch (error, _) {
        print(error.toString());
        emit(WishlistScreenError(error.toString()));
      }
    } else if (event is RemoveItemEvent) {
      try {
         isLoadingAction = true;

        var model = await repository?.removeCartFromWishlist(event.productId);

        isLoadingAction = false;
        if (model != null) {
          emit(RemoveItemSuccess(model));
        } else {
          emit(WishlistScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(WishlistScreenError(error.toString()));
      }
    }
  }
}
