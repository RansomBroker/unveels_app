/*
 *
  

 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:test_new/unvells/app_widgets/custom_button.dart';
import 'package:test_new/unvells/configuration/unvells_theme.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/helper/app_storage_pref.dart';
import 'package:test_new/unvells/screens/settings/bloc/settings_screen_bloc.dart';
import 'package:test_new/unvells/screens/settings/bloc/settings_screen_state.dart';
import '../../app_widgets/app_alert_message.dart';
import '../../app_widgets/app_bar.dart';
import '../../app_widgets/app_date_picker.dart';
import '../../app_widgets/app_dialog_helper.dart';
import '../../app_widgets/app_outlined_button.dart';
import '../../app_widgets/app_switch_button.dart';
import '../../app_widgets/app_text_field.dart';
import '../../app_widgets/loader.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_string_constant.dart';
import '../../helper/app_localizations.dart';
import '../../helper/utils.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool changePassword = false;
  bool changeAllNotification = false;
  bool changeOrders = false;
  bool changeOffers = false;
  bool changeAbandonedCart = false;
  bool changeNotificationSound = false;
  bool changeRecentlyViewedProducts = false;
  bool changeSearchHistory = false;
  bool isLoading = false;
  bool isEmailVerified = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsScreenBloc, SettingsScreenState>(
        builder: (BuildContext context, SettingsScreenState currentState) {
          return _buildUI();
        });
  }

  Widget _buildUI() {
    return Stack(
      children: <Widget>[
        _buildContent(),
        Visibility(visible: isLoading, child: const Loader())
      ],
    );
  }

  Widget buildUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      /// Notification Settings
                      const SizedBox(
                        height: AppSizes.size8,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            left: AppSizes.size8,
                            top: AppSizes.size8,
                            right: AppSizes.size8,
                            bottom: 0.0),
                        child: Text(
                          Utils.getStringValue(context,
                              AppStringConstant.notificationsSettings)
                              .toUpperCase(),
                          style: KTextStyle.of(context).sixteen,
                          textAlign: TextAlign.start,
                          textDirection: TextDirection.ltr,
                        ),
                      ),

                      const SizedBox(
                        height: AppSizes.size16,
                      ),

                      const Divider(
                        height: 1,
                        thickness: 1,
                      ),

                      /// All Notifications
                      Padding(
                        padding: const EdgeInsets.only(
                            left: AppSizes.size8,
                            top: AppSizes.size8,
                            bottom: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              Utils.getStringValue(context,
                                  AppStringConstant.allNotifications),
                              style: KTextStyle.of(context).twelve
                            ),
                            const Spacer(),
                            AppSwitchButton("", (value) {
                              setState(() {
                                appStoragePref
                                    .setAllowAllNotifications(value);
                              });
                            }, appStoragePref.getAllowAllNotifications()),
                          ],
                        ),
                      ),

                      const Divider(
                        height: 1,
                        thickness: 1,
                      ),

                      /// Orders
                      Padding(
                        padding: const EdgeInsets.only(
                            left: AppSizes.size8,
                            top: AppSizes.size8,
                            bottom: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              Utils.getStringValue(
                                  context, AppStringConstant.orders),
                              style: KTextStyle.of(context).twelve
                            ),
                            const Spacer(),
                            AppSwitchButton(
                              "",
                                  (value) {
                                setState(() {
                                  appStoragePref
                                      .setAllowOrderNotifications(value);
                                });
                              },
                              appStoragePref.getAllowOrderNotifications(),
                            ),
                          ],
                        ),
                      ),

                      const Divider(
                        height: 1,
                        thickness: 1,
                      ),

                      /// Offers
                      Padding(
                        padding: const EdgeInsets.only(
                            left: AppSizes.size8,
                            top: AppSizes.size8,
                            bottom: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              Utils.getStringValue(
                                  context, AppStringConstant.offers),
                              style: KTextStyle.of(context).twelve
                            ),
                            const Spacer(),
                            AppSwitchButton("", (value) {
                              setState(() {
                                appStoragePref
                                    .setAllowOfferNotifications(value);
                              });
                            }, appStoragePref.getAllowOfferNotifications()),
                          ],
                        ),
                      ),

                      /// Abandoned Cart
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //       left: AppSizes.size8,
                      //       top: AppSizes.size8,
                      //       bottom: 0.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     mainAxisSize: MainAxisSize.max,
                      //     children: <Widget>[
                      //       Text(
                      //         Utils.getStringValue(
                      //             context, AppStringConstant.abandonedCart),
                      //         style: Theme.of(context)
                      //             .textTheme
                      //             .bodyLarge
                      //             ?.copyWith(
                      //                 color: Theme.of(context)
                      //                     .appBarTheme
                      //                     .iconTheme
                      //                     ?.color),
                      //       ),
                      //       const Spacer(),
                      //       AppSwitchButton("", (value) {
                      //         setState(() {
                      //           changeAbandonedCart = value;
                      //         });
                      //       }, changeAbandonedCart),
                      //     ],
                      //   ),
                      // ),

                      // const Divider(
                      //   height: 1,
                      //   thickness: 1,
                      // ),

                      /// Notification Sound
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //       left: AppSizes.size8,
                      //       top: AppSizes.size8,
                      //       bottom: 0.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     mainAxisSize: MainAxisSize.max,
                      //     children: <Widget>[
                      //       Text(
                      //         Utils.getStringValue(context,
                      //             AppStringConstant.notificationSound),
                      //         style: Theme.of(context)
                      //             .textTheme
                      //             .bodyLarge
                      //             ?.copyWith(
                      //                 color: Theme.of(context)
                      //                     .appBarTheme
                      //                     .iconTheme
                      //                     ?.color),
                      //       ),
                      //       const Spacer(),
                      //       AppSwitchButton("", (value) {
                      //         setState(() {
                      //           changeNotificationSound = value;
                      //         });
                      //       }, changeNotificationSound),
                      //     ],
                      //   ),
                      // ),
                    ]),
    
                Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: AppSizes.size8,
                      ),

                      /// Offline Data
                      Padding(
                        padding: const EdgeInsets.only(
                            left: AppSizes.size8,
                            top: AppSizes.size8,
                            right: AppSizes.size8,
                            bottom: 0.0),
                        child: Text(
                          Utils.getStringValue(
                              context, AppStringConstant.offlineData)
                              .toUpperCase(),
                          style: KTextStyle.of(context).sixteen,
                          textAlign: TextAlign.start,
                          textDirection: TextDirection.ltr,
                        ),
                      ),

                      const SizedBox(
                        height: AppSizes.size16,
                      ),
                      const Divider(
                        height: 1,
                        thickness: 1,
                      ),

                      /// Track and Show Recently Viewed Products
                      Padding(
                        padding: const EdgeInsets.only(
                            left: AppSizes.size8,
                            top: AppSizes.size8,
                            bottom: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                Utils.getStringValue(
                                    context,
                                    AppStringConstant
                                        .trackAndShowRecentlyViewedProducts)
                                    .toUpperCase(),
                                style: KTextStyle.of(context).twelve
                              ),
                            ),
                            // const Spacer(),
                            AppSwitchButton("", (value) {
                              setState(() {
                                appStoragePref.setShowRecentProduct(value);
                              });
                            }, appStoragePref.getShowRecentProduct()),
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //       left: AppSizes.size8,
                      //       top: AppSizes.size0,
                      //       bottom: 0.0),
                      //   child: GestureDetector(
                      //     onTap: () {
                      //       Utils.clearRecentProducts();
                      //       WidgetsBinding.instance
                      //           ?.addPostFrameCallback((_) {
                      //         AlertMessage.showSuccess(
                      //             Utils.getStringValue(
                      //                 context,
                      //                 AppStringConstant
                      //                     .recentlyViewedProductsCleared) ??
                      //                 '',
                      //             context);
                      //       });
                      //     },
                      //     child: Text(
                      //       Utils.getStringValue(
                      //           context,
                      //           AppStringConstant
                      //               .clearRecentlyViewedProducts)
                      //           .toUpperCase(),
                      //       style: Theme.of(context)
                      //           .textTheme
                      //           .headlineLarge
                      //           ?.copyWith(color: AppColors.lightRed),
                      //     ),
                      //   ),
                      // ),

                      const SizedBox(
                        height: AppSizes.size16,
                      ),
                      const Divider(
                        height: 1,
                        thickness: 1,
                      ),

                      /// Track and Search History
                      Padding(
                        padding: const EdgeInsets.only(
                            left: AppSizes.size8,
                            top: AppSizes.size8,
                            bottom: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              Utils.getStringValue(context,
                                  AppStringConstant.showSearchTag)
                                  .toUpperCase(),
                              style: KTextStyle.of(context).twelve,
                            ),
                            const Spacer(),
                            AppSwitchButton("", (value) {
                              setState(() {
                                appStoragePref.setShowSearchTag(value);
                              });
                            }, appStoragePref.getShowSearchTag()),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: AppSizes.size16,
                      ),
                    ]),
    
                const SizedBox(
                  height: AppSizes.size24,
                ),
    
                FutureBuilder<PackageInfo>(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        return Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            '${Utils.getStringValue(context, AppStringConstant.appVersion)} ${snapshot.data!.version}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                color: AppColors.textColorSecondary,
                                fontSize: AppSizes.textSizeSmall),
                          ),
                        );
                      default:
                        return const SizedBox();
                    }
                  },
                ),
    
                const SizedBox(
                  height: AppSizes.size4,
                ),
    
                /// Last Updated
                // Padding(
                //     padding: const EdgeInsets.only(
                //         left: AppSizes.size8,
                //         top: AppSizes.size8,
                //         bottom: 0.0),
                //     child: Align(
                //       alignment: Alignment.bottomCenter,
                //       child: Text(
                //         Utils.getStringValue(
                //             context, AppStringConstant.lastUpdated),
                //         style: Theme.of(context)
                //             .textTheme
                //             .bodyLarge
                //             ?.copyWith(
                //                 color: AppColors.textColorSecondary,
                //                 fontSize: AppSizes.textSizeSmall),
                //       ),
                //     )),
    
                const SizedBox(
                  height: AppSizes.size24,
                ),
    
                CustomButton(
                  onPressed: () {
                    Utils.clearRecentProducts();
                    WidgetsBinding.instance
                        ?.addPostFrameCallback((_) {
                      AlertMessage.showSuccess(
                          Utils.getStringValue(
                              context,
                              AppStringConstant
                                  .recentlyViewedProductsCleared) ??
                              '',
                          context);
                    });
                  },
                        title: Utils.getStringValue(context,
                            AppStringConstant.clearRecentlyViewedProducts),
                  // child: Center(
                  //   child: Text(
                  //     Utils.getStringValue(context,
                  //         AppStringConstant.clearRecentlyViewedProducts)
                  //         .toUpperCase(),
                  //     style: const TextStyle(color: Colors.white),
                  //   ),
                  // ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildContent() {
    return Consumer<CheckTheme>(
        builder: (context, CheckTheme themeNotifier, child) {
          return Scaffold(
              appBar: commonAppBar(
                  Utils.getStringValue(context, AppStringConstant.settings),
                  context,
                  isLeadingEnable: true, onPressed: () {
                Navigator.pop(context);
              },
              //     actions: [
              //   GestureDetector(
              //     onTap: () {
              //       themeNotifier.isDark == "true"
              //           ? themeNotifier.isDark = "false"
              //           : themeNotifier.isDark = "true";
              //     },
              //     child: Row(
              //       children: [
              //         const Text('Change Theme'),
              //         const SizedBox(
              //           width: 10,
              //         ),
              //         themeNotifier.isDark == "true"
              //             ? const Icon(Icons.nightlight_round)
              //             : const Icon(Icons.wb_sunny),
              //         const SizedBox(
              //           width: 10,
              //         ),
              //       ],
              //     ),
              //   )
              // ],
              ),
              body: buildUI());
        });
  }

  void checkUpdateTime() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = "${packageInfo.version}+${packageInfo.buildNumber}";
    String now = DateTime.now().toUtc().toString();
  }
}
