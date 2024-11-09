/*
 *


 *
 * /
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/configuration/unvells_theme.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';

import '../../../app_widgets/image_view.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_string_constant.dart';
import '../../../helper/app_localizations.dart';
import '../../../helper/bottom_sheet_helper.dart';
import '../../../models/order_details/order_detail_model.dart';
import '../../add_review/add_review_screen.dart';
import '../../add_review/bloc/add_review_screen_bloc.dart';
import '../../add_review/bloc/add_review_screen_repository.dart';
import 'option_details.dart';

Widget orderItemCard(
    OrderItem item, BuildContext context, AppLocalizations? localization) {
  return Container(
    padding: const EdgeInsets.only(top: AppSizes.paddingNormal),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 10, 10.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Stack(children: <Widget>[
              SizedBox(
                height: (AppSizes.deviceWidth / 3),
                width: (AppSizes.deviceWidth / 3),
                child: ImageView(
                  url: item.image,
                ),
              ),
              if ((item.options ?? []).isNotEmpty)
                Positioned(
                    right: 78,
                    top: 97,
                    child: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (ctx) => OptionDetails(
                              item,
                            ),
                          );
                        },
                        icon: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            child: const Icon(Icons.info_outline))))
            ]),
          ),
          const SizedBox(
            width: AppSizes.size12,
          ),
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: AppSizes.linePadding),
                  child: Text(item.name ?? '',
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                      style: KTextStyle.of(context).semiBoldSixteen
                      // ?.copyWith(fontSize: AppSizes.textSizeMedium, color: AppColors.textColorPrimary)
                      ),
                ),
                (item.options ?? []).isNotEmpty
                    ? const SizedBox(
                        height: AppSizes.spacingTiny,
                      )
                    : Container(),
                (item.options ?? []).isNotEmpty
                    ? itemDetailView(
                        '${localization?.translate(AppStringConstant.size)}',
                        "${item.options?[0]?.value?[0] ?? "L"}",
                        context)
                    : Container(),
                (item.options ?? []).isNotEmpty
                    ? const SizedBox(
                        height: AppSizes.spacingTiny,
                      )
                    : Container(),
                ((item.options ?? []).isNotEmpty&&item.options!.length>2)
                    ? itemDetailView(
                        '${localization?.translate(AppStringConstant.color)}',
                        "${item.options?[1].value?[0] ?? "red"}",
                        context)
                    : Container(),
                (item.options ?? []).isNotEmpty
                    ? const SizedBox(
                        height: AppSizes.spacingTiny,
                      )
                    : Container(),
                (item.options ?? []).isNotEmpty
                    ? itemDetailView(
                        '${localization?.translate(AppStringConstant.qty)}',
                        '${item.qty?.ordered ?? "5"}',
                        context)
                    : Container(),
                (item.options ?? []).isNotEmpty
                    ? const SizedBox(
                        height: AppSizes.spacingTiny,
                      )
                    : Container(),
                (item.options ?? []).isNotEmpty
                    ? itemDetailView(
                        '${localization?.translate(AppStringConstant.shippedColon)}',
                        '${item.qty?.shipped ?? "2"}',
                        context)
                    : Container(),
                // const SizedBox(
                //   height: AppSizes.spacingTiny,
                // ),
                itemDetailView(
                    '${localization?.translate(AppStringConstant.price)}',
                    item.price ?? '',
                    context),
                // const SizedBox(
                //   height: AppSizes.spacingTiny,
                // ),
                itemDetailView(
                    '${localization?.translate(AppStringConstant.subtotal)}',
                    item.subTotal ?? '',
                    context),
                // itemDetailView(
                //     '${localization?.translate(AppStringConstant.qty)}',
                //     item.qty?.ordered.toString() ?? '',
                //     context),
                // const SizedBox(
                //   height: AppSizes.spacingGeneric,
                // ),
                itemAddReview(() {
                  reviewBottomModalSheet(context, item.name ?? '',
                      item.image ?? '', item.productId ?? "", []);
                }, '${localization?.translate(AppStringConstant.writeReview)}',
                    context),
                // const SizedBox(
                //   height: AppSizes.size8,
                // )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget itemDetailView(String key, String value, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: AppSizes.linePadding),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text(
            key,
            style: KTextStyle.of(context).sixteen.copyWith(color: Colors.grey),

            // ?.apply(color: AppColors.textColorSecondary)
            // ?.copyWith(fontSize: AppSizes.textSizeSmall, color: AppColors.textColorSecondary)
          ),
        ),

        // const SizedBox(
        //   width: 14.0,
        // ),
        // Expanded(
        //     flex: 1,
        //     child: Text("-", style: Theme.of(context).textTheme.bodyMedium
        //         // ?.copyWith(fontSize: AppSizes.textSizeSmall, color: AppColors.textColorPrimary)
        //         )),
        Expanded(
          flex: 2,
          child: Text(
            value, style: KTextStyle.of(context).sixteen,
            // ?.apply(/*fontSize: AppSizes.textSizeSmall*/ color: AppColors.textColorPrimary)
          ),
        ),
      ],
    ),
  );
}

Widget itemAddReview(
    VoidCallback callback, String title, BuildContext context) {
  return TextButton(
      onPressed: callback,
      style: TextButton.styleFrom(backgroundColor: Colors.transparent,padding: EdgeInsets.zero),
      child: Text((title.toUpperCase() ?? ''),
          textAlign: TextAlign.center,
          style:
              KTextStyle.of(context).sixteen.copyWith(color: AppColors.gold)));
}
