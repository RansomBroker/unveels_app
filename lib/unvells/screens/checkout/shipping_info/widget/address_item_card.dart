/*
 *
  

 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/constants/app_constants.dart';

import '../../../../configuration/unvells_theme.dart';

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
      Text(
        title.toUpperCase(),
        style: KTextStyle.of(context).boldSixteen,
      ),
      if (showDivider ?? false)
        const Divider(
          thickness: 0,
          color: AppColors.white,
          height: 1,
        ),
      const SizedBox(
        height: 16,
      ),
      addressList ??
          addressItemCard(address, context,
              actions: actions, isElevated: isElevated, callback: callback)
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

Widget actionContainer(
  BuildContext context,
  VoidCallback leftCallback,
  VoidCallback rightCallback, {
  IconData? iconLeft,
  IconData? iconRight,
  String? titleLeft,
  String? titleRight,
  bool? isNewAddress,
  bool? hasAddress = true,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: AppSizes.size8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if (hasAddress ?? false)
          SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width / 2.5,
              child: OutlinedButton(
                onPressed: leftCallback,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      iconLeft ?? Icons.edit,
                      size: AppSizes.size16,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    const SizedBox(
                      width: AppSizes.linePadding,
                    ),
                    Text((titleLeft ?? '').toUpperCase(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.outline,
                            fontSize: AppSizes.textSizeTiny))
                  ],
                ),
              )),
        if (isNewAddress ?? false)
          SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width / 2.5,
              child: OutlinedButton(
                onPressed: rightCallback,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      iconRight ?? Icons.add,
                      size: AppSizes.size16,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    const SizedBox(
                      width: AppSizes.linePadding,
                    ),
                    Text(
                        // _localizations?.translate(AppStringConstant.newAddress) ??
                        (titleRight ?? "").toUpperCase(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.outline,
                            fontSize: AppSizes.textSizeTiny))
                  ],
                ),
              )),
      ],
    ),
  );
}
