/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';

import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/app_localizations.dart';
import 'package:test_new/unvells/models/productDetail/product_review_data.dart';
import 'package:test_new/unvells/screens/product_detail/widgets/product_review_circle.dart';
import 'package:test_new/unvells/screens/product_detail/widgets/review_list_item_card.dart';

import '../../../constants/app_constants.dart';
import '../../../helper/bottom_sheet_helper.dart';
import '../../../models/productDetail/product_detail_page_model.dart';


  Widget productReviewList(  ProductDetailPageModel? _productDetailPageModel, BuildContext context, AppLocalizations? localizations, int? reviewCount) {
    return ((_productDetailPageModel?.reviewList != null)
        ? ExpansionTile(
      initiallyExpanded: true,
            title: Text(
               "${localizations?.translate( AppStringConstant.reviews)} ($reviewCount)",
                style: Theme.of(context).textTheme.titleSmall),
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: AppSizes.size20),
                color: Theme.of(context).cardColor,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppSizes.size20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [const ProductReviewCircle(), productRating(_productDetailPageModel, context, localizations, reviewCount)],
                    ),
                  ),
                ]),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: AppSizes.size8,
                      horizontal: AppSizes.size8),
                  child: ListView.builder(
                      itemCount: _productDetailPageModel?.reviewList?.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var data = _productDetailPageModel?.reviewList?[index];
                        return reviewListItemCard(
                            data,
                            context,
                        );
                      }),
                ),
            ],
        )
        : Container());
  }


  Widget productRating(ProductDetailPageModel? _productDetailPageModel, BuildContext context, AppLocalizations? localizations, int? reviewCount) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        padding: const EdgeInsets.only(top: AppSizes.size8),
        child: Text(localizations?.translate(AppStringConstant.basedOn) ?? '',
            style: Theme.of(context).textTheme.bodyLarge),
      ),
      Container(
        padding: const EdgeInsets.only(top: AppSizes.linePadding),
        child: Text(
            '$reviewCount ${localizations?.translate(AppStringConstant.reviews) ?? ''}',
            style:
                Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 12)),
      ),
      Container(
        padding: const EdgeInsets.only(top: AppSizes.size8),
        child: GestureDetector(
          onTap: () {
            reviewBottomModalSheet(context, _productDetailPageModel?.name ?? '', _productDetailPageModel?.thumbNail ?? '', _productDetailPageModel?.id ?? "", _productDetailPageModel?.ratingFormData??[]);

            // if (AppSharedPref().getIfLogin() != null &&
            //     AppSharedPref().getIfLogin() == true) {
            //   reviewBottomModalSheet(
            //       context,
            //       widget.productDetails?[productNameKey],
            //       widget.productDetails?[productImageKey],
            //       widget.productDetails?[templateIdKey], function: () {
            //     reviewPageBloc?.emit(ReviewScreenInitial());
            //     reviewPageBloc?.add(ReviewsDataFetchEvent(
            //         widget.productDetails?[templateIdKey].toString()));
            //   });
            // } else {
            //   DialogHelper.confirmationDialog(
            //       "${_localizations?.translate(AppStringConstant.signInToContinue)}",
            //       context,
            //       _localizations, onConfirm: () async {
            //     Navigator.pushNamed(context, loginSignup, arguments: false);
            //   });
            // }
          },
          child: Text(
              localizations?.translate(AppStringConstant.addReview) ?? '',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: AppColors.blue, fontSize: 12)),
        ),
      ),
    ]);
  }

