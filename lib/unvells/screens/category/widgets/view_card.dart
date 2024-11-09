/*
 *
  

 *
 * /
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../app_widgets/image_view.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/app_string_constant.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/utils.dart';

class ViewCard extends StatelessWidget {
  int? categoryId;
  String categoryName;
  ViewCard(this.categoryId,this.categoryName, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return
      InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.catalog,
            arguments: getCatalogMap(
              categoryId.toString() ?? "",
              categoryName ?? "",
              BUNDLE_KEY_CATALOG_TYPE_CATEGORY,
              false,
            ));
      },
      child:
      Column(
        children: [
          Container(
            height: AppSizes.deviceWidth / 7,
            width: AppSizes.deviceWidth / 7,
            decoration:  const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.placeholder,)
              ),
            ),
          ),
          Text(
              Utils.getStringValue(context, AppStringConstant.viewAll),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: AppSizes.textSizeSmall))
        ],
      ),
    );
  }
}
