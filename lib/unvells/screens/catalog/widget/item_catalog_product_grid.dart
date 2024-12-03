/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/screens/home/widgets/item_card_bloc/item_card_bloc.dart';

import '../../../app_widgets/app_alert_message.dart';
import '../../../app_widgets/app_dialog_helper.dart';
import '../../../app_widgets/flux_image.dart';
import '../../../app_widgets/image_view.dart';
import '../../../app_widgets/loader.dart';
import '../../../configuration/unvells_theme.dart';
import '../../../configuration/text_theme.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/app_localizations.dart';
import '../../../helper/app_storage_pref.dart';
import '../../../models/categoryPage/product_tile_data.dart';
import '../../cart/bloc/cart_screen_bloc.dart';
import '../../cart/bloc/cart_screen_repository.dart';
import '../../cart/widgets/quantity_changer.dart';
import '../../home/widgets/item_card_bloc/item_card_event.dart';
import '../../home/widgets/item_card_bloc/item_card_state.dart';

class ItemCatalogProductGrid extends StatefulWidget {
  double? imageSize;
  Function? callBack;
  bool isSelected = false;

  final ProductTileData? product;

  ItemCatalogProductGrid(
      {this.product, this.imageSize, this.callBack, this.isSelected = false});

  @override
  State<ItemCatalogProductGrid> createState() => _ItemCatalogProductGridState();
}

class _ItemCatalogProductGridState extends State<ItemCatalogProductGrid> {
  bool isLoading = false;
  bool action = false;
  ItemCardBloc? itemCardBloc;

  @override
  Widget build(BuildContext ctx, {Function(String)? callback}) {
    widget.imageSize ??= (AppSizes.deviceWidth / 2.5) - AppSizes.size4;
    itemCardBloc = ctx.read<ItemCardBloc>();
    return BlocBuilder<ItemCardBloc, ItemCardState>(
      builder: (context, currentState) {
        debugPrint(currentState.toString());
        if (currentState is ItemCardInitial) {
          isLoading = true;
          action = true;
        } else if (currentState is ItemCardErrorState) {
          isLoading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showError(
                currentState.message ??
                    Utils.getStringValue(
                        context, AppStringConstant.somethingWentWrong),
                context);
          });
        } else if (currentState is AddtoCartState) {
          isLoading = false;
          action = false;
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
            itemCardBloc?.emit(ItemCardEmptyState());
          }
        }
        return buildUi(ctx);
      },
    );
  }

  Widget buildUi(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Center(
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
            Positioned(
              right: AppSizes.spacingGeneric,
              top: AppSizes.spacingGeneric,
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
                      Navigator.of(context).pushNamed(AppRoutes.signInSignUp);
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
                        offset: const Offset(0, 1),
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
              ),
            ),
            if (widget.product?.hasSpecialPrice() == true)
              Positioned(
                bottom: AppSizes.spacingTiny,
                left: AppSizes.spacingGeneric,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.white12),
                  ),
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
                ),
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
                      Utils.getStringValue(context, AppStringConstant.newTest),
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: AppSizes.spacingSmall,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(
          height: AppSizes.size16,
        ),
        SizedBox(
          // width: AppSizes.deviceWidth * .4,
          height: AppSizes.deviceHeight*.06,
          child: Text(
            widget.product?.name ?? '',
            maxLines: 2,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: KTextStyle.of(context).semiBoldSixteen,
          ),
        ),
        const SizedBox(
          height: AppSizes.size8,
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
              ),
            ],
          ),
        ),
        const SizedBox(
          height: AppSizes.size8,
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                (widget.product?.formattedFinalPrice ?? '').isNotEmpty
                    ? widget.product?.formattedFinalPrice ?? ''
                    : '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: KTextStyle.of(context).sixteen,
              ),
              if ((widget.product?.hasSpecialPrice() ?? false)) ...[
                const SizedBox(
                  width: AppSizes.size2,
                ),
                SizedBox(
                  width: (widget.imageSize! / 2) - 10,
                  child: Text(
                    widget.product?.formattedPrice ?? '',
                    style: KTextStyle.of(context)
                        .twelve
                        .copyWith(color: Colors.grey,decoration: TextDecoration.lineThrough),

                  ),
                ),
              ],
            ],
          ),
        ),
        if (widget.callBack != null)
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(
                widget.isSelected
                    ? Icons.check_circle_outline_outlined
                    : Icons.radio_button_unchecked,
                color: widget.isSelected ? Colors.green : Colors.grey,
              ),
              onPressed: () => widget.callBack!(widget.product?.entityId),
            ),
          ),
      ],
    );
  }
}
