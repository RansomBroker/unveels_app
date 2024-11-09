/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';

import '../../../configuration/text_theme.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_string_constant.dart';
import '../../../helper/app_localizations.dart';
import '../../../helper/utils.dart';
import '../../../models/order_details/order_detail_model.dart';
import 'order_heading_view.dart';


Widget orderPriceDetails(OrderDetailModel model, BuildContext context,
    AppLocalizations? localizations) {
  return orderHeaderLayout(
      context,
      localizations?.translate(AppStringConstant.priceDetails) ?? "",
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.size10),
        child: Column(
          children:
            (model.orderData?.totals??[]).map((e) => orderPriceDetailsItem(
                e.label ?? "",
                e.formattedValue??"",
                context)).toList(),
        ),
      ));
}

Widget orderPriceDetailsItem(String key, String value, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: AppSizes.size8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          key,
          style: KTextStyle.of(context).semiTwelve
          // ?.apply(color: AppColors.textColorSecondary),
        ),
        Text(value, style: KTextStyle.of(context).semiBoldSixteen
            // ?.apply(color: AppColors.textColorPrimary),
          ),
      ],
    ),
  );
}
