/*
 *


 *
 * /
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_new/unvells/app_widgets/app_bar.dart';
import 'package:test_new/unvells/app_widgets/bottom_sheet.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/app_storage_pref.dart';
import 'package:test_new/unvells/helper/utils.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_routes.dart';
import '../../constants/global_data.dart';

void showWebsiteBottomSheet(BuildContext context) {
  var availableWebsite = GlobalData.homePageData?.websiteData;
  if (availableWebsite != null) {
    showAppModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => Scaffold(
        appBar: commonAppBar(
            Utils.getStringValue(context, AppStringConstant.websites), context,
            isLeadingEnable: true, onPressed: () {
          Navigator.pop(context);
        }),
        body: Container(
          color: Theme.of(context).cardColor,
          child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: availableWebsite.length,
              itemBuilder: (context, index) {
                var item = availableWebsite[index];
                return InkWell(
                    onTap: () {
                      if (appStoragePref.getWebsiteId().toString() !=
                          item.id.toString()) {

                        appStoragePref.setWebsiteId(item.id.toString());
                        appStoragePref.setWebsiteUrl(item.baseUrl.toString());
                        appStoragePref.setStoreId(AppConstant.defaultStoreId);
                        appStoragePref.setStoreCode(AppConstant.defaultStoreCode);
                        appStoragePref.setCurrencyCode(AppConstant.defaultCurrency);
                        Utils.clearRecentProducts();
                        if (appStoragePref.isLoggedIn()) {
                          appStoragePref.logoutUser();
                        }
                        WidgetsBinding.instance?.addPostFrameCallback((_) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, AppRoutes.splash, (route) => false);
                        });
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
                                  item.name ?? "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(
                                          fontSize: AppSizes.textSizeMedium),
                                ),
                                const SizedBox(
                                  height: AppSizes.size4,
                                ),
                              ],
                            ),
                            (appStoragePref.getWebsiteId().toString() ==
                                    item.id.toString())
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
      ),
    );
  }
}
