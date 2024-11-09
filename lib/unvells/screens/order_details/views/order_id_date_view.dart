/*
 *
  

 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/app_string_constant.dart';
import '../../../helper/app_localizations.dart';
import '../../../helper/utils.dart';
import '../../../models/order_details/order_detail_model.dart';

Widget orderIdContainer(BuildContext context, OrderDetailModel? orderModel,
    AppLocalizations? localization) {
  return Container(
    decoration: BoxDecoration(
      color: Theme
          .of(context)
          .cardColor,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppSizes.paddingMedium),
          topRight: Radius.circular(AppSizes.paddingMedium)),
    ),
    padding: const EdgeInsets.symmetric(horizontal: AppSizes.size8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSizes.paddingMedium,
        ),
        Text(
          '${localization?.translate(AppStringConstant.orderId)} #${orderModel
              ?.incrementId}',
          style: KTextStyle
              .of(context)
              .sixteen,
        ),
        const SizedBox(
          height: AppSizes.paddingMedium,
        ),
        const Divider(
          thickness: 1,
          height: 1,
        ),
      ],
    ),
  );
}

Widget orderPlaceDateContainer(BuildContext context,
    OrderDetailModel? orderModel, AppLocalizations? localization) {
  return Container(
      color: Theme
          .of(context)
          .cardColor,
      width: AppSizes.deviceWidth,
      padding: const EdgeInsets.symmetric(
          vertical: AppSizes.paddingMedium, horizontal: AppSizes.size8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localization?.translate(AppStringConstant.placedOn) ?? "",
                style: KTextStyle
                    .of(context)
                    .semiTwelve,
              ),
              const SizedBox(
                height: AppSizes.linePadding,
              ),
              Text(
                orderModel?.orderDate ?? "",
                style: KTextStyle
                    .of(context)
                    .semiBoldSixteen,
              ),
            ],
          ),
          Text(
            orderModel?.statusLabel?.toUpperCase() ?? "",
            style:  KTextStyle.of(context).boldTwelve.copyWith(color: Utils.orderStatusBackground(
                orderModel!.state.toString(),
                orderModel.statusColorCode.toString())),
          ),

        ],
      ));
}