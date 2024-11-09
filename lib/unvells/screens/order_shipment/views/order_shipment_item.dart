/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/configuration/unvells_theme.dart';
import 'package:test_new/unvells/helper/bottom_sheet_helper.dart';
import 'package:test_new/unvells/models/downloadable_products/downloadable_products_list_model.dart';
import 'package:test_new/unvells/models/order_details/order_detail_model.dart';

import '../../../app_widgets/app_dialog_helper.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/app_string_constant.dart';
import '../../../helper/app_localizations.dart';
import '../../../helper/utils.dart';
import '../../../models/shipment_view/shipment_view_model.dart';
import '../../../network_manager/download_file.dart';

Widget OrderShipmentItem(
  BuildContext context,
  ShipmentListData? item,
) {
  IconData? iconLeft;

  return Container(
    padding: const EdgeInsets.only(
        top: AppSizes.size8, left: AppSizes.size8, right: AppSizes.size8),
    margin: const EdgeInsets.only(bottom: AppSizes.size8),
    color: Theme.of(context).cardColor,
    // child: Card(
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
                    Utils.getStringValue(context, AppStringConstant.shipment),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        // color: AppColors.textColorPrimary,
                        fontSize: AppSizes.textSizeMedium),
                  ),
                  Text(
                    "#${item?.incrementId.toString() ?? " "}",
                    // style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: AppSizes.textSizeLarge, color: AppColors.textColorPrimary),
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: AppColors.textColorPrimary,
                        fontSize: AppSizes.textSizeLarge),
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

          //            child: InkWell(
          //               onTap: leftCallback,
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              height: AppSizes.genericButtonHeight,
              // width: MediaQuery.of(context).size.width / 2.5,
              padding: const EdgeInsets.all(5),
              child: OutlinedButton(
                  onPressed: () {
                    viewShipmentBottomModelSheet(context,
                        item?.incrementId.toString(), item?.id?.toString());
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
                                    context, AppStringConstant.viewShipment) ??
                                '')
                            .toUpperCase(),
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                            fontSize: AppSizes.textSizeSmall),
                      )
                    ],
                  )
                  // ),

                  ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              // width: MediaQuery.of(context).size.width / 2.5,

              height: AppSizes.genericButtonHeight,
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.orderTrack,
                      arguments: item?.id?.toString() ?? "",
                    );

                    // AppDialogHelper.informationDialog(
                    //   "${shipmentViewModel.trackingData?[0].title} ${shipmentViewModel.trackingData?[0].number}",
                    //   context,
                    //   AppLocalizations.of(context),
                    //   onConfirm: (){
                    //      Navigator.pop(context);
                    //   },
                    //   title: AppStringConstant.trackingInformation,
                    // );
                    // AppDialogHelper.shipmentTrackDialog(context, shipmentViewDataModel?.trackingData,
                    //     onConfirm: () async {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          iconLeft ?? Icons.location_on_outlined,
                          size: AppSizes.size20,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        const SizedBox(
                          width: AppSizes.paddingGeneric,
                        ),
                        Text(
                          (Utils.getStringValue(
                                      context, AppStringConstant.track) ??
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
                    ),
                  )
                  // ),
                  ),
            )
          ]),

          const SizedBox(
            height: AppSizes.size8,
          ),
        ],
      ),
    ),
    // ),
  );
}
