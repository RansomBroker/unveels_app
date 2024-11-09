/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/app_widgets/image_view.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/app_localizations.dart';
import 'package:test_new/unvells/models/cart/cart_item.dart';

Widget orderSummary(BuildContext context, AppLocalizations? _localization,
    List<CartItem> items) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
          _localization?.translate(AppStringConstant.items) ?? "",
          style: KTextStyle.of(context).boldSixteen),
      // const Divider(
      //   thickness: 1,
      //   height: 1,
      // ),
      const SizedBox(height: 16,),
      ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var data = items[index];
            return buildItems(data, context, _localization);
          }),
    ],
  );
}

Widget buildItems(
    CartItem item, BuildContext context, AppLocalizations? _localization) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Expanded(
        flex: 1,
        child: Stack(children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ImageView(
              fit: BoxFit.fill,
              url: item.thumbnail,
              height: (AppSizes.deviceWidth / 3),
              width: (AppSizes.deviceWidth / 3),
            ),
          ),
          // Positioned(
          //     left: 10,
          //     bottom: 10,
          //     child: Icon(
          //       Icons.info,
          //       color: AppColors.lightGray,
          //     ))
        ]),
      ),
  // Padding(
  //   padding: const EdgeInsets.all(8.0),
  //   child: ClipRRect(
  //   borderRadius: BorderRadius.circular(10),
  //   child: ImageView(
  //     url: item.thumbnail,
  //     width: (AppSizes.deviceWidth / 3),
  //     height: (AppSizes.deviceWidth / 3),
  //   )),
  // ),
      const SizedBox(
        width: AppSizes.size8,
      ),
      Expanded(
        flex: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // const SizedBox(
            //   height: 2.0,
            // ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: AppSizes.linePadding),
              child: Text(item.productName ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: KTextStyle.of(context).semiBoldSixteen),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: AppSizes.linePadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${_localization?.translate(AppStringConstant.price) ?? ""}: ",
                    style: KTextStyle.of(context).sixteen.copyWith(color: Colors.grey),
                  ),
                  Text(
                    item.price,
                    style: KTextStyle.of(context).sixteen,
                  )
                  // Text(
                  //     (item.priceReduce ?? '').isNotEmpty
                  //         ? item.priceReduce ?? ''
                  //         : item.priceUnit ?? '',
                  //     style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)
                  // ),
                  // Visibility(
                  //     visible:
                  //     (item.priceReduce ?? '').isNotEmpty,
                  //     child: Row(
                  //       children: [
                  //         const SizedBox(
                  //           width: AppSizes.linePadding,
                  //         ),
                  //         Text(item.priceUnit ?? '',
                  //             style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)
                  //         ),
                  //       ],
                  //     )),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: AppSizes.linePadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${_localization?.translate(AppStringConstant.qty) ?? ""}: ",
                    style: KTextStyle.of(context).sixteen.copyWith(color: Colors.grey),

                  ),
                  Text((item.qty?.toInt()).toString(),
                      style: KTextStyle.of(context).sixteen),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: AppSizes.linePadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${_localization?.translate(AppStringConstant.subtotal) ?? ""}: ",
                    style: KTextStyle.of(context).sixteen.copyWith(color: Colors.grey),

                  ),
                  Text(item.subTotal ?? "",
                      style: KTextStyle.of(context).sixteen),
                ],
              ),
            )
          ],
        ),
      ),
    ],
  );
}
