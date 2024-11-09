/*
 *


 *
 * /
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/models/categoryPage/product_tile_data.dart';

import '../../../app_widgets/app_alert_message.dart';
import '../../../app_widgets/app_dialog_helper.dart';
import '../../../app_widgets/image_view.dart';
import '../../../configuration/unvells_theme.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/app_string_constant.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/app_localizations.dart';
import '../../../helper/app_storage_pref.dart';
import '../../../helper/utils.dart';
import 'item_card_bloc/item_card_bloc.dart';
import 'item_card_bloc/item_card_event.dart';
import 'item_card_bloc/item_card_state.dart';

class ProductItemFullWidth extends StatefulWidget {
  final ProductTileData? product;

  const ProductItemFullWidth({Key? key, this.product}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProductItemFullWidthState();
  }
}

class ProductItemFullWidthState extends State<ProductItemFullWidth> {
  bool isLoading = true;
  ItemCardBloc? itemCardBloc;

  @override
  Widget build(BuildContext ctx, {Function(String)? callback}) {
    itemCardBloc = ctx.read<ItemCardBloc>();
    return BlocBuilder<ItemCardBloc, ItemCardState>(
      builder: (context, currentState) {
        if (currentState is ItemCardInitial) {
          isLoading = true;
        } else if (currentState is ItemCardErrorState) {
          isLoading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showError(
                currentState.message ??
                    Utils.getStringValue(
                        context, AppStringConstant.somethingWentWrong),
                context);
          });
        } else if (currentState is AddProductToWishlistStateSuccess) {
          isLoading = false;
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
          isLoading = false;
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
          }
          itemCardBloc?.emit(ItemCardEmptyState());
        }
        return buildUi(ctx);
      },
    );
  }

  Widget buildUi(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.productPage,
          arguments: getProductDataAttributeMap(
            widget.product?.name ?? "",
            widget.product?.entityId.toString() ?? "",
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border.all(
              color: Theme.of(context).dividerColor,
            )),
        child: Stack(children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Stack(children: <Widget>[
                  ImageView(
                    url: widget.product?.thumbNail,
                    height: AppSizes.categoryImageSizeMedium,
                    width: AppSizes.categoryImageSizeMedium,
                    borderRadius: BorderRadius.circular(0),
                  ),
                  Positioned(
                    bottom: AppSizes.spacingTiny,
                    left: AppSizes.spacingGeneric,
                    child: (widget.product?.hasSpecialPrice() == true)
                        ? Container(
                            decoration: BoxDecoration(
                                color: AppColors.green,
                                //Colors.white12,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: Colors.white12,
                                  //AppColors.green,
                                )),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: AppSizes.size2,
                                  bottom: AppSizes.size2,
                                  left: AppSizes.linePadding,
                                  right: AppSizes.linePadding),
                              child: Text(
                                "-${widget.product?.getDiscountPercentage()}%",
                                style: TextStyle(color: AppColors.white),
                              ),
                            ),
                          )
                        : Container(),
                  ),
                  if (widget?.product?.isNew ?? true)
                    Positioned(
                        left: AppSizes.size20,
                        top: AppSizes.size14,
                        child: ColoredBox(
                            color: AppColors.red,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppSizes.spacingGeneric,
                                  vertical: AppSizes.spacingTiny),
                              child: Text(
                                  Utils.getStringValue(
                                      context, AppStringConstant.newTest),
                                  style: const TextStyle(
                                      color: AppColors.white,
                                      fontSize: AppSizes.spacingSmall)),
                            )))
                ]),
              ),
              const SizedBox(
                width: AppSizes.size15,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                            (widget.product?.formattedFinalPrice ?? '')
                                    .isNotEmpty
                                ? widget.product?.formattedFinalPrice ?? ''
                                : '',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(fontSize: AppSizes.textSizeMedium)),
                        Visibility(
                            visible:
                                (widget.product?.hasSpecialPrice() ?? false),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: AppSizes.linePadding,
                                ),
                                Text(widget.product?.formattedPrice ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            fontSize: AppSizes.textSizeMedium)),
                                if (widget.product?.hasSpecialPrice() == true)
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white12,
                                        border: Border.all(
                                          color: AppColors.green,
                                        )),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: AppSizes.spacingGeneric,
                                          bottom: AppSizes.spacingGeneric,
                                          left: AppSizes.spacingGeneric,
                                          right: AppSizes.spacingGeneric),
                                      child: Text(
                                        "${widget.product?.getDiscountPercentage()}${Utils.getStringValue(context, AppStringConstant.offPercentage)}",
                                        style:
                                            TextStyle(color: AppColors.green),
                                      ),
                                    ),
                                  )
                              ],
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 2.0,
                    ),
                    if (widget.product?.hasSpecialPrice() == true)
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(AppSizes.size4),
                            border: Border.all(
                              color: AppColors.green,
                            )),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: AppSizes.spacingGeneric,
                              bottom: AppSizes.spacingGeneric,
                              left: AppSizes.spacingGeneric,
                              right: AppSizes.spacingGeneric),
                          child: Text(
                            "${widget.product?.getDiscountPercentage()}${Utils.getStringValue(context, AppStringConstant.offPercentage)}",
                            style: TextStyle(color: AppColors.green),
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 2.0,
                    ),
                    Text(widget.product?.name ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontSize: AppSizes.textSizeSmall)
                        // const TextStyle(fontSize: 12.0, color: Colors.black),
                        ),
                    const SizedBox(
                      height: AppSizes.spacingGeneric,
                    ),
                    if (widget.product?.rating.toString() == "0")
                      Text(
                        Utils.getStringValue(
                            context, AppStringConstant.noReviewsYet),
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(fontSize: AppSizes.textSizeTiny),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    if (widget.product?.rating.toString() != "0")
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.spacingTiny,
                            vertical: AppSizes.spacingTiny),
                        decoration: BoxDecoration(
                            color: Utils.ratingBackground(
                                    widget.product?.rating.toString() ?? '') ??
                                Colors.pink,
                            borderRadius: BorderRadius.circular(3)),
                        child: SizedBox(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              const SizedBox(
                                width: AppSizes.size4,
                              ),
                              Text("${widget.product?.rating}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: AppSizes.textSizeSmall,
                                          color: AppColors.white)),
                              const SizedBox(
                                width: AppSizes.spacingTiny,
                              ),
                              const Icon(
                                Icons.star,
                                size: AppSizes.textSizeSmall,
                                color: AppColors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(
                width: AppSizes.size4,
              ),
            ],
          ),
          Positioned(
              right: AppSizes.spacingSmall,
              top: AppSizes.spacingGeneric,
              // bottom: AppSizes.size100,
              child: InkWell(
                onTap: () async {
                  if (await appStoragePref.isLoggedIn()) {
                    if (widget.product?.isInWishlist != true) {
                      itemCardBloc?.add(AddToWishlistEvent(
                          widget.product?.entityId.toString()));
                    } else {
                      AppDialogHelper.confirmationDialog(
                          Utils.getStringValue(
                              context, AppStringConstant.removeItemFromWishlist),
                          context,
                          AppLocalizations.of(context),
                          title: Utils.getStringValue(
                              context, AppStringConstant.removeItem),
                          onConfirm: () async {
                        itemCardBloc?.add(RemoveFromWishlistEvent(
                            widget.product?.wishlistItemId.toString()));
                      });
                    }
                  } else {
                    AppDialogHelper.confirmationDialog(
                        Utils.getStringValue(context,
                            AppStringConstant.loginRequiredToAddOnWishlist),
                        context,
                        AppLocalizations.of(context),
                        title: Utils.getStringValue(
                            context, AppStringConstant.loginRequired),
                        onConfirm: () async {
                      Navigator.of(context).pushNamed(AppRoutes.signInSignUp);
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(17)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Icon(
                    (widget.product?.isInWishlist ?? false)
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    color: (widget.product?.isInWishlist ?? false)
                        ? AppColors.lightRed
                        : AppColors.lightGray,
                    size: 18,
                  ),
                ),
              )),
        ]),
      ),
    );
  }
}
