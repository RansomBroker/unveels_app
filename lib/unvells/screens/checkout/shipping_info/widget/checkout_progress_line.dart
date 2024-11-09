/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/configuration/unvells_theme.dart';

import '../../../../constants/app_constants.dart';

Widget checkoutProgressLine(bool isFromShipping, BuildContext context) {
  return Row(
    children: [
      Container(
        height: AppSizes.size4,
        width: AppSizes.deviceWidth / 2,
        color: Theme.of(context).iconTheme.color,
      ),
      Container(
        height: AppSizes.size4,
        width: AppSizes.deviceWidth / 2,
        color: isFromShipping
            ? AppColors.lightPrimaryColor1
            : Theme.of(context).iconTheme.color,
      )
    ],
  );
}
