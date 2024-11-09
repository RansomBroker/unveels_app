/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/models/reviews/review_details_model.dart';
import 'package:test_new/unvells/models/reviews/reviews_list_model.dart';

import '../../../app_widgets/image_view.dart';
import '../../../app_widgets/rating_bar.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/app_localizations.dart';
import '../../../models/order_list/order_list_model.dart';



Widget itemRatingView(BuildContext context, List<RatingData>? orders,
    AppLocalizations? localizations, ScrollController controller ) {
  return ListView.separated(
    controller: controller,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (ctx, index) =>
        ratingItem(context, orders?[index], localizations,
        ),
    separatorBuilder: (ctx, index) => const SizedBox(
      height: AppSizes.size4,
      child: Divider(),
    ),
    itemCount: (orders?.length ?? 0),
  );
}

Widget ratingItem(BuildContext context, RatingData? item,
    AppLocalizations? localizations) {
  return Container(
    padding: const EdgeInsets.only(
        top: AppSizes.spacingGeneric,),
    margin: const EdgeInsets.only(bottom: AppSizes.size8),
    color: Theme.of(context).cardColor,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(AppSizes.size8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                item?.ratingCode.toString() ?? " ",
                style: Theme.of(context).textTheme.displaySmall
                    ?.copyWith(color: AppColors.textColorLink),
              ),
              // Edit button
            ],
          ),
        ),
      ],
    ),
  );
}