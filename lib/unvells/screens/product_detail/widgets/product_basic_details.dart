/*
 *


 *
 * /
 */

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:test_new/unvells/app_widgets/flux_image.dart';
import 'package:test_new/unvells/configuration/unvells_theme.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/app_storage_pref.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/screens/product_detail/bloc/product_detail_screen_bloc.dart';
import 'package:test_new/unvells/screens/product_detail/bloc/product_detail_screen_state.dart';
import 'package:test_new/unvells/screens/product_detail/widgets/rating_container.dart';

import '../../../app_widgets/app_dialog_helper.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/app_localizations.dart';
import '../../../helper/bottom_sheet_helper.dart';
import '../../../models/productDetail/product_detail_page_model.dart';
import '../bloc/product_detail_screen_events.dart';

class ProductPageBasicDetailsView extends StatefulWidget {
  final ProductDetailPageModel? product;
  final ValueChanged<bool>? callback;
  bool addedToWishlist = false;
  ProductDetailScreenBloc? productPageBloc;
  final dynamic startArActivity;
  final bool getArStatus;

  ProductPageBasicDetailsView(this.addedToWishlist, this.productPageBloc,
      {super.key,
      this.product,
      this.callback,
      this.startArActivity,
      required this.getArStatus});

  @override
  State<StatefulWidget> createState() {
    return ProductPageBasicDetailsViewState();
  }
}

class ProductPageBasicDetailsViewState
    extends State<ProductPageBasicDetailsView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).cardColor,
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        alignment: Alignment.topLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.product?.name ?? '',
                      style: KTextStyle.of(context).semiBold24,),
                  SizedBox(height: 11),
              
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: widget.product?.rating ?? 0.0,
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
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                          onTap: () {
                            reviewBottomModalSheet(
                                context,
                                widget.product?.name ?? '',
                                widget.product?.thumbNail ?? '',
                                widget.product?.id ?? "",
                                widget.product?.ratingFormData ?? []);
                          },
                          child:
                              // ((widget.product?.reviewCount ?? 0) > 0)
                              //     ?
                              Text(
                            Utils.getStringValue(context, AppStringConstant.addReview)
                                .toUpperCase(),
                            style: KTextStyle.of(context)
                                .twelve
                                .copyWith(color: AppColors.gold),
                          )
                          // : Text(
                          //     Utils.getStringValue(
                          //             context,
                          //             AppStringConstant
                          //                 .beTheFirstToReviewThisProduct)
                          //         .toUpperCase(),
                          //     style: Theme.of(context)
                          //         .textTheme
                          //         .button
                          //         ?.copyWith(color: AppColors.blue),
                          //   ),
                          ),
                    ],
                  ),
              
                  SizedBox(
                    height: 8.0,
                  ),
                  // Text(widget.product?.availability?.toUpperCase() ?? '',
                  //     style: KTextStyle.of(context).boldTwelve),
                  // SizedBox(
                  //   height: 8.0,
                  // ),
                  if (widget.product?.typeId !=
                      'bss_giftcard')
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Visibility(
                          visible: (widget.product?.hasPrice() ?? true),
                          child: Row(
                            children: [
                              Text(
                                (widget.product?.formattedFinalPrice ?? '').isNotEmpty
                                    ? widget.product?.formattedFinalPrice ?? ''
                                    : '',
                                style: KTextStyle.of(context).semiBold24,
                              ),
                              SizedBox(
                                width: AppSizes.size8,
                              ),
                            ],
                          )),
              
                      Visibility(
                          visible: (widget.product?.hasSpecialPrice() ?? false),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: AppSizes.linePadding,
                              ),
                              Text(
                                widget.product?.formattedPrice ?? '',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Theme.of(context).textTheme.headlineLarge!.color,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          )),
              
                      // if (widget.product?.hasSpecialPrice()??true)
                      //   Text(
                      //     widget.product?.formattedPrice.toString() ?? '',
                      //     style: TextStyle(
                      //       fontSize: 12.0,
                      //       color: Theme.of(context).textTheme.headlineLarge!.color,
                      //       decoration: TextDecoration.lineThrough,
                      //     ),
                      //   ),
              
                      if (widget.product?.hasSpecialPrice() == true)
                        SizedBox(
                          width: AppSizes.size8,
                        ),
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
                              style: TextStyle(color: AppColors.green),
                            ),
                          ),
                        ),
              
                      Visibility(
                          visible: (widget.product?.hasMinPrice() ?? false),
                          child: Row(
                            children: [
                              Text(
                                (widget.product?.formattedMinPrice ?? '').isNotEmpty
                                    ? widget.product?.formattedMinPrice ?? ''
                                    : '',
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              SizedBox(
                                width: AppSizes.spacingTiny,
                              ),
                            ],
                          )),
              
                      Visibility(
                          visible: (widget.product?.hasMaxPrice() ?? false),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: AppSizes.linePadding,
                              ),
                              Text(
                                '-',
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              SizedBox(
                                width: AppSizes.spacingTiny,
                              ),
                              Text(
                                (widget.product?.formattedMaxPrice ?? '').isNotEmpty
                                    ? widget.product?.formattedMaxPrice ?? ''
                                    : '',
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              SizedBox(
                                width: AppSizes.size8,
                              ),
                            ],
                          )),
                    ],
                  ),
                  // SizedBox(
                  //   height: AppSizes.size6,
                  // ),
                  //
                  // SizedBox(
                  //   height: 12.0,
                  // ),
                  // Divider(),
                  // actionContainer()
                ],
              ),
            ),
            if (widget.getArStatus)
              Container(
                // height: AppSizes.size30,
                // width: AppSizes.size30,
                padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                decoration: ShapeDecoration(
                  color: Color(0xFFF0F0F0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9)),
                ),
                child: InkWell(
                    onTap: widget.startArActivity,
                    child: Column(
                      children: [
                        FluxImage(
                          imageUrl: 'assets/icons/ar.svg',
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        SizedBox(
                          width: AppSizes.deviceWidth*.15,
                          child: Text(
                            "Available in AR",
                            textAlign: TextAlign.center,
                            style: KTextStyle.of(context).semiTwelve,
                          ),
                        )
                      ],
                    )),
              ),
          ],
        ));
  }

  Widget productReviews(int totalReview, double avgReview) {
    return Row(
      children: [
        RatingContainer((widget.product?.rating?.toDouble() ?? 0.0)),
        SizedBox(
          width: AppSizes.size8,
        ),
        Text(
          "$totalReview ${Utils.getStringValue(context, AppStringConstant.reviews)}",
          style: Theme.of(context).textTheme.bodyLarge,
        )
      ],
    );
  }

  Widget actionContainer() {
    return SizedBox(
        height: 50,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: OutlinedButton(
                  onPressed: () {
                    if (appStoragePref.isLoggedIn() == true) {
                      !widget.addedToWishlist
                          ? widget.productPageBloc?.add(AddToWishlistEvent(
                              widget.product?.id.toString() ?? ''))
                          : AppDialogHelper.confirmationDialog(
                              Utils.getStringValue(context,
                                  AppStringConstant.removeItemFromWishlist),
                              context,
                              AppLocalizations.of(context),
                              title: Utils.getStringValue(
                                  context, AppStringConstant.removeItem),
                              onConfirm: () async {
                              widget.productPageBloc?.add(
                                  RemoveFromWishlistEvent(widget
                                      .product?.wishlistItemId
                                      .toString()));
                            });
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                          (widget.product?.isInWishlist ?? false)
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          color: (widget.product?.isInWishlist ?? false)
                              ? AppColors.lightRed
                              : Theme.of(context).colorScheme.outline),
                      SizedBox(
                        width: AppSizes.size2,
                      ),
                      SizedBox(
                        width: (AppSizes.deviceWidth / 3) - 75,
                        child: Text(
                            Utils.getStringValue(
                                        context, AppStringConstant.wishList)
                                    .toUpperCase() ??
                                '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                    fontSize: AppSizes.textSizeTiny)),
                      )
                    ],
                  ),
                )),
            const SizedBox(width: 4.0),
            Expanded(
                flex: 1,
                child: OutlinedButton(
                  onPressed: () {
                    if (appStoragePref.isLoggedIn() == true) {
                      widget.productPageBloc?.add(AddToCompareEvent(
                          widget.product?.id.toString() ?? ''));
                    } else {
                      AppDialogHelper.confirmationDialog(
                          Utils.getStringValue(context,
                              AppStringConstant.loginRequiredToAddOnCompare),
                          context,
                          AppLocalizations.of(context),
                          title: Utils.getStringValue(
                              context, AppStringConstant.loginRequired),
                          onConfirm: () async {
                        Navigator.of(context).pushNamed(AppRoutes.signInSignUp);
                      });
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.swap_horizontal_circle_outlined,
                          color: Theme.of(context).colorScheme.outline),
                      SizedBox(
                        width: AppSizes.size2,
                      ),
                      SizedBox(
                        width: (AppSizes.deviceWidth / 3) - 75,
                        child: Text(
                            Utils.getStringValue(
                                    context, AppStringConstant.compare)
                                .toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                    fontSize: AppSizes.textSizeTiny)),
                      )
                    ],
                  ),
                )),
            const SizedBox(width: 4.0),
            Expanded(
                flex: 1,
                child: OutlinedButton(
                  onPressed: () async {
                    await FlutterShare.share(
                        title: widget.product?.name ?? '',
                        text: '',
                        linkUrl: widget.product?.productUrl,
                        chooserTitle: '');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.share,
                          color: Theme.of(context).colorScheme.outline),
                      SizedBox(
                        width: AppSizes.size2,
                      ),
                      SizedBox(
                        width: (AppSizes.deviceWidth / 3) - 75,
                        child: Text(
                            Utils.getStringValue(
                                    context, AppStringConstant.share)
                                .toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                    fontSize: AppSizes.textSizeTiny)),
                      )
                    ],
                  ),
                )),
          ],
        ));
  }
}
