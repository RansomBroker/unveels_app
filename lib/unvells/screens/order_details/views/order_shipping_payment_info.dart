/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/app_string_constant.dart';
import '../../../helper/app_localizations.dart';
import '../../../models/order_details/order_detail_model.dart';
import 'address_item_card.dart';
import 'order_heading_view.dart';

Widget shippingPaymentInfo(BuildContext context,
    AppLocalizations? localizations, OrderDetailModel? orderModel) {
  return orderHeaderLayout(
      context,
      localizations?.translate(AppStringConstant.shippingPaymentInfo) ?? "",
      Column(
        children: [
          if(orderModel?.shippingAddress?.isNotEmpty==true)...[
          addressItemWithHeading(
              context,
              localizations?.translate(AppStringConstant.shippingAddress) ??
                  "",
              orderModel?.shippingAddress ?? "",
              isElevated: false),
          ],
          if(orderModel?.billingAddress?.isNotEmpty==true)
          addressItemWithHeading(
              context,
              localizations?.translate(AppStringConstant.billingAddress) ?? "",
              orderModel?.billingAddress ?? "",
              isElevated: false),
          if(orderModel?.shippingMethod?.isNotEmpty==true || orderModel?.paymentMethod?.isNotEmpty==true)
            shippingPaymentMethod(context, AppLocalizations.of(context), orderModel),
        ],
      ),);
}


Widget shippingPaymentMethod(BuildContext context,
    AppLocalizations? localizations, OrderDetailModel? orderModel) {
  return Column(
    children: [
      if(orderModel?.shippingMethod?.isNotEmpty==true)...[
        shippingPaymentMethodView(
            context,
            localizations?.translate(AppStringConstant.shippingMethod).toUpperCase() ??
                "",
            orderModel?.shippingMethod ?? "",
            isElevated: false),
        ],
      if(orderModel?.paymentMethod?.isNotEmpty==true)
        shippingPaymentMethodView(
            context,
            localizations?.translate(AppStringConstant.paymentMethods).toUpperCase() ?? "",
            orderModel?.paymentMethod ?? "",
            isElevated: false),
    ],
  );
}

Widget shippingPaymentMethodView(
    BuildContext context, String title, String address,
    {Widget? addressList,
      Widget? actions,
      bool? showDivider,
      bool? isElevated,
      VoidCallback? callback}) {
  return Card(
    elevation: (isElevated ?? true) ? AppSizes.linePadding : 0,
    child: Container(
      color: Theme.of(context).cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              title.toUpperCase(),
              style: KTextStyle.of(context).boldTwelve
                  ?.copyWith(color: AppColors.lightGray),
            ),
          ),
          if (showDivider ?? false)
            const Divider(
              thickness: 1,
              height: 1,
            ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: (callback != null) ? callback : null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Html(data:address)),
                // Text(address),
                if(callback != null) const Icon(Icons.navigate_next, color: AppColors.lightGray,)
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
