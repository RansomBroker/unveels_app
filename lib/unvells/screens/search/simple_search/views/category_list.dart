/*
 *
  

 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/utils.dart';

import '../../../../constants/app_routes.dart';
import '../../../../constants/arguments_map.dart';
import '../../../../models/categoryPage/category.dart';


Widget categoryList(BuildContext context, List<Category> ?data, Function callback,  ){
  return Container(
    color: Theme.of(context).cardColor,
    padding: EdgeInsets.all(8),
    // height: 120,

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(Utils.getStringValue(context, AppStringConstant.categories).toUpperCase() ?? '' ,
          style: KTextStyle.of(context).boldSixteen,
        ),
SizedBox(height: 8,),
        SizedBox(
          height: AppSizes.deviceHeight*.06,
          child: ListView.builder(
            // shrinkWrap: true,
              itemCount: data?.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    callback();
                    Navigator.pushNamed(context, AppRoutes.subCategory,
                        arguments: categoryMap(
                            data?[index].id??0, data?[index].name??"", ""));

                  },
                  child: Container(
                    margin: const EdgeInsets.only(right:AppSizes.size6, bottom: AppSizes.size16),
                  padding: const EdgeInsets.symmetric(vertical: AppSizes.size4, horizontal: AppSizes.size16),
                   decoration:  BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular( 5.0)),
                     color: AppColors.transparent,
                     border: Border.all(color: AppColors.gold,width: 2)
                    ),
                    child: Center(child: Text(data?[index].name??'', style: KTextStyle.of(context).boldSixteen,)),



                  ),
                );
              }),
        ),
      ],
    ),
  );
}


Widget commonContainer(BuildContext context, Widget child, {Color? color, Color? shadowColor, double? borderRadius , double? verticalPadding,double? horizontalPadding, double? verticalMargin,double? horizontalMargin, double? height, double? width,double? shadowBlurRadius }){
  return Container(
    padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 0, horizontal: horizontalPadding ?? verticalPadding ?? 0),
    margin: EdgeInsets.symmetric(vertical: verticalMargin ?? 0 , horizontal: horizontalMargin ?? verticalMargin ?? 0 ),
    height: height ,
    width: width ,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 8.0)),
        color: color,
        boxShadow:   [
          BoxShadow(
            color: shadowColor ?? Theme.of(context).cardColor,
            blurRadius: shadowBlurRadius ?? 0,
          )]
    ),
    child: child,
  );
}
