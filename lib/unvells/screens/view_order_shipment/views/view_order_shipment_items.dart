/*
 *
  

 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/utils.dart';
import '../../../constants/app_constants.dart';
import '../../../models/invoice_view/invoice_view_model.dart';
import '../../../models/shipment_view/shipment_view_model.dart';

Widget ViewOrderShipmentItems(
    BuildContext context, ItemShipmentListData? item) {
  Widget getListItem(String? key, String? value) {
    return Row(
      children: [
        Expanded(child: Text(key!, textAlign: TextAlign.start)),
        const Text(" - "),
        Expanded(
            child: Text(
          value!,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.headlineSmall,
        )),
      ],
    );
  }

  return Padding(
    padding: const EdgeInsets.only(bottom:10.0),
    child: Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.size8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: AppSizes.size8,
            ),
            Text(item?.name ?? '',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textColorPrimary,
                    fontSize: AppSizes.textSizeMedium)),
            const SizedBox(
              height: AppSizes.size8,
            ),
            getListItem(
                Utils.getStringValue(
                    context, AppStringConstant.skuShipmentDetails),
                item?.sku?.toString()),
            const SizedBox(
              height: AppSizes.size8,
            ),
            getListItem(
                Utils.getStringValue(context, AppStringConstant.qtyShipped),
                item?.qty?.toString()),
            const SizedBox(
              height: AppSizes.size8,
            ),
          ],
        ),
      ),
    ),
  );
}
