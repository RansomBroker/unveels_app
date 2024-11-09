/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';

import '../constants/app_constants.dart';



AppBar commonAppBar(String heading, BuildContext context,
    {bool isHomeEnable = false,
    bool isElevated = true,
    bool isLeadingEnable = false,
    List<Widget>? actions,
    Color? bgColor,
    VoidCallback? onPressed}) {
  return AppBar(
      backgroundColor:bgColor?? Colors.transparent,
      leading: isLeadingEnable
          ? IconButton(
              onPressed: () {
               Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios))
          : null,
      // leadingWidth: 3,
      elevation: isElevated ? null : 0,
      centerTitle: true,
      title: Text(
        heading,
        style: KTextStyle.of(context).boldSixteen,
        overflow: TextOverflow.ellipsis,
        softWrap: true,
      ),
      actions: actions);
}
