/*
 *


 *
 * /
 */

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_new/unvells/models/downloadable_products/downloadable_products_list_model.dart';

import '../../../app_widgets/app_alert_message.dart';
import '../../../app_widgets/app_dialog_helper.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/app_string_constant.dart';
import '../../../helper/app_localizations.dart';
import '../../../helper/utils.dart';
import '../../../models/download_product/download_product.dart';
import '../../../network_manager/download_file.dart';
import '../../product_detail/widgets/file_download.dart';

Widget downloadProductItem(
    BuildContext context, DownloadableProductsListData? item, ValueChanged<String>? callBack) {
  Widget getListItem(String key, String value) {
    return Row(
      children: [
        Expanded(child: Text(key)),
        const Text(":"),
        Expanded(
            child: Text(
          value,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge,
        )),
      ],
    );
  }

  IconData? iconLeft;
  String? titleLeft;

  return Container(
    padding: const EdgeInsets.only(
        top: AppSizes.size8, left: AppSizes.size8, right: AppSizes.size8),
    margin: const EdgeInsets.only(bottom: AppSizes.size8),
    color: Theme.of(context).cardColor,
    child: Card(
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
                    Text(
                      "#${item?.incrementId.toString() ?? " "}",
                      // style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: AppSizes.textSizeLarge, color: AppColors.textColorPrimary),
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          // color: AppColors.textColorPrimary,
                          fontSize: AppSizes.textSizeLarge),
                    ),
                    const SizedBox(
                      height: AppSizes.linePadding,
                    ),
                    Text(
                      item?.proName.toString() ?? " ",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          // color: AppColors.textColorPrimary,
                          fontSize: AppSizes.textSizeMedium),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        AppRoutes.orderDetail,
                        arguments: item?.incrementId.toString(),
                      );
                    },
                    icon: Icon(Icons.navigate_next,
                      color: Theme.of(context).colorScheme.onPrimary,

                    )),
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

            Text(item?.date.toString() ?? " ",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    // color: AppColors.lightGray,
                    fontSize: AppSizes.textSizeSmall)),

            const SizedBox(
              height: AppSizes.size6,
            ),

            // statusContainer(context, item?.status ?? '', item?.statusColorCode ?? ''),

            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.spacingGeneric,
                  vertical: AppSizes.spacingTiny),
              decoration: BoxDecoration(
                  color: Utils.orderStatusBackground(item!.state.toString(), item.statusColorCode.toString()),
                  borderRadius: BorderRadius.circular(4)
              ),
              child: Text(
                item.status?.toUpperCase() ?? "",
                style: const TextStyle(color: AppColors.white, fontSize: AppSizes.textSizeSmall),
              ),
            ),

            const SizedBox(
              height: AppSizes.size14,
            ),

            Text(
              '${Utils.getStringValue(context, AppStringConstant.remainingDownloads)} ${item?.remainingDownloads}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  // color: AppColors.textColorPrimary,
                  fontSize: AppSizes.textSizeMedium),
            ),

            const SizedBox(
              height: AppSizes.size16,
            ),

            const Divider(
              thickness: 1,
              height: 1,
            ),

            const SizedBox(
              height: AppSizes.size8,
            ),

            InkWell(
              onTap: () async{
                if (callBack != null) {
                  callBack!(item?.hash??'');
                }

            },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    iconLeft ?? Icons.download,
                    size: AppSizes.size20 ,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  const SizedBox(
                    width: AppSizes.paddingGeneric,
                  ),
                  Text(
                      (Utils.getStringValue(context, AppStringConstant.download) ?? '').toUpperCase(),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                       color: AppColors.textColorPrimary,
                        fontSize: AppSizes.textSizeMedium),
                  )
                ],
              )
            ),

            const SizedBox(
              height: AppSizes.size8,
            ),

          ],
        ),
      ),
    ),
  );
}

Widget statusContainer(BuildContext context, String status, String statusColorCode) {
  return Container(
    color: Utils.orderStatusBackground(status, statusColorCode),
    padding: const EdgeInsets.symmetric(
        vertical: AppSizes.size8 / 2, horizontal: AppSizes.size8),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
            child: Text(
              status.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: AppColors.white, fontSize: AppSizes.textSizeMedium),
            )),
      ],
    ),
  );
}

