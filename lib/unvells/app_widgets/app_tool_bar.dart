
/*
 *


 *
 * /
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_new/unvells/helper/app_storage_pref.dart';

import '../configuration/text_theme.dart';
import '../constants/app_constants.dart';
import 'image_view.dart';

AppBar appToolBar(String heading, BuildContext context,
    {bool isHomeEnable = false,
      bool isElevated = true,
      bool isLeadingEnable = false,
      List<Widget>? actions,
      VoidCallback? onPressed}) {
  print("TEST__LOG${appStoragePref.getAppLogo()}");
  return AppBar(
    // backgroundColor: Theme.of(context).cardColor,
      leading: isLeadingEnable
          ? IconButton(
          onPressed: () {
            isLeadingEnable ? Navigator.pop(context) : onPressed!();
          },
          icon: const Icon(Icons.clear))
          : null,
      elevation: isElevated ? null : 0,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isHomeEnable)
            SizedBox(
              height: AppBar().preferredSize.height / 2,
              width: AppBar().preferredSize.height / 2,
              child: appStoragePref.getAppLogo().isEmpty?
              Image.asset(
                AppImages.appIcon,
                fit: BoxFit.fill,
              ) :
              CachedNetworkImage(
                imageUrl: appStoragePref.getAppLogo() ?? "",
                placeholder: (context, url) => Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        AppImages.placeholder,
                      ),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        AppImages.placeholder,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: isHomeEnable ? AppSizes.spacingGeneric : 0),
            child: Text(
              heading,
              style: KTextStyle.of(context).boldSixteen,
            ),
          ),
        ],
      ),
      actions: actions);
}
