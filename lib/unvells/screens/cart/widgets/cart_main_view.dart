/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/app_widgets/app_dialog_helper.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/constants/app_routes.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/app_localizations.dart';
import 'package:test_new/unvells/models/cart/cart_details_model.dart';
import 'package:test_new/unvells/screens/cart/widgets/price_detail_view.dart';
import 'package:test_new/unvells/screens/home/widgets/product_carasoul_widget_type2.dart';
import '../bloc/cart_screen_bloc.dart';
import '../bloc/cart_screen_event.dart';
import '../bloc/cart_screen_state.dart';
import 'cart_icon_button.dart';
import 'cart_product_item.dart';
import 'discount_view.dart';

class CartMainView extends StatelessWidget {
  const CartMainView(this.model, this.localizations, this.bloc, {Key? key})
      : super(key: key);

  final CartDetailsModel? model;
  final AppLocalizations? localizations;
  final CartScreenBloc? bloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // crossAxisAlignment: CrossAxisAlignment.s,

      children: <Widget>[
        // products list view
        Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
                "${(localizations?.translate(AppStringConstant.items) ?? "")} (${model?.items?.length.toString()})",
                style: KTextStyle.of(context).boldSixteen),
            const SizedBox(
              height: 15,
            ),
            ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: 16),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (ctx, index) =>
                  CartProductItem(model?.items?[index], localizations, bloc),
              itemCount: (model?.items?.length ?? 0),
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  color: Color(0xffE3E5E5),
                );
              },
            ),
          ],
        ),

        /// vouchers listview

        // DiscountView(
        //   discountApplied: model?.couponCode?.isNotEmpty ?? false,
        //   discountCode: model?.couponCode ?? "",
        //   onClickApply: (discountCode) {
        //     bloc?.add(ApplyCouponEvent(discountCode.toString() ?? "", 0));
        //   },
        //   onClickRemove: (discountCode) {
        //     bloc?.add(ApplyCouponEvent(model?.couponCode.toString() ?? "", 1));
        //   },
        // ),

        // CartIconButton(
        //   leadingIcon: Icons.update,
        //   title: localizations?.translate(AppStringConstant.updateShoppingCart).toUpperCase() ?? "",
        //   onClick: () {
        //     bloc?.add(const CartScreenDataFetchEvent());
        //   },
        // ),
        // CartIconButton(
        //   leadingIcon: Icons.arrow_forward,
        //   title: localizations?.translate(AppStringConstant.continueShopping) ??
        //       "",
        //   onClick: () {
        //     Navigator.pushNamed(context, AppRoutes.bottomTabBar);
        //   },
        // ),
        // CartIconButton(
        //   leadingIcon: Icons.delete_forever,
        //   title: (localizations?.translate(AppStringConstant.emptyCart) ?? "")
        //       .toUpperCase(),
        //   onClick: () {
        //     AppDialogHelper.confirmationDialog(
        //         AppStringConstant.emptyCartText, context, localizations,
        //         title: AppStringConstant.emptyCart, onConfirm: () {
        //       bloc?.add(SetCartEmpty());
        //       bloc?.emit(CartScreenInitial());
        //     });
        //   },
        // ),
        const SizedBox(height: 10.0),
        Container(
          color: Theme.of(context).colorScheme.background,
          child: ProductCarasoulType2((model?.crossSellList ?? []), context, "","",
              (localizations?.translate(AppStringConstant.moreChoices) ?? ''),
              isShowViewAll: false),
        ),

        PriceDetailView(model?.totalsData ?? [], localizations),
      ],
    );
  }
}
