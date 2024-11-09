/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../constants/app_constants.dart';

Widget addressItemWithHeading(
    BuildContext context, String title, String address,
    {Widget? addressList,
    Widget? actions,
    bool? showDivider,
    bool? isElevated,
    VoidCallback? callback}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          title.toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: AppColors.lightGray),
        ),
      ),
      if (showDivider ?? false)
        const Divider(
          thickness: 1,
          height: 1,
        ),
      addressList ??
          addressItemCard(address, context,
              actions: actions, isElevated: isElevated, callback:callback ,showSelector: false)
    ],
  );
}

Widget addressItemCard(String address, BuildContext context,
    {Widget? actions,
      bool? isElevated,
      VoidCallback? callback,
      bool? isSelected = true,
      bool showSelector = true}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      if ((address ?? "").isNotEmpty)
        Container(
          decoration: ShapeDecoration(
            color: const Color(0xFFF5F5F5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          padding: const EdgeInsets.all(AppSizes.size16),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: (callback != null) ? callback : null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showSelector) ...[
                  isSelected == true
                      ? const Padding(
                    padding: EdgeInsets.only(top: 7.0),
                    child: Icon(
                      Icons.radio_button_checked,
                      color: AppColors.gold,
                    ),
                  )
                      : const Padding(
                    padding: EdgeInsets.only(top: 7.0),
                    child: Icon(
                      Icons.radio_button_off,
                      color: Color(0xffDCDCDC),
                    ),
                  ),
                ],
                Flexible(
                    child: Html(
                      data: address,
                      style: {
                        "body": Style(
                          color: const Color(0xFF212529),
                          fontSize: FontSize(14),
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w400,
                          // height: 0,
                        ),
                      },
                    )),
                if (callback != null)
                  const Icon(
                    Icons.navigate_next,
                    color: AppColors.lightGray,
                  )
              ],
            ),
          ),
        ),
      // if ((address ?? "").isNotEmpty)
      //   const Divider(
      //     thickness: 0.5,
      //     height: 0.5,
      //   ),
      if (actions != null) actions,
    ],
  );
}