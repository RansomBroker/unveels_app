/*
 *
  

 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/helper/utils.dart';

import '../../../models/homePage/home_page_banner.dart';

Widget BannerWidget(BuildContext context, List<Banners>? bannerList) {
  List<Widget> x = [];
  bannerList?.forEach((value) {
    x.add(GestureDetector(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(AppSizes.size8),
          height: AppSizes.deviceWidth / 2 + 80,
          width: AppSizes.deviceWidth,
          child: Image.network(
            value.url?? value.bannerImage?? ""!!,
            fit:BoxFit.fill,
            filterQuality: FilterQuality.high,
            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
              return Container(
                  margin: const EdgeInsets.all(AppSizes.size4),
                  color: Color(
                      Utils.getColor( value.dominantColor!!)));
            },
            loadingBuilder: (BuildContext ctx, Widget child, ImageChunkEvent? loadingProgress) {
              if (loadingProgress != null) {
                return Container(
                    margin: const EdgeInsets.all(AppSizes.size4),
                    color: Color(
                        Utils.getColor( value.dominantColor!!)));
              }
              return child;
            },
          ),
        )));
  });
  return Container(
    height: AppSizes.deviceWidth / 2 + 62,
    child: ListView(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: x.isNotEmpty ? Axis.horizontal : Axis.vertical,
      children: x,
    ),
  );
}
