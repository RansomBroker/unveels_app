/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/helper/app_localizations.dart';
import 'package:test_new/unvells/helper/app_storage_pref.dart';
import 'package:test_new/unvells/helper/bottom_sheet_helper.dart';
import 'package:test_new/unvells/helper/utils.dart';
import '../../../app_widgets/image_view.dart';
import '../../../app_widgets/rating_bar.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/app_string_constant.dart';
import '../../../models/deliveryBoyDetails/delivery_boy_details_model.dart';
import '../../../models/order_details/order_detail_model.dart';
import '../../../models/productDetail/product_detail_page_model.dart';
import 'order_item_card.dart';

class ItemAssignedDeliveryBoy extends StatelessWidget {
  const ItemAssignedDeliveryBoy(this.deliveryBoys, this.localizations, this._orderModel,
      {Key? key})
      : super(key: key);

  final AssignedDeliveryBoyDetails? deliveryBoys;
  final AppLocalizations? localizations;
  final OrderDetailModel? _orderModel;


  @override
  Widget build(BuildContext context) {
    bool isVisibleRating = false;
    if (_orderModel?.state == "complete" ) {
      isVisibleRating = true;
    } else {
      isVisibleRating = false;
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.size12),
      child: InkWell(
        onTap: () {},
        child: Container(
          color: Theme.of(context).cardColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: AppSizes.spacingNormal,
              ),
              Text(
                deliveryBoys!.products![0] ?? "",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: AppSizes.textSizeMedium,
                    color: AppColors.textColorPrimary),
              ),
              const SizedBox(
                height: AppSizes.spacingLarge,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 35,
                    child: ClipOval(
                        child: ImageView(
                          url: deliveryBoys!.avatar ?? "",
                        )),
                  ),
                  const SizedBox(
                    height: AppSizes.spacingNormal,
                    width: AppSizes.spacingNormal,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        deliveryBoys!.name ?? "",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: AppSizes.textSizeMedium,
                            color: AppColors.textColorSecondary),
                      ),
                      const SizedBox(
                        height: AppSizes.spacingTiny,
                      ),
                      Text(
                        '${localizations?.translate(AppStringConstant.otpCode)}: ${deliveryBoys!.otp}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: AppSizes.textSizeMedium,
                            color: AppColors.textColorPrimary,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: AppSizes.spacingTiny,
                      ),
                      Text(
                        '${localizations?.translate(AppStringConstant.contact)}: ${deliveryBoys!.mobileNumber}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: AppSizes.textSizeMedium,
                            color: AppColors.textColorSecondary),
                      ),
                      const SizedBox(
                        height: AppSizes.spacingTiny,
                      ),
                      Text(
                        '${localizations?.translate(AppStringConstant.vehicleNumber)}: ${deliveryBoys!.vehicleNumber}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: AppSizes.textSizeMedium,
                            color: AppColors.textColorSecondary),
                      ),
                    ],
                  ),

                  Align(alignment: Alignment.topRight,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star,
                          size: AppSizes.size16,
                          color: AppColors.black,
                        ),
                        const SizedBox(
                          width: AppSizes.size4,
                        ),
                        Text(
                          deliveryBoys?.rating?.toString() ?? "",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: AppSizes.textSizeMedium,
                              color: AppColors.textColorSecondary),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
              const SizedBox(
                height: AppSizes.spacingGeneric,
              ),
              Visibility(
                visible: _orderModel?.state != "complete",
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.spacingTiny),
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigator.pushNamed(context, AppRoutes.deliveryboyHelpChatScreen/*,arguments: getSellerData(mSellerList?[index]?.customerToken ??'', mSellerList?[index]?.name ?? '', mSellerList?[index]?.token ?? '')*/);

                              Navigator.pushNamed(context, AppRoutes.deliveryboyHelpChatScreen,arguments: deliveryBoys);


                            },
                            child: Text(localizations
                                ?.translate(AppStringConstant.help)
                                .toUpperCase() ??
                                "",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: AppSizes.textSizeMedium,
                                    color: AppColors.white)),
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.spacingTiny),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.deliveryboyTrackScreen,
                                arguments: deliveryBoys,
                              );
                            },
                            child: Text(localizations
                                ?.translate(AppStringConstant.track)
                                .toUpperCase() ??
                                "",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: AppSizes.textSizeMedium,
                                    color: AppColors.white)),
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: AppSizes.spacingNormal,
              ),

              Visibility(
                  visible: isVisibleRating,
                  child: Container(
                      width: AppSizes.deviceWidth,
                      decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(AppSizes.paddingMedium),
                              topRight: Radius.circular(AppSizes.paddingMedium)),
                          border: Border.all(color: Theme.of(context).cardColor)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${localizations?.translate(AppStringConstant.deliveryBoyRating)}',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontSize: AppSizes.textSizeMedium,
                                  color: AppColors.textColorSecondary),
                            ),
                            const SizedBox(
                              height: AppSizes.spacingNormal,
                            ),
                            const Divider(
                              thickness: 1,
                              height: 1,
                            ),
                            const SizedBox(
                              height: AppSizes.spacingNormal,
                            ),
                            itemAddReview(() {
                              deliveryboyReviewBottomModalSheet(context,
                                  "${deliveryBoys!.id}",
                                  deliveryBoys!.customerId ?? 0,
                                  deliveryBoys, _orderModel!.incrementId ?? "");
                            }, '${localizations?.translate(AppStringConstant.writeAreviewForDeliveryBoy)}', context),

                          ])
                  )
              ),

            ],
          ),
        ),
      ),
    );
  }
}
