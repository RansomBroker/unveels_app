/*
 *


 *
 * /
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_new/unvells/app_widgets/app_bar.dart';
import 'package:test_new/unvells/app_widgets/bottom_sheet.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/app_storage_pref.dart';
import 'package:test_new/unvells/helper/utils.dart';

import '../../app_widgets/AppRestart.dart';
import '../../app_widgets/app_alert_message.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_routes.dart';
import '../../constants/global_data.dart';

void showCurrencyBottomSheet(BuildContext context) {
  var availableLanguages = GlobalData.homePageData?.allowedCurrencies;
  if (availableLanguages != null) {
    showAppModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),

      builder: (ctx) =>  Container(
        padding: const EdgeInsets.all(16),
        decoration: ShapeDecoration(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: availableLanguages.length,
            itemBuilder: (context, index) {
              var item = availableLanguages[index];
              return InkWell(
                  onTap: () {
                    if (appStoragePref.getCurrencyCode().toString() !=
                        item.code.toString()) {
                      appStoragePref.setCurrencyCode(item.code ?? "");
                      Utils.clearRecentProducts();
                      Navigator.pushNamedAndRemoveUntil(
                          context, AppRoutes.splash, (route) => false);
                    }
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSizes.spacingGeneric),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: AppSizes.size16,
                              ),
                              Text(
                                item.code ?? "",
                                // style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: AppSizes.textSizeLarge, color: AppColors.textColorPrimary),
                                style: KTextStyle.of(context).boldTwelve,
                              ),
                              const SizedBox(
                                height: AppSizes.linePadding,
                              ),
                              Text(
                                item.label ?? " ",
                                style: KTextStyle.of(context).twelve.copyWith(color: Colors.grey),
                              ),
                              const SizedBox(
                                height: AppSizes.size4,
                              ),
                            ],
                          ),
                          (appStoragePref.getCurrencyCode().toString() ==
                              item.code.toString())
                              ? Icon(
                            Icons.radio_button_checked,
                            color:
                            Theme.of(context).colorScheme.onPrimary,
                            size: 20,
                          )
                              : Icon(
                            Icons.radio_button_off,
                            color:
                            Theme.of(context).colorScheme.onPrimary,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ));
            }),
      ),
    );
  }
}
