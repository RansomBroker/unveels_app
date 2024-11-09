/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/utils.dart';

import '../../../app_widgets/app_alert_message.dart';
import '../../../app_widgets/app_dialog_helper.dart';
import '../../../app_widgets/image_view.dart';
import '../../../configuration/unvells_theme.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/app_localizations.dart';
import '../../../helper/app_storage_pref.dart';
import '../../../models/categoryPage/product_tile_data.dart';
import '../../home/widgets/item_card_bloc/item_card_bloc.dart';
import '../../home/widgets/item_card_bloc/item_card_event.dart';
import '../../home/widgets/item_card_bloc/item_card_state.dart';

class ItemCatalogProductList extends StatefulWidget {
  double? imageSize;
  Function? callBack;
  bool isSelected = false;

  final ProductTileData? product;

  ItemCatalogProductList(
      {this.product, this.imageSize, this.callBack, this.isSelected = false});

  @override
  State<ItemCatalogProductList> createState() => _ItemCatalogProductListState();
}

class _ItemCatalogProductListState extends State<ItemCatalogProductList> {
  bool isLoading = true;
  ItemCardBloc? itemCardBloc;

  @override
  Widget build(BuildContext ctx, {Function(String)? callback}) {
    widget.imageSize ??= (AppSizes.deviceWidth / 2.5) - AppSizes.size4;
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
            itemCardBloc?.emit(ItemCardEmptyState());
          } else {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(
                  currentState.baseModel.message ??
                      Utils.getStringValue(
                          context, AppStringConstant.somethingWentWrong),
                  context);
            });
          }
        }
        return buildUi(ctx);
      },
    );
  }

  Widget buildUi(BuildContext context) {
    return Container(
      width: AppSizes.catProductItemHeight,
      padding: const EdgeInsets.all(AppSizes.spacingGeneric),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey[350]!)),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(children: <Widget>[
                    Center(
                      child: SizedBox(
                        width: widget.imageSize!,
                        height: widget.imageSize!,
                        child: ImageView(
                          fit: BoxFit.fill,
                          url: widget.product?.thumbNail,
                        ),
                      ),
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
                    Positioned(
                        right: AppSizes.spacingTiny,
                        top: AppSizes.spacingTiny,
                        child: InkWell(
                          onTap: () async {
                            if (await appStoragePref.isLoggedIn()) {
                              if (widget.product?.isInWishlist != true) {
                                itemCardBloc?.add(AddToWishlistEvent(
                                    widget.product?.entityId.toString()));
                              } else {
                                AppDialogHelper.confirmationDialog(
                                    Utils.getStringValue(context,
                                        AppStringConstant.removeItemFromWishlist),
                                    context,
                                    AppLocalizations.of(context),
                                    title: Utils.getStringValue(
                                        context, AppStringConstant.removeItem),
                                    onConfirm: () async {
                                  itemCardBloc?.add(RemoveFromWishlistEvent(
                                      widget.product?.wishlistItemId
                                          .toString()));
                                });
                              }
                            } else {
                              AppDialogHelper.confirmationDialog(
                                  Utils.getStringValue(
                                      context,
                                      AppStringConstant
                                          .loginRequiredToAddOnWishlist),
                                  context,
                                  AppLocalizations.of(context),
                                  title: Utils.getStringValue(
                                      context, AppStringConstant.loginRequired),
                                  onConfirm: () async {
                                Navigator.of(context)
                                    .pushNamed(AppRoutes.signInSignUp);
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(17)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 1), // changes position of shadow
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
                    if (widget.product?.hasSpecialPrice() == true)
                      Positioned(
                          left: AppSizes.linePadding,
                          top: AppSizes.linePadding,
                          child: ColoredBox(
                            color: AppColors.discount,
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppSizes.spacingTiny,
                                    vertical: AppSizes.spacingTiny),
                                child: Text(
                                    "${widget.product?.getDiscountPercentage()}${Utils.getStringValue(context, AppStringConstant.offPercentage)}",
                                    style: const TextStyle(
                                        color: AppColors.white,
                                        fontSize: AppSizes.spacingGeneric))),
                          )),
                  ]),
                ],
              ),
              const SizedBox(width: AppSizes.spacingNormal),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
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
                                            fontSize: AppSizes.textSizeSmall)),
                              ],
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: AppSizes.size4,
                    ),
                    (widget.callBack != null)
                        ? Row(
                            children: [
                              Checkbox(
                                  value: widget.isSelected,
                                  onChanged: (value) {
                                    setState(() {
                                      widget.isSelected = !widget.isSelected;
                                    });
                                  }),
                              Expanded(
                                child: Text(widget.product?.name ?? '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            fontSize: AppSizes.textSizeSmall)
                                    // const TextStyle(fontSize: 12.0, color: Colors.black),
                                    ),
                              )
                            ],
                          )
                        : Text(widget.product?.name ?? '',
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
                        color: Utils.ratingBackground(
                                widget.product?.rating.toString() ?? '') ??
                          Colors.pink,
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
            ],
          ),
        ],
      ),
    );
  }
}
