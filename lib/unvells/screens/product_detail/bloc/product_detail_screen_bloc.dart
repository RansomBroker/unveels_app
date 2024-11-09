/*
 *


 *
 * /
 */

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';

import 'product_detail_screen_events.dart';
import 'product_detail_screen_repository.dart';
import 'product_detail_screen_state.dart';

class ProductDetailScreenBloc
    extends Bloc<ProductDetailScreenEvent, ProductDetailScreenState> {
  ProductDetailScreenRepository? repository;

  ProductDetailScreenBloc({this.repository})
      : super(ProductDetailScreenInitial()) {
    on<ProductDetailScreenEvent>(mapEventToState);
  }


  bool isLoading = false;
  void mapEventToState(ProductDetailScreenEvent event,
      Emitter<ProductDetailScreenState> emit) async {
    if (event is ProductDetailScreenDataFetchEvent) {
      emit(ProductDetailScreenInitial());
      try {
        var model = await repository?.getProductDetailPageData(event.productId);
        if (model != null) {
          if (model.success == true) {
            emit(ProductDetailScreenSuccess(model));
          } else {
            emit(ProductDetailScreenError(''));
          }
        } else {
          emit(ProductDetailScreenError(''));
        }
      } catch (error, stack) {
        print("ERROR$error");
        print(stack.toString());
        emit(ProductDetailScreenError(error.toString()));
      }
    }
    if (event is ProductConfigurableDataFetchEvent) {
      // emit(ProductDetailScreenInitial());
      try {
        var model =
            await repository?.getProductConfigurableData(event.productId);
        if (model != null) {
          if (model.success == true) {
            emit(ProductConfigurableDataSuccess(model));
          } else {
            emit(ProductDetailScreenError(''));
          }
        } else {
          emit(ProductDetailScreenError(''));
        }
      } catch (error, stack) {
        print("ERROR$error");
        print(stack.toString());
        emit(ProductDetailScreenError(error.toString()));
      }
    }
    if (event is ProductUpdatedDataFetchEvent) {
      // emit(ProductDetailScreenInitial());
      try {
        var model = await repository?.getProductUpdatedData(event.productId);
        if (model != null) {
          if (model.success == true) {
            emit(ProductUpdatedDataSuccess(model));
          } else {
            emit(ProductDetailScreenError(''));
          }
        } else {
          emit(ProductDetailScreenError(''));
        }
      } catch (error, stack) {
        print("ERROR$error");
        print(stack.toString());
        emit(ProductDetailScreenError(error.toString()));
      }
    } else if (event is AddToWishlistEvent) {
      try {
        emit(ProductDetailScreenInitial());
        var model = await repository?.addToWishList(event.productId ?? "");
        if (model != null) {
          if (model.success == true) {
            emit(
                AddProductToWishlistStateSuccess(model, event.productId ?? ''));
          } else {
            emit(ProductDetailScreenErrorAlert(''));
          }
        }
      } catch (error, _) {
        print(error.toString());
        emit(ProductDetailScreenErrorAlert(error.toString()));
      }
    } else if (event is RemoveFromWishlistEvent) {
      try {
        emit(ProductDetailScreenInitial());
        var model = await repository?.removeFromWishList(event.productId ?? "");
        if (model != null) {
          if (model.success == true) {
            emit(RemoveFromWishlistStateSuccess(model, event.productId ?? ''));
          } else {
            emit(ProductDetailScreenErrorAlert(''));
          }
        }
      } catch (error, _) {
        print(error.toString());
        emit(ProductDetailScreenErrorAlert(error.toString()));
      }
    } else if (event is QuantityUpdateEvent) {
      try {
        emit(QuantityUpdateState(event.qty!));
      } catch (error, _) {
        print(error.toString());
        emit(ProductDetailScreenErrorAlert(error.toString()));
      }
    } else if (event is AddtoCartEvent) {
      emit(ProductDetailScreenInitial());
      try {
        var model = await repository?.addToCart(event.productId, event.addQty,
            event.productParamsJSON, event.relatedProducts ?? []);
        if (model != null) {
          if (model.success == true) {
            emit(AddtoCartState(event.goToCheckout, model));
          } else {
            emit(ProductDetailScreenErrorAlert(model.message));
          }
        }
      } catch (error, _) {
        print(error.toString());
        emit(ProductDetailScreenErrorAlert(error.toString()));
      }
    } else if (event is AddGiftToCartEvent) {
      isLoading = true;
      emit(ProductDetailScreenInitial());

      try {
        var model = await repository?.addGiftToCart(
        productParamsJSON:   event.productParamsJSON,
          sku: event.sku
        );

        isLoading=false;
        if (model != null) {
          // debugPrint("asdasdasd${model..toString()}");

          if (model.success == true) {
            // debugPrint("asdasdasdads");
            log("message=>${model.cart?.total_quantity}");

            emit(AddGiftToCartState(model));
          } else {

            emit(ProductDetailScreenErrorAlert(model.message));
          }
        }
      } catch (error, _) {

        isLoading=false;

        print(error.toString());
        emit(ProductDetailScreenErrorAlert(error.toString()));
      }
    } else if (event is UpdatePriceEvent) {
      emit(ProductDetailScreenInitial());
      try {
        emit(UpdatePriceState());
      } catch (error, _) {
        print(error.toString());
        emit(ProductDetailScreenErrorAlert(error.toString()));
      }
    } else if (event is UpdateDownloadablePriceEvent) {
      emit(ProductDetailScreenInitial());
      try {
        emit(UpdateDownloadablePriceState());
      } catch (error, _) {
        print(error.toString());
        emit(ProductDetailScreenErrorAlert(error.toString()));
      }
    } else if (event is AddToCompareEvent) {
      emit(ProductDetailScreenInitial());
      try {
        var model = await repository?.addToCompare(event.productId ?? "");
        if (model != null) {
          if (model.success == true) {
            emit(AddProductToCompareStateSuccess(model, event.productId ?? ''));
          } else {
            emit(ProductDetailScreenErrorAlert(''));
          }
        }
      } catch (error, _) {
        print(error.toString());
        emit(ProductDetailScreenErrorAlert(error.toString()));
      }
    }
  }
}
