/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/app_widgets/flux_image.dart';
import 'package:test_new/unvells/app_widgets/image_view.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/constants/app_routes.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/app_localizations.dart';
import 'package:test_new/unvells/screens/cart/widgets/quantity_changer.dart';

import '../../../app_widgets/app_dialog_helper.dart';
import '../../../configuration/unvells_theme.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/app_storage_pref.dart';
import '../../../helper/utils.dart';
import '../../../models/cart/cart_item.dart';
import '../bloc/cart_screen_bloc.dart';
import '../bloc/cart_screen_event.dart';
import '../bloc/cart_screen_state.dart';

class CartProductItem extends StatelessWidget {
  const CartProductItem(this.product, this.localizations, this.bloc, {super.key});

  final CartItem? product;
  final AppLocalizations? localizations;
  final CartScreenBloc? bloc;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.productPage,
          arguments: getProductDataAttributeMap(
            product?.name ?? "",
            product?.productId ?? "",
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Image and qty dropdown
                SizedBox(
                  height: AppSizes.deviceWidth / 3.5,
                  width: AppSizes.deviceWidth / 3.5,
                  child: ImageView(
                    url: product?.image,
                  ),
                ),

                const SizedBox(width: AppSizes.size12),

                // Product Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(product?.name ?? "",
                          style: KTextStyle.of(context).semiBoldSixteen),
                      const SizedBox(height: AppSizes.size8),
                      if (product?.options?.isNotEmpty ?? false) ...[
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: product?.options?.length ?? 0,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                              "${product?.options?[index].label}:")),
                                      Expanded(
                                          flex: 1,
                                          child: Text(product
                                                  ?.options?[index].value?[0] ??
                                              '')),
                                      const Spacer(),
                                    ],
                                  ),
                                  const SizedBox(height: AppSizes.size8),
                                ],
                              );
                            }),
                        const SizedBox(height: AppSizes.size8),
                      ],

                      Text(product?.formattedFinalPrice ?? "0.00",
                          style: KTextStyle.of(context).sixteen),
                      const SizedBox(height: AppSizes.size16),

                      QuantityChanger((value) async {
                        if (value == 0) {
                          bloc?.add(RemoveCartItem(product?.id ?? ""));
                        } else {
                          bloc?.add(SetCartItemQuantityEvent(
                              product?.id ?? "", value));
                        }
                        bloc?.emit(CartScreenInitial());
                      }, product?.qty?.toInt()
                          // product?.
                          ),

                      // Row(
                      //   mainAxisSize: MainAxisSize.min,
                      //   children: <Widget>[
                      //     Expanded(
                      //         flex: 1,
                      //         child: Text(
                      //           "${localizations?.translate(AppStringConstant.subtotal) ?? ""}: ",
                      //           style: Theme.of(context)
                      //               .textTheme
                      //               .titleSmall
                      //               ?.copyWith(fontSize: 14),
                      //         )),
                      //     Expanded(
                      //       flex: 2,
                      //       child: Text((product?.subTotal ?? "0.00"),
                      //           style:
                      //           Theme.of(context).textTheme.titleLarge),
                      //     ),
                      //   ],
                      // )
                    ],
                  ),
                ),

                // Wishlist button
                InkWell(
                  onTap: () {
                    if (appStoragePref.isLoggedIn()) {
                      bloc?.add(CartToWishlistEvent(
                          product?.id ?? "",
                          product?.productId ?? "",
                          product?.qty.toString() ?? ""));
                      bloc?.emit(CartScreenInitial());
                    } else {
                      AppDialogHelper.confirmationDialog(
                          Utils.getStringValue(context,
                              AppStringConstant.loginRequiredToAddOnWishlist),
                          context,
                          AppLocalizations.of(context),
                          title: Utils.getStringValue(
                              context, AppStringConstant.loginRequired),
                          onConfirm: () async {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.signInSignUp);
                          });
                    }
                  },

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const FluxImage(imageUrl: 'assets/icons/wishlist_circle.svg',),
                      const SizedBox(height: 5,),
                      SizedBox(
                        width: AppSizes.deviceWidth*.13,
                        child: Text(
                          localizations
                                  ?.translate(AppStringConstant.moveToWishlist) ??
                              "",
                          style: KTextStyle.of(context).semiTwelve,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.size16),

          ],
        ),
      ),
    );
  }
}
