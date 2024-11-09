/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/helper/app_storage_pref.dart';
import 'package:test_new/unvells/models/categoryPage/product_tile_data.dart';

import '../../../app_widgets/app_alert_message.dart';
import '../../../app_widgets/app_dialog_helper.dart';
import '../../../app_widgets/image_view.dart';
import '../../../configuration/unvells_theme.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/app_string_constant.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/LocalDb/floor/database.dart';
import '../../../helper/LocalDb/floor/entities/recent_product.dart';
import '../../../helper/LocalDb/floor/recent_view_controller.dart';
import '../../../helper/app_localizations.dart';
import '../../../helper/utils.dart';
import 'item_card_bloc/item_card_bloc.dart';
import 'item_card_bloc/item_card_event.dart';
import 'item_card_bloc/item_card_state.dart';

class HomePageProductCard extends StatefulWidget {
  double? imageSize;

  final ProductTileData? product;

  HomePageProductCard({super.key, this.product, this.imageSize});

  @override
  State<HomePageProductCard> createState() => _HomePageProductCardState();
}

class _HomePageProductCardState extends State<HomePageProductCard> {
  bool isLoading = true;
  ItemCardBloc? itemCardBloc;

  @override
  Widget build(BuildContext ctx, {Function(String)? callback}) {
    widget.imageSize ??= (AppSizes.deviceWidth / 2.5) - AppSizes.linePadding;
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
            if (widget.product?.entityId.toString() == currentState.productId) {
              widget.product?.isInWishlist = true;
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
    widget.imageSize ??= (AppSizes.deviceWidth / 2.5) - AppSizes.linePadding;
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
            color:Theme.of(context).dividerColor,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(children: <Widget>[
              Center(
                child: ImageView(
                    fit: BoxFit.fill,
                    url: widget.product?.thumbNail,
                    width: widget.imageSize!,
                    height: (widget.imageSize!)-10,
                    borderRadius: BorderRadius.circular(0)),
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
                  right: AppSizes.spacingGeneric,
                  top: AppSizes.spacingGeneric,
                  // bottom: AppSizes.spacingTiny,
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
              if (widget?.product?.isNew ?? true)
                Positioned(
                    left: AppSizes.linePadding,
                    top: AppSizes.linePadding,
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
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: AppSizes.size8,
                    top: AppSizes.size8,
                    right: AppSizes.size8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: ((AppSizes.deviceWidth/2)-26)/2,
                          child: Text(
                              (widget.product?.formattedFinalPrice ?? '')
                                      .isNotEmpty
                                  ? widget.product?.formattedFinalPrice ?? ''
                                  : '',
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(fontSize: AppSizes.textSizeMedium)),
                        ),

                        if((widget.product?.hasSpecialPrice() ?? false))...[
                          SizedBox(
                            width: ((AppSizes.deviceWidth/2)-26)/2,
                            child: Text(widget.product?.formattedPrice ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: AppSizes.textSizeSmall,
                                    fontFamily: "Roboto")),
                          )
                        ]

                      ],
                    ),
                    // const SizedBox(
                    //   height: AppSizes.size4,
                    // ),
                    // if (widget.product?.hasSpecialPrice() == true)
                    //   Container(
                    //     decoration: BoxDecoration(
                    //         color: Colors.white12,
                    //         border: Border.all(
                    //           color: AppColors.green,
                    //         )
                    //     ),
                    //     child: Padding(
                    //       padding: const EdgeInsets.only(top: AppSizes.linePadding, bottom: AppSizes.linePadding, left: AppSizes.linePadding, right: AppSizes.linePadding),
                    //       child: Text("${widget.product?.getDiscountPercentage()}${Utils.getStringValue(context, AppStringConstant.offPercentage)}", style: TextStyle(color: AppColors.green),),
                    //     ),
                    //   ),
                    const SizedBox(
                      height: AppSizes.spacingGeneric,
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
                        maxLines: 1,
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
                                width: AppSizes.size2,
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
            ),
          ],
        ),
      ),
    );
  }
}
