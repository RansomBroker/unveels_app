/*
 *


 *
 * /
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../app_widgets/image_view.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_string_constant.dart';
import '../../../helper/utils.dart';

class LanguageItemView extends StatelessWidget {
  String? cid;
  String categoryName;
  LanguageItemView(this.cid,this.categoryName, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        onTap: () {

        },
        child:
        Column(
          children: [
            ImageView(
              height: AppSizes.deviceHeight/10,
              width: AppSizes.deviceWidth/7,
            ),
            Text(
                Utils.getStringValue(context, AppStringConstant.viewAll),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: AppSizes.textSizeSmall))
          ],
        ),
      );
  }
}
