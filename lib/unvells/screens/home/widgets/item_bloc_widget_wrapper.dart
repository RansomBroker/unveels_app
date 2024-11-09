import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_widgets/app_alert_message.dart';
import '../../../constants/app_string_constant.dart';
import '../../../helper/app_storage_pref.dart';
import '../../../helper/utils.dart';
import '../../../models/categoryPage/product_tile_data.dart';
import 'item_card_bloc/item_card_bloc.dart';
import 'item_card_bloc/item_card_state.dart';

class ItemBlocWidgetWrapper extends StatefulWidget {
   ItemBlocWidgetWrapper({super.key, required this.isLoading, required this.child, required this.product});
   bool? isLoading;
   final Widget child;
   final ProductTileData product;

  @override
  State<ItemBlocWidgetWrapper> createState() => _ItemBlocWidgetWrapperState();
}

class _ItemBlocWidgetWrapperState extends State<ItemBlocWidgetWrapper> {
   ItemCardBloc? itemCardBloc;

   @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemCardBloc, ItemCardState>(
      builder: (context, currentState) {
        if (currentState is ItemCardInitial) {
          widget.isLoading = true;
        } else if (currentState is ItemCardErrorState) {
          widget.isLoading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showError(
                currentState.message ??
                    Utils.getStringValue(
                        context, AppStringConstant.somethingWentWrong),
                context);
          });
        }else if (currentState is AddtoCartState) {
          widget.isLoading = false;
          if(currentState.model?.success==true){
            if ((currentState.model?.quoteId??0) != 0) {
              appStoragePref.setQuoteId(currentState.model?.quoteId);
            }
            appStoragePref.setCartCount(currentState.model?.cartCount);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AlertMessage.showSuccess(
                  currentState.model?.message ?? "", context);
            });
          }

        } else if (currentState is AddProductToWishlistStateSuccess) {

          widget.isLoading = false;
          if (currentState.wishListModel.success == true) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {

              AlertMessage.showSuccess(
                  currentState.wishListModel.message ?? '', context);
              itemCardBloc?.emit(WishlistIdleState());
            });
            if (widget.product?.entityId.toString() == currentState.productId) {
              widget.product?.isInWishlist = true;
              widget.product?.wishlistItemId =
                  currentState.wishListModel.itemId;
            }
          } else {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(
                  currentState.wishListModel.message ?? '', context);
            });
          }
          itemCardBloc?.emit(ItemCardEmptyState());
        } else if (currentState is RemoveFromWishlistStateSuccess) {
          widget.isLoading = false;
          if (currentState.baseModel.success == true) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showSuccess(
                  currentState.baseModel.message ?? '', context);
              itemCardBloc?.emit(WishlistIdleState());
            });
            if (widget.product?.wishlistItemId.toString() ==
                currentState.productId.toString()) {
              widget.product?.isInWishlist = false;
            }
          } else {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(
                  currentState.baseModel.message ??
                      Utils.getStringValue(
                          context, AppStringConstant.somethingWentWrong),
                  context);
            });
            itemCardBloc?.emit(ItemCardEmptyState());
          }
        }
        return widget.child;
      },
    );
  }
}
