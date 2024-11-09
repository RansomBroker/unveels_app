/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/app_widgets/custom_button.dart';

import '../configuration/unvells_theme.dart';
import '../constants/app_constants.dart';
import '../constants/app_string_constant.dart';
import '../helper/app_localizations.dart';

Widget commonOrderButton(BuildContext context, AppLocalizations? _localizations,
    String amount, VoidCallback onPressed,
    {Color color = Colors.white, String title = AppStringConstant.proceed}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20.0,right: 20.0,bottom: 49),
    child: CustomButton(
      onPressed: onPressed,
      title:
        (_localizations?.translate(title) ?? "").toUpperCase(),

    ),
  );
}
