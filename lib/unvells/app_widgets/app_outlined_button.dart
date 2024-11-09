/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/configuration/unvells_theme.dart';
import '../constants/app_constants.dart';

Widget appOutlinedButton(
  BuildContext context,
  VoidCallback onPressed,
  String text, {
  double? width,
  double? height,
  Color? textColor,
  Color? backgroundColor,
  double borderRadius = 10,
}) {
  return SizedBox(
    height: AppSizes.genericButtonHeight,
    child: OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: Size((width != null) ? width : AppSizes.deviceWidth,
            (height != null) ? height : AppSizes.deviceHeight / 16),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge,
      ),
    ),
  );
}
