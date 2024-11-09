/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/app_widgets/app_outlined_button.dart';
import 'package:test_new/unvells/app_widgets/custom_button.dart';
import 'package:test_new/unvells/app_widgets/flux_image.dart';
import 'package:test_new/unvells/configuration/unvells_theme.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/constants/app_routes.dart';
import 'package:test_new/unvells/helper/app_localizations.dart';

import 'package:test_new/unvells/models/checkout/place_order/place_order_model.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/app_string_constant.dart';
import '../../../../helper/app_storage_pref.dart';
import '../../../../helper/bottom_sheet_helper.dart';

class PlaceOrderScreen extends StatefulWidget {
  PlaceOrderModel? placeOrderModel;

  PlaceOrderScreen(this.placeOrderModel, {Key? key}) : super(key: key);

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  bool isLoading = true;
  AppLocalizations? _localizations;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const FluxImage(imageUrl: "assets/icons/sucess_icon.png"),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.placeOrderModel?.message ?? "",
                      style: KTextStyle.of(context).boldSixteen,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      _localizations
                              ?.translate(AppStringConstant.orderReceived) ??
                          "",
                      textAlign: TextAlign.center,
                      style: KTextStyle.of(context)
                          .twelve
                          .copyWith(color: const Color(0xff212529)),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _localizations
                                  ?.translate(AppStringConstant.yourOrderIs) ??
                              "",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.normal),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              AppRoutes.orderDetail,
                              arguments:
                                  widget.placeOrderModel?.incrementId ?? "",
                            );
                          },
                          child: Text(
                            widget.placeOrderModel?.incrementId ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    fontWeight: FontWeight.normal,
                                    color: AppColors.blue,
                                    decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: AppSizes.deviceWidth * .8,
                      child: Text(
                        _localizations?.translate(
                                AppStringConstant.placeOrderMessage) ??
                            '',
                        style: KTextStyle.of(context)
                            .twelve
                            .copyWith(color: const Color(0xff959393)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: AppSizes.deviceHeight * .05,
                    ),
                    CustomButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, AppRoutes.bottomTabBar, (route) => false);
                      },
                      title: _localizations
                              ?.translate(AppStringConstant.continueShopping) ??
                          "",
                      width: AppSizes.deviceWidth / 1.5,
                    )
                  ],
                ),
                if (appStoragePref.isLoggedIn() == false)
                  Container(
                    // height: AppSizes.deviceHeight / 3,
                    width: AppSizes.deviceWidth - 50,
                    padding:
                        const EdgeInsets.symmetric(vertical: AppSizes.size8),
                    margin: const EdgeInsets.only(top: AppSizes.size8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 1.0,
                          color: AppColors.lightGray.withOpacity(0.3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(AppSizes.size8),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    _localizations?.translate(AppStringConstant
                                            .placeOrderMessageForAccountCreation) ??
                                        '',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.normal),
                                  ),
                                )
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(AppSizes.size8),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _localizations?.translate(
                                          AppStringConstant.yourEmailIs) ??
                                      "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  widget.placeOrderModel?.email ?? "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ]),
                        ),
                        appOutlinedButton(
                          context,
                          () {
                            signInSignUpBottomModalSheet(context, true, false);
                          },
                          _localizations?.translate(
                                  AppStringConstant.createAnAccount) ??
                              "",
                          height: 45,
                          width: AppSizes.deviceWidth / 1.5,
                        )
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        onWillPop: () async {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.bottomTabBar, (route) => false);
          return true;
        });
  }
}
