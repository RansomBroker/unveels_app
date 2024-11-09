/*
 *
  

 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/app_localizations.dart';

Widget advanceSearchContainer(BuildContext context, VoidCallback callback) {
  var isDarkMode =
      SchedulerBinding.instance!.window.platformBrightness == Brightness.dark;
  return InkWell(
    onTap: callback,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.size8),
      color: Theme.of(context).colorScheme.onPrimary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.search,
            color: isDarkMode ? AppColors.black : AppColors.white,
          ),
          const SizedBox(width: AppSizes.size8),
          Text(
            AppStringConstant.advanceSearchTitle.localized().toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: isDarkMode ? Colors.black : Colors.white),
          )
        ],
      ),
    ),
  );
}
