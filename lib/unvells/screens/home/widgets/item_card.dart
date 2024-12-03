/*
 *


 *
 * /
 */

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:test_new/unvells/app_widgets/flux_image.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/models/categoryPage/product_tile_data.dart';
import 'package:test_new/unvells/screens/home/bloc/home_screen_bloc.dart';

import '../../../app_widgets/app_alert_message.dart';
import '../../../app_widgets/app_dialog_helper.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/app_string_constant.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/app_localizations.dart';
import '../../../helper/app_storage_pref.dart';
import '../../../helper/utils.dart';
import '../../cart/bloc/cart_screen_bloc.dart';
import '../../cart/bloc/cart_screen_event.dart';
import '../../cart/bloc/cart_screen_repository.dart';
import '../../cart/bloc/cart_screen_state.dart';
import '../../cart/widgets/quantity_changer.dart';
import '../bloc/home_screen_events.dart';
import 'item_card_bloc/item_card_bloc.dart';
import 'item_card_bloc/item_card_event.dart';
import 'item_card_bloc/item_card_state.dart';

class ItemCard extends StatefulWidget {
  double? imageSize;
  Function? callBack;
  bool isSelected = false;

  final ProductTileData? product;

  ItemCard(
      {this.product, this.imageSize, this.callBack, this.isSelected = false});

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool isLoading = false;
  ItemCardBloc? itemCardBloc;
  CartScreenBloc? cartScreenBloc;

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

          WidgetsBinding.instance.addPostFrameCallback((_) {
            AlertMessage.showError(
                currentState.message ??
                    Utils.getStringValue(
                        context, AppStringConstant.somethingWentWrong),
                context);
          });
        } else if (currentState is AddProductToWishlistStateSuccess) {
          isLoading = false;
          if (currentState.wishListModel.success == true) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
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
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AlertMessage.showError(
                  currentState.wishListModel.message ?? '', context);
            });
          }
          itemCardBloc?.emit(ItemCardEmptyState());
        } else if (currentState is AddtoCartState) {
          isLoading = false;
          if (currentState.model?.success == true) {
            if ((currentState.model?.quoteId ?? 0) != 0) {
              appStoragePref.setQuoteId(currentState.model?.quoteId);
            }
            appStoragePref.setCartCount(currentState.model?.cartCount);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AlertMessage.showSuccess(
                  currentState.model?.message ?? "", context);
              itemCardBloc?.emit(WishlistIdleState());
            });
          }
        } else if (currentState is RemoveFromWishlistStateSuccess) {
          isLoading = false;
          if (currentState.baseModel.success == true) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AlertMessage.showSuccess(
                  currentState.baseModel.message ?? '', context);
              itemCardBloc?.emit(WishlistIdleState());
            });
            if (widget.product?.wishlistItemId.toString() ==
                currentState.productId) {
              widget.product?.isInWishlist = false;
            }
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AlertMessage.showError(
                  currentState.baseModel.message ??
                      Utils.getStringValue(
                          context, AppStringConstant.somethingWentWrong),
                  context);
            });
          }

          itemCardBloc?.emit(ItemCardEmptyState());
          if (currentState.fromWishlist) {
            Future.delayed(Duration.zero).then(
              (value) {
                HiveStore().reset();
                context
                    .read<HomeScreenBloc>()
                    .add(const HomeScreenDataFetchEvent(true));
                // itemCardBloc?.emit(WishlistIdleState());
              },
            );
          }
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
      child: LayoutBuilder(builder: (context, constrains) {
        return Column(
          // mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(children: <Widget>[
              Container(
                width:
                    (AppSizes.deviceWidth - (AppSizes.size8 + AppSizes.size8)) /
                        2.5,
                height: constrains.maxHeight * .7,
                decoration: ShapeDecoration(
                  color: Colors.white.withOpacity(.9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    // side: BorderSide(
                    //   width: .7,
                    //   color: Colors.grey.withOpacity(
                    //     0.1,
                    //   ),
                    // ),
                  ),
                ),
                child: FluxImage(
                  imageUrl: widget.product?.thumbNail ?? '',
                ),
              ),
              PositionedDirectional(
                bottom: AppSizes.spacingTiny,
                end: -AppSizes.deviceWidth * .2,
                child: QuantityChanger(
                  (value) async {
                    if (widget.product?.typeId == "simple" ||
                        widget.product?.typeId == "virtual") {
                      debugPrint("tappeedddd--->cartCallback");
                      Map<String, dynamic> mProductParamsJSON = {};
                      itemCardBloc?.add(AddtoCartEvent(
                          widget.product?.entityId.toString() ?? "",
                          1,
                          mProductParamsJSON));
                    } else {
                      AppDialogHelper.confirmationDialog(
                          Utils.getStringValue(
                              context,
                              Utils.getStringValue(
                                  context, AppStringConstant.addOptions)),
                          context,
                          AppLocalizations.of(context),
                          title: Utils.getStringValue(
                              context,
                              Utils.getStringValue(
                                  context, AppStringConstant.chooseVariant)),
                          onConfirm: () async {
                        Navigator.of(context).pushNamed(
                          AppRoutes.productPage,
                          arguments: getProductDataAttributeMap(
                            widget.product?.name ?? "",
                            widget.product?.entityId.toString() ?? "",
                          ),
                        );
                      });
                    }
                  },
                  1
                  // product?.
                  ,
                  isFromHome: true,
                ),
              ),
              // Positioned(child: child)
              // Align(alignment: AlignmentDirectional.bottomCenter,child: Qua,)
              Positioned(
                  right: AppSizes.spacingGeneric,
                  top: AppSizes.spacingGeneric,
                  // bottom: AppSizes.spacingTiny,
                  child: InkWell(
                    onTap: () async {
                      if (appStoragePref.isLoggedIn()) {
                        if (widget.product?.isInWishlist != true) {
                          itemCardBloc?.add(
                            AddToWishlistEvent(
                              widget.product?.entityId.toString(),
                            ),
                          );
                        } else {
                          if (kDebugMode) {
                            print(
                                "LISTITEMS-------->${widget.product?.wishlistItemId.toString()}");
                          }

                          if (context.mounted) {
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
                        shape: BoxShape.circle,
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
                            : const Color(0xff292D32),
                        size: 20,
                      ),
                    ),
                  )),
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
                            style: const TextStyle(color: AppColors.white),
                          ),
                        ),
                      )
                    : Container(),
              ),
              if (widget.product?.isNew ?? true)
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
              height: constrains.maxHeight * .3,
              child: FittedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: AppSizes.size16,
                    ),
                    SizedBox(
                      width: AppSizes.deviceWidth * .4,
                      child: Text(widget.product?.name ?? '',
                          maxLines: 3,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: KTextStyle.of(context).semiBoldSixteen
                          // const TextStyle(fontSize: 12.0, color: Colors.black),
                          ),
                    ),
                    const SizedBox(
                      height: AppSizes.size8,
                    ),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: double.parse(widget.product?.rating),
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.black,
                          ),
                          itemCount: 5,
                          unratedColor: Colors.grey.shade400,
                          itemSize: 15.0,
                          direction: Axis.horizontal,
                        ),
                        Text(
                          " (${widget.product?.reviewCount.toString() ?? ''})",
                        )
                      ],
                    ),
                    const SizedBox(
                      height: AppSizes.size8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                            (widget.product?.formattedFinalPrice ?? '')
                                    .isNotEmpty
                                ? widget.product?.formattedFinalPrice ?? ''
                                : '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: KTextStyle.of(context).sixteen),
                        if ((widget.product?.hasSpecialPrice() ?? false)) ...[
                          const SizedBox(
                            width: AppSizes.size2,
                          ),
                          Text(widget.product?.formattedPrice ?? '',
                              style: KTextStyle.of(context).twelve.copyWith(
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  )),
                        ],
                      ],
                    ),
                    (widget.callBack != null)
                        ? ((widget.product?.typeId.toString() == "simple") ??
                                false)
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Checkbox(
                                      value: widget.product?.isChecked ??
                                          widget.isSelected,
                                      onChanged: (value) {
                                        setState(() {
                                          widget.product?.isChecked =
                                              !(widget.product?.isChecked ??
                                                  false);
                                          // widget.callBack!();
                                          widget.isSelected =
                                              !widget.isSelected;
                                        });
                                      }),
                                  Expanded(
                                    child: Text(widget.product?.name ?? '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                fontSize:
                                                    AppSizes.textSizeSmall,
                                                fontWeight: FontWeight.bold)
                                        // const TextStyle(fontSize: 12.0, color: Colors.black),
                                        ),
                                  )
                                ],
                              )
                            : const SizedBox(
                                height: AppSizes.spacingTiny,
                              )
                        : const SizedBox(
                            // height: AppSizes.spacingTiny,
                            ),
                  ],
                ),
              ),
            ),
            // if (widget.product?.hasSpecialPrice() == true)
            //   Container(
            //     decoration: BoxDecoration(
            //         border: Border.all(
            //           color: AppColors.green,
            //         )
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.only(top: AppSizes.linePadding, bottom: AppSizes.linePadding, left: AppSizes.linePadding, right: AppSizes.linePadding),
            //       child: Text("${widget.product?.getDiscountPercentage()}"
            //           "${Utils.getStringValue(context, AppStringConstant.offPercentage)}", style: TextStyle(color: AppColors.green),),
            //     ),
            //   ),
            // if (widget.product?.hasSpecialPrice() == true)
            //   const SizedBox(
            //     height: AppSizes.spacingGeneric,
            //   ),
            // const SizedBox(
            //   height: AppSizes.spacingGeneric,
            // ),
          ],
        );
      }),
    );
  }
}
