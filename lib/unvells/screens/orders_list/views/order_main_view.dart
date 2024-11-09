/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/app_widgets/custom_button.dart';
import 'package:test_new/unvells/app_widgets/dialog_helper.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/screens/orders_list/bloc/order_screen_bloc.dart';
import 'package:test_new/unvells/screens/orders_list/bloc/order_screen_events.dart';

import '../../../app_widgets/image_view.dart';
import '../../../configuration/unvells_theme.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_routes.dart';
import '../../../helper/app_localizations.dart';
import '../../../helper/bottom_sheet_helper.dart';
import '../../../models/order_list/order_list_model.dart';
import '../bloc/order_screen_state.dart';

Widget orderMainView(
    BuildContext context,
    List<OrderListData>? orders,
    AppLocalizations? localizations,
    Function(String orderId) reorderCallback,
    Function(String orderId) reviewCallback,
    ScrollController controller,
    {ScrollPhysics scrollPhysics = const AlwaysScrollableScrollPhysics()}) {
  return ListView.separated(
    controller: controller,
    shrinkWrap: true,
    physics: scrollPhysics,
    itemBuilder: (ctx, index) => orderItem(context, orders?[index],
        localizations, reorderCallback, reviewCallback),
    separatorBuilder: (ctx, index) => const SizedBox(
      height: 10.0,
    ),
    itemCount: (orders?.length ?? 0),
  );
}

Widget orderItem(
    BuildContext context,
    OrderListData? item,
    AppLocalizations? localizations,
    Function(String) reorderCallback,
    Function(String) reviewCallback) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CoulmnTextValue(
                      title:
                          localizations?.translate(AppStringConstant.orderId) ??
                              '',
                      value: "#${item?.orderId.toString()}" ?? '',
                    ),
                    const SizedBox(height: AppSizes.size16),
                    CoulmnTextValue(
                      title: localizations
                              ?.translate(AppStringConstant.orderDate) ??
                          '',
                      value: "${item?.date.toString()}" ?? '',
                    ),
                  ],
                ),
                const Spacer(
                  flex: 1,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CoulmnTextValue(
                      title: localizations
                              ?.translate(AppStringConstant.orderStatus) ??
                          '',
                      value: "${item?.status.toString()}" ?? '',
                      valueColor: Utils.orderStatusBackground(
                          item?.status ?? '', item?.statusColorCode ?? ''),
                    ),
                    const SizedBox(height: AppSizes.size16),
                    CoulmnTextValue(
                      title: localizations
                              ?.translate(AppStringConstant.orderTotal) ??
                          '',
                      value: "${item?.orderTotal.toString()}" ?? '',
                    ),
                  ],
                ),
                const Spacer(
                  flex: 1,
                )
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSizes.size20),
        // Text(
        //   "${localizations?.translate(AppStringConstant.items)} (${item?.itemCount})" ??
        //       '',
        //   style: KTextStyle.of(context)
        //       .semiTwelve
        //       .copyWith(color: const Color(0xff868E96)),
        // ),
        // Text(localizations?.translate(AppStringConstant.details)??'',style: KTextStyle.of(context).twelve.copyWith(color: AppColors.gold),),
        // SizedBox(
        //   height: AppSizes.deviceWidth / 3,
        //   width: AppSizes.deviceWidth / 3,
        //   child: ImageView(
        //     url: item?.itemImageUrl,
        //   ),
        // ),
        // const SizedBox(height: AppSizes.size4),
        // const SizedBox(width: AppSizes.paddingGeneric),
        actionContainer(
          context,
          () {
            Navigator.of(context).pushNamed(
              AppRoutes.orderDetail,
              arguments: item?.orderId.toString() ?? "",
            );
          },
          () {
            reorderCallback(item?.orderId ?? '');
          },
          () {
            reviewCallback(item?.orderId ?? '');
          },
          titleLeft:
              localizations?.translate(AppStringConstant.details).toUpperCase(),
          titleCenter:
              localizations?.translate(AppStringConstant.reorder).toUpperCase(),
          titleRight:
              localizations?.translate(AppStringConstant.review).toUpperCase(),
          iconLeft: Icons.view_array_outlined,
          iconCenter: Icons.repeat,
          iconRight: Icons.reviews_outlined,
        ),
        const SizedBox(height: AppSizes.size8),
      ],
    ),
  );
}

class CoulmnTextValue extends StatelessWidget {
  const CoulmnTextValue(
      {super.key, required this.title, required this.value, this.valueColor});

  final String title;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: KTextStyle.of(context)
                .semiTwelve
                .copyWith(color: const Color(0xff868E96))
            // ?.copyWith(fontSize: AppSizes.textSizeMedium, color: AppColors.textColorSecondary)
            ),
        const SizedBox(height: AppSizes.size4),
        Text(value,
            style: KTextStyle.of(context)
                .semiBoldSixteen
                .copyWith(color: valueColor)),
      ],
    );
  }
}

Widget statusContainer(
    BuildContext context, String status, String statusColorCode) {
  return Container(
    decoration: BoxDecoration(
        color: Utils.orderStatusBackground(status, statusColorCode),
        borderRadius: BorderRadius.circular(AppSizes.size4)),
    padding: const EdgeInsets.symmetric(
        vertical: AppSizes.size8 / 2, horizontal: AppSizes.size8),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
            child: Text(
          status.toUpperCase(),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.white, fontSize: AppSizes.textSizeMedium),
        )),
      ],
    ),
  );
}

//==Todo change with address card
Widget actionContainer(BuildContext context, VoidCallback leftCallback,
    VoidCallback centerCallback, VoidCallback rightCallback,
    {IconData? iconLeft,
    IconData? iconCenter,
    IconData? iconRight,
    String? titleLeft,
    String? titleCenter,
    String? titleRight}) {
  return Row(
    children: [
      Expanded(
        flex: 2,
        child: CustomButton(
          hieght: 40,
          onPressed: leftCallback,
          title: titleLeft??'',
          // child: Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     Icon(
          //       iconLeft ?? Icons.view_array_outlined,
          //       size: AppSizes.size16,
          //       color: AppColors.white,
          //     ),
          //     const SizedBox(
          //       width: AppSizes.size4,
          //     ),
          //     Text(
          //       (titleLeft ?? '').toUpperCase(),
          //       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          //             fontWeight: FontWeight.bold,
          //             color: AppColors.white,
          //           ),
          //     ),
          //   ],
          // ),
        ),
      ),
      Spacer(
        flex: 1,
      ),
      Expanded(
        flex: 2,
        child: CustomButton(

          hieght: 40,
          onPressed: centerCallback,
          title: titleCenter??'',
          kFillColor: AppColors.gold,
          // child: Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     Icon(
          //       iconCenter ?? Icons.repeat,
          //       size: AppSizes.size16,
          //       color: AppColors.white,
          //     ),
          //     const SizedBox(
          //       width: AppSizes.size4,
          //     ),
          //     Text(
          //       (titleCenter ?? '').toUpperCase(),
          //       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          //             fontWeight: FontWeight.bold,
          //             color: AppColors.white,
          //           ),
          //     ),
          //   ],
          // ),
        ),
      ),
      // Expanded(
      //   flex: 1,
      //   child: Container(
      //     height: 40,
      //     margin: const EdgeInsets.only(
      //         left: AppSizes.spacingTiny, right: AppSizes.spacingTiny),
      //     decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(8),
      //       color: Theme.of(context).buttonTheme.colorScheme?.background,
      //       border:
      //           Border.all(color: Theme.of(context).dividerColor, width: 1),
      //     ),
      //     child: InkWell(
      //       onTap: rightCallback,
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: <Widget>[
      //           Icon(
      //             iconRight ?? Icons.reviews_outlined,
      //             size: AppSizes.size16,
      //             color: AppColors.white,
      //           ),
      //           const SizedBox(
      //             width: AppSizes.size4,
      //           ),
      //           Text(
      //             (titleRight ?? '').toUpperCase(),
      //             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
      //                   fontWeight: FontWeight.bold,
      //                   color: AppColors.white,
      //                 ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    ],
  );
}
