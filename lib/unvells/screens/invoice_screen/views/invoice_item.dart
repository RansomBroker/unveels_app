/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/helper/bottom_sheet_helper.dart';
import 'package:test_new/unvells/models/order_details/order_detail_model.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/app_string_constant.dart';
import '../../../helper/utils.dart';

import '../../product_detail/widgets/file_download.dart';

Widget invoiceItem(BuildContext context, InvoiceListData? item, Function downloadInvoice,
    String orderIncrementId) {
  IconData? iconLeft;
  return Container(
    padding: const EdgeInsets.only(
        top: AppSizes.size8, left: AppSizes.size8, right: AppSizes.size8),
    margin: const EdgeInsets.only(bottom: AppSizes.size8),
    color: Theme.of(context).cardColor,
    child: Padding(
      padding: const EdgeInsets.all(AppSizes.size8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(Utils.getStringValue(context, AppStringConstant.invoice),
                      style: Theme.of(context).textTheme.bodySmall
                  ),
                  Text("#${item?.incrementId.toString() ?? " "}",
                      // style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: AppSizes.textSizeLarge, color: AppColors.textColorPrimary),
                      style: Theme.of(context).textTheme.displayMedium

                  ),
                  const SizedBox(
                    height: AppSizes.linePadding,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: AppSizes.size16,
          ),
          const Divider(
            thickness: 1,
            height: 1,
          ),
          const SizedBox(
            height: AppSizes.size16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                // width: MediaQuery.of(context).size.width / 2.5,
                height: AppSizes.genericButtonHeight,
                child: OutlinedButton(
                  onPressed: () {
                    viewInvoiceBottomModelSheet(context, item?.id.toString(),
                        orderIncrementId.toString());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        iconLeft ?? Icons.view_carousel,
                        size: AppSizes.size20,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      const SizedBox(
                        width: AppSizes.paddingGeneric,
                      ),
                      Text(
                        (Utils.getStringValue(
                            context, AppStringConstant.viewInvoice) ??
                            '')
                            .toUpperCase(),
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                            fontSize: AppSizes.textSizeSmall),
                      )
                    ],

                    // ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                // width: MediaQuery.of(context).size.width / 2.5,
                height: AppSizes.genericButtonHeight,
                child: OutlinedButton(
                    onPressed: () async {
                      downloadInvoice();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          iconLeft ?? Icons.save_alt,
                          size: AppSizes.size20,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        const SizedBox(
                          width: AppSizes.paddingGeneric,
                        ),
                        Text(
                          (Utils.getStringValue(
                              context, AppStringConstant.saveInvoice) ??
                              '')
                              .toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                              color: Theme.of(context).colorScheme.outline,
                              fontSize: AppSizes.textSizeSmall),
                        )
                      ],
                    )),
              )
            ],
          ),
          const SizedBox(
            height: AppSizes.size8,
          ),
        ],
      ),
    ),
    // ),
  );
}
