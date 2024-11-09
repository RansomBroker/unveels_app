/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/helper/utils.dart';

import '../../../configuration/unvells_theme.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/app_string_constant.dart';
import '../../../helper/app_localizations.dart';
import '../../../models/wishlist/wishlist_model.dart';
import '../bloc/wishlist_screen_bloc.dart';
import '../bloc/wishlist_screen_event.dart';
import '../bloc/wishlist_screen_state.dart';

Widget bottomWishlistButton(
    BuildContext context,
    List<WishlistData> items,
    bloc,
    bool? isLoading,
    /* Map<String, String> selectedWishlistProductList,*/
    VoidCallback onPressed,
    {String title = AppStringConstant.proceed}) {
  return Container(
    height: AppSizes.genericButtonHeight + 10,
    padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
    child: Row(
      children: [
        //  Expanded(
        //  flex: 1,
        //    child: InkWell(
        //      onTap: () {
        //      },
        //      child: Container(
        //        height: double.infinity,
        //        color: AppColors.black,
        //        child: Center(
        //            child: Text(
        //              Utils.getStringValue(context, AppStringConstant.updateWishList) .toUpperCase()??
        //                  '',
        //              style: const TextStyle(
        //                  color: AppColors.white, fontSize: 12),
        //            )),
        //      ),
        //    ),
        //  ),
        // SizedBox(width: 6,),
        Expanded(
          flex: 1,
          child: SizedBox(
            height: AppSizes.genericButtonHeight,
            child: ElevatedButton(
              onPressed: () async {
                onPressed();
              },
              child: Center(
                  child: Text(
                Utils.getStringValue(context, AppStringConstant.addAllToCart)
                        .toUpperCase() ??
                    '',
                style: const TextStyle(color: AppColors.white, fontSize: 12),
              )),
            ),
          ),
        ),
      ],
    ),

    /*Row(
      children: <Widget>[
        Expanded(
          child: InkWell(
            onTap: () async {

            },
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                Utils.getStringValue(
                    context, AppStringConstant.updateWishList.localized()),
                style: /*Theme.of(context).textTheme.bodyLarge,*/
                    const TextStyle(
                        fontSize: AppSizes.textSizeMedium,
                        color: AppColors.textColorPrice),
              ),
            ],
          ),
          )
        ),
        const SizedBox(
          width: 1,
          height: AppSizes.bottomWishlistVertical,
          child: Divider(
            height: AppSizes.bottomWishlistVertical,
            thickness: AppSizes.size40,
            // color: AppColors.black,
          ),
        ),
        Expanded(

            child: InkWell(
          onTap: () async {
            bloc?.emit(WishlistActionState());
            bloc?.add(const MoveAllToCartEvent(""));
              //  /* items?[index]
              //                                                                   .productId ??
              //                                                               "",
              //                                                           "1",
              //                                                           "[]"*/

          },
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                Utils.getStringValue(
                    context, AppStringConstant.addAllToCart.localized()),
                style: /*Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: AppSizes.textSizeMedium),*/
                    const TextStyle(
                        fontSize: AppSizes.textSizeMedium,
                        color: AppColors.textColorPrice),
              ),
            ],
          ),
        ))
      ],
    ),*/
  );
}
