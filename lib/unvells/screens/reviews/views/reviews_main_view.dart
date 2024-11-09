/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/models/reviews/reviews_list_model.dart';

import '../../../app_widgets/image_view.dart';
import '../../../app_widgets/rating_bar.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/app_localizations.dart';

Widget reviewMainView(BuildContext context, List<ReviewsListData>? orders,
    AppLocalizations? localizations, ScrollController controller,
    {ScrollPhysics scrollPhysics = const AlwaysScrollableScrollPhysics()}) {
  return ListView.separated(
    controller: controller,
    shrinkWrap: true,
    physics: scrollPhysics,
    itemBuilder: (ctx, index) =>
        reviewItem(context, orders?[index], localizations),
    separatorBuilder: (ctx, index) => const SizedBox(
      height: AppSizes.size4,
      child: Divider(),
    ),
    itemCount: (orders?.length ?? 0),
  );
}

Widget reviewItem(BuildContext context, ReviewsListData? item,
    AppLocalizations? localizations) {
  return Container(
    padding: const EdgeInsets.only(
        top: AppSizes.size8, left: AppSizes.size8, right: AppSizes.size8),
    margin: const EdgeInsets.only(bottom: AppSizes.size10),
    color: Theme.of(context).cardColor,
    child: GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.reviewDetail,
            arguments: item?.id);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: AppSizes.reviewProductIconSize,
                width: AppSizes.reviewProductIconSize + 10,
                child: ImageView(
                  url: item?.thumbNail,
                ),
              ),
              const SizedBox(width: AppSizes.spacingGeneric),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        AppRoutes.productPage,
                        arguments: getProductDataAttributeMap(
                          item?.productName ?? "",
                          item?.productId.toString() ?? "",
                        ),
                      );
                    },
                    child: Text(
                      item?.productName.toString() ?? " ",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(),
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacingGeneric),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      RatingBar(
                        starCount: 5,
                        color: AppColors.yellow,
                        rating: item?.customerRating,
                      ),
                      const SizedBox(width: AppSizes.spacingTiny),
                      Text(
                          '${item?.customerRating.toString()} ${AppStringConstant.stars}' ??
                              '',
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  const SizedBox(height: AppSizes.spacingGeneric),
                ],
              ),

              // Edit button
            ],
          ),
          const Icon(
            Icons.navigate_next,
            color: AppColors.lightGray,
          )
        ],
      ),
    ),
  );
}
