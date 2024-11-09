/*
 *
  

 *
 * /
 */

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/screens/compare_products/bloc/compare_product_events.dart';
import 'package:test_new/unvells/screens/compare_products/bloc/compare_product_repository.dart';
import 'package:test_new/unvells/screens/compare_products/bloc/compare_product_state.dart';

class CompareProductBloc extends Bloc<CompareProductEvent, CompareProductState> {
  CompareProductRepository? repository ;

  CompareProductBloc({this.repository}) : super(CompareProductInitial()) {
    on<CompareProductEvent>(mapEventToState);
  }

  void mapEventToState(CompareProductEvent event,
      Emitter<CompareProductState> emit) async {
    if(event is CompareProductDataFetchEvent){
      try {
        var model = await repository?.getCompareProductDetails();
        if (model != null) {
          if (model.success??false) {
            emit(CompareProductSuccess(model));
          } else {
            emit(CompareProductError(''));
          }
        } else {
          emit(CompareProductError(''));
        }
      } catch (error, str) {
        print(str.toString());
        emit(CompareProductError(error.toString()));
      }
    } else if (event is AddToWishlistEvent) {
      emit(CompareProductInitial());
      try {
        var model = await repository?.addToWishList(event.productId ?? "");
        if (model != null) {
          emit(AddProductToWishlistStateSuccess(model, event.productId ?? '', event.index??0));
        }
      } catch (error, _) {
        print(error.toString());
        emit(CompareProductError(error.toString()));
      }
    } else if (event is RemoveFromWishlistEvent) {
      emit(CompareProductInitial());
      try {
        var model = await repository?.removeFromWishList(event.productId ?? "");
        if (model != null) {
          emit(RemoveFromWishlistStateSuccess(model, event.productId ?? '', event.index??0));
        }
      } catch (error, _) {
        print(error.toString());
        emit(CompareProductError(error.toString()));
      }
    }   else if (event is RemoveFromCompareEvent) {
      emit(CompareProductInitial());
      try {
        var model = await repository?.removeFromCompare(event.productId ?? "");
        if (model != null) {
          emit(RemoveFromCompareStateSuccess(model, event.productId ?? '', event.index??0));
        }
      } catch (error, _) {
        print(error.toString());
        emit(CompareProductError(error.toString()));
      }
    } else if(event is AddtoCartEvent){
      emit(CompareProductInitial());
      try {
        var model = await repository?.addToCart(event.productId, event.addQty, event.productParamsJSON);
        if (model != null) {
          if (model.success == true) {
            emit(AddtoCartState(event.goToCheckout, model));
          } else {
            emit(AddToCartError(model.message??""));
          }
        }
      } catch (error, _) {
        print(error.toString());
        emit(AddToCartError(error.toString()));
      }
    }
  }
}