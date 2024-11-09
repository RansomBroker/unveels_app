/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/app_string_constant.dart';
import '../../../helper/app_localizations.dart';
import '../../../helper/utils.dart';
import '../../../models/order_details/order_detail_model.dart';

Widget orderInvoiceShipmentViewContainer(BuildContext context,
    OrderDetailModel? orderModel, AppLocalizations? localization) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if ((orderModel?.invoiceList ?? []).isNotEmpty)
        InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.invoiceScreen,
                  arguments: orderModel);
            },
            child: Column(children: [
              Text(
                Utils.getStringValue(context, AppStringConstant.invoices),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: AppSizes.textSizeMedium),
              ),
              const SizedBox(
                height: AppSizes.paddingMedium,
              ),
            ])),
      if ((orderModel?.shipmentList ?? []).isNotEmpty)
        InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.orderShipment,
                arguments: orderModel,
              );
            },
            child: Column(children: [
              const SizedBox(
                height: AppSizes.paddingMedium,
              ),
              Text(
                Utils.getStringValue(context, AppStringConstant.orderShipment),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: AppSizes.textSizeMedium),
              ),
              const SizedBox(
                height: AppSizes.paddingMedium,
              ),
            ])),
      if ((orderModel?.creditmemoList ?? []).isNotEmpty)
        InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.refundScreen,
                arguments: orderModel,
              );
            },
            child: Column(children: [
              const SizedBox(
                height: AppSizes.paddingMedium,
              ),
              Text(
                Utils.getStringValue(context, AppStringConstant.refund),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: AppSizes.textSizeMedium),
              ),
              const SizedBox(
                height: AppSizes.paddingMedium,
              ),
            ])),
    ],
  );
}
