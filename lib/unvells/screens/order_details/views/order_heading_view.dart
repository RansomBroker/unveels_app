/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';

import '../../../constants/app_constants.dart';

Widget orderHeaderLayout(BuildContext context, String heading, Widget child) {
  return Container(
    color: Theme.of(context).cardColor,
    width: AppSizes.deviceWidth,
    padding: const EdgeInsets.symmetric(vertical: AppSizes.paddingMedium),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              heading.toUpperCase(),
              style:  KTextStyle.of(context).sixteen,
            ),
            const SizedBox(
              height: AppSizes.spacingNormal,
            ),
            const Divider(
              thickness: 1,
              height: 1,
            ),
          ],
        ),
        child
      ],
    ),
  );
}