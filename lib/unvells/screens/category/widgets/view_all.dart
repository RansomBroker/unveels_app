/*
 *


 *
 * /
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_new/unvells/configuration/unvells_theme.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/helper/utils.dart';

import '../../../constants/app_string_constant.dart';
import '../../../helper/generic_methods.dart';

Widget viewAllButton(BuildContext context, GestureTapCallback onClick) {
  return InkWell(
    onTap: onClick,
    child: Text(
        Utils.getStringValue(
            context, AppStringConstant.viewAll)
            ,
        style: KTextStyle.of(context).boldTwelve.copyWith(color: AppColors.gold)),
  );
}
