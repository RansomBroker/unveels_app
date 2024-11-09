/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/models/productDetail/product_review_data.dart';
import 'package:test_new/unvells/screens/product_detail/widgets/rating_container.dart';

import '../../../constants/app_constants.dart';

Widget reviewListItemCard(ProductReviewData? reviewData, BuildContext context,
    ) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      const Divider(),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RatingContainer(double.parse((reviewData?.ratings ?? []).isNotEmpty ?
          reviewData?.ratings?.first.value??"0.0" : "0.0")),
          const  SizedBox(
            width: AppSizes.size4 ,
          ),
          Text(
            '${reviewData?.title}',
            style: Theme.of(context).textTheme.titleLarge,
          )
        ],
      ),
      const SizedBox(
        height: AppSizes.size8,
      ),
      Flexible(child: Text("${reviewData?.details}")),
      const SizedBox(
        height: AppSizes.size8,
      ),
      Text(
        '${reviewData?.reviewBy}',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: Theme.of(context).textTheme.displaySmall?.color),
      ),
      const SizedBox(
        height: AppSizes.size8,
      ),
      Text(
        '${reviewData?.reviewOn}',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      const SizedBox(
        height: AppSizes.size8,
      ),
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
      //   children: [
      //     InkWell(
      //       onTap: onLike,
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           const Icon(Icons.favorite_border_outlined),
      //           const SizedBox(
      //             width: AppSizes.size4 ,
      //           ),
      //           Text("${reviewData?.likes ?? 0}",
      //               style: Theme.of(context).textTheme.bodyLarge)
      //         ],
      //       ),
      //     ),
      //     InkWell(
      //       onTap: onDislike,
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           const Icon(Icons.thumb_down_alt_outlined),
      //           const SizedBox(
      //             width: AppSizes.size4 ,
      //           ),
      //           Text("${reviewData?.dislikes ?? 0}",
      //               style: Theme.of(context).textTheme.bodyLarge)
      //         ],
      //       ),
      //     )
      //   ],
      // ),
    ],
  );
}
