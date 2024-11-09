/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/constants/app_routes.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/app_storage_pref.dart';
import 'package:test_new/unvells/helper/utils.dart';

import '../../../app_widgets/app_outlined_button.dart';
import '../../../app_widgets/dialog_helper.dart';
import '../../../constants/app_constants.dart';
import '../../../helper/app_localizations.dart';
import '../../../models/productDetail/configurable_data.dart';
import '../bloc/product_detail_screen_bloc.dart';
import '../bloc/product_detail_screen_events.dart';


class ProductSizeColorView extends StatelessWidget {

  AppLocalizations? _localizations;
  ProductDetailScreenBloc? productPageBloc;
  String productId;
  ConfigurableData? data;



  ProductSizeColorView(this.productPageBloc, this.productId,this.data,
      {Key? key});


  @override
  Widget build(BuildContext context) {
    _localizations = AppLocalizations.of(context);
    return Container(
        color: Theme.of(context).cardColor,
        margin: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            Utils.getStringValue(context, AppStringConstant.size).toUpperCase(),
            style: Theme
                .of(context)
                .textTheme
                .titleSmall,
          ),
          SizedBox(
            height: AppSizes.size8,
          ),
          Divider(),
          SizedBox(
            height: AppSizes.size8,
          ),
          Column(
            children: [
              Container(
                child: Text(data?.attributes?[0].label??''),
              )
            ],
          ),
          Text(
            Utils.getStringValue(context, AppStringConstant.color).toUpperCase(),
            style: Theme
                .of(context)
                .textTheme
                .titleSmall,
          ),
          SizedBox(
            height: AppSizes.size8,
          ),
          Divider(),
          SizedBox(
            height: AppSizes.size8,
          ),
        ],
      )
      /*Row(
        children: [
          Expanded(
            flex: 1,
            child: appOutlinedButton(
              context,
                  () {
                productPageBloc?.add(AddtoCartEvent(false, productId.toString(), 1, ""));
              },

              Utils.getStringValue(context, AppStringConstant.addToCart) .toUpperCase()??
                  '',
              // style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          SizedBox(width: AppSizes.size2,),
          Expanded(
              flex: 1,
              child: appOutlinedButton(
                  context,
                      () {
                    productPageBloc?.add(AddtoCartEvent(true, productId.toString(), 1, ""));
                  },
                  Utils.getStringValue(context, AppStringConstant.buyNow).toUpperCase() ??
                      '',
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                  textColor: AppColors.white
              )),
        ],
      ),*/
    );
  }
}
