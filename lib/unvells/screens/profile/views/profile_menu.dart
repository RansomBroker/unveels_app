/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/app_widgets/dialog_helper.dart';
import 'package:test_new/unvells/app_widgets/flux_image.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/helper/app_storage_pref.dart';
import 'package:test_new/unvells/helper/bottom_sheet_helper.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/screens/preferences/currency_bottomsheet_screen.dart';
import 'package:test_new/unvells/screens/profile/views/profile_banner_view.dart';
import 'package:test_new/unvells/screens/profile/views/profile_menu_items.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/app_string_constant.dart';
import '../../../constants/arguments_map.dart';
import '../../../constants/global_data.dart';
import '../../../helper/app_localizations.dart';
import '../../../models/homePage/footer_menu.dart';
import '../../../network_manager/api_client.dart';
import '../../preferences/website_bottomsheet_screen.dart';

Widget profileMenu(Function logoutFunction, AppLocalizations? _localizations,
    VoidCallback setState) {
  List<ProfileMenuItems> menuItems = [];
  menuItems.clear();
  // if (isUserLogin) {
  if (appStoragePref.isLoggedIn() ?? false) {
    // if (true) {
    // menuItems.add(ProfileMenuItems(
    //     id: 1,
    //     title: _localizations?.translate(AppStringConstant.dashboard) ?? '',
    //     icon: AppImages.dashboardIcon));
    menuItems.add(ProfileMenuItems(
      id: 2,
      title: _localizations?.translate(AppStringConstant.myWishlist) ?? '',
      icon: AppImages.wishlistsIcon,
    ));
    menuItems.add(ProfileMenuItems(
        id: 3,
        title: _localizations?.translate(AppStringConstant.allOrders) ?? '',
        icon: AppImages.ordersIcon));
    // menuItems.add(ProfileMenuItems(
    //     id: 4,
    //     title: _localizations
    //             ?.translate(AppStringConstant.myDownloadableProducts) ??
    //         '',
    //     icon: AppImages.wishlistsIcon,
    //     iconData: Icons.download_rounded));
    // menuItems.add(ProfileMenuItems(
    //     id: 5,
    //     title: _localizations?.translate(AppStringConstant.productReview) ?? '',
    //     icon: AppImages.addressIcon,
    //     ));
    menuItems.add(ProfileMenuItems(
        id: 6,
        title: _localizations?.translate(AppStringConstant.addressBook) ?? '',
        icon: AppImages.addressIcon));
    menuItems.add(ProfileMenuItems(
        id: 7,
        title: _localizations?.translate(AppStringConstant.accountInfo) ?? '',
        icon: AppImages.accountInfoIcon));

    menuItems.add(ProfileMenuItems(
      id: 21,
      title: _localizations?.translate(AppStringConstant.myWallet) ?? '',
      icon: 'assets/icons/myWallet.svg',
    ));

    /// Option for Watch Qr Login
    if (appStoragePref.getWatchEnabled()) {
      menuItems.add(ProfileMenuItems(
          id: 20,
          title: _localizations?.translate(AppStringConstant.watchLogin) ?? '',
          icon: AppImages.loginIcon));
    }
  } else {
    menuItems.add(ProfileMenuItems(
        id: 8,
        title:
            _localizations?.translate(AppStringConstant.signInRegister) ?? '',
        icon: AppImages.loginIcon));
    // menuItems.add(ProfileMenuItems(
    //     id: 16,
    //     title: (_localizations?.translate(AppStringConstant.ordersAndReturns) ??
    //         ''),
    //     icon: "",
    //     iconData: Icons.undo));
  }
  // menuItems.add();
  menuItems.add(ProfileMenuItems(
      id: 9,
      title: _localizations?.translate(AppStringConstant.settings) ?? '',
      icon: AppImages.settingsIcon,
      iconData: Icons.settings_outlined // need to change icon
      ));
  menuItems.add(ProfileMenuItems(
      id: 14,
      title: _localizations?.translate(AppStringConstant.preferences) ?? '',
      icon: AppImages.translationIcon,
      iconData: Icons.translate // need to change icon
      ));

  menuItems.add(ProfileMenuItems(
    id: 12,
    title: _localizations?.translate(AppStringConstant.others) ?? '',
    icon: AppImages.accountInfoIcon // need to change icon,
    ,
  ));
  if (appStoragePref.isLoggedIn()) {
    // menuItems.add(ProfileMenuItems(
    //     id: 15,
    //     title:
    //         _localizations?.translate(AppStringConstant.compareProduct) ?? '',
    //     icon: AppImages.accountInfoIcon,
    //     iconData: Icons.compare_arrows // need to change icon
    //     ));
  }

  // if (appStoragePref.isLoggedIn()) {
  //   menuItems.add(ProfileMenuItems(
  //       id: 11,
  //       title: _localizations?.translate(AppStringConstant.signOut) ?? '',
  //       icon: AppImages.logoutIcon // need to change icon
  //   ));
  // }

  return SingleChildScrollView(
      child: Column(children: [
    if (appStoragePref.isLoggedIn()) ProfileBannerView((p0, p1) {}),
    const SizedBox(height: 20),
    ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: menuItems.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, i) {
        var menuItem = menuItems[i];
        return profileTiles(
            context, logoutFunction, menuItem, _localizations, setState);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          color: Color(0xffEEEFF0),
        );
      },
    )
  ]));
}

Widget dropdownProfileTile(
    BuildContext context,
    ProfileMenuItems data,
    Function logoutFunction,
    AppLocalizations? _localizations,
    VoidCallback setState,
    List<ProfileMenuItems> children) {
  return

      //   InkWell(
      //   onTap: () => ProfileBottomModelSheet(
      //       context,
      //       Column(
      //         mainAxisSize: MainAxisSize.min,
      //         children: List.generate(
      //           getPreferencesChildren(_localizations).length,
      //           (index) => Text("data"),
      //         ),
      //       )),
      //   child: Text(data.title,
      //       style: KTextStyle.of(context).boldSixteen.copyWith(fontSize: 14)),
      // );
      Theme(
    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
    child: ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.zero,
      iconColor: Theme.of(context).iconTheme.color,

      leading: data.iconData != null
          ? Icon(
              data.iconData!,
              size: 20,
              // color: Theme.of(context).iconTheme.color,
            )
          : FluxImage(
              imageUrl: data.icon,
              height: 20,
              width: 20,
              // color: Theme.of(context).iconTheme.color,
            ),
      // trailing: Icon(Icons.add),

      title: Text(data.title,
          style: KTextStyle.of(context).boldSixteen.copyWith(fontSize: 14)),
      children: children
          .map((e) => expansionChildren(context, e.title, e.id, logoutFunction,
              _localizations, setState, e.cmsData, e.isCMS ?? false))
          .toList(),
    ),
  );
}

List<ProfileMenuItems> getPreferencesChildren(
    AppLocalizations? _localizations) {
  List<ProfileMenuItems> preferenceList = [];
  preferenceList.add(ProfileMenuItems(
      id: 17,
      title: _localizations?.translate(AppStringConstant.language) ?? '',
      icon: ""));
  preferenceList.add(ProfileMenuItems(
      id: 18,
      title: _localizations?.translate(AppStringConstant.currency) ?? '',
      icon: ""));
  if ((GlobalData.homePageData?.websiteData ?? []).isNotEmpty &&
      (GlobalData.homePageData?.websiteData ?? []).length > 1) {
    preferenceList.add(ProfileMenuItems(
        id: 19,
        title: _localizations?.translate(AppStringConstant.websites) ?? '',
        icon: ""));
  }

  return preferenceList;
}

List<ProfileMenuItems> getMyWalletChildren(AppLocalizations? _localizations) {
  List<ProfileMenuItems> preferenceList = [];
  preferenceList.add(ProfileMenuItems(
      id: 22,
      title: _localizations?.translate(AppStringConstant.manageWallet) ?? '',
      icon: ""));
  preferenceList.add(ProfileMenuItems(
      id: 23,
      title: _localizations?.translate(AppStringConstant.transferWallet) ?? '',
      icon: ""));
  preferenceList.add(ProfileMenuItems(
      id: 24,
      title:
          _localizations?.translate(AppStringConstant.addAccountDetails) ?? '',
      icon: ""));
  return preferenceList;
}

final isAr = appStoragePref.getStoreCode == 'ar';

List<ProfileMenuItems> getOtherChildren(AppLocalizations? _localizations) {
  var cmsList = <ProfileMenuItems>[];
  GlobalData.homePageData?.cmsData?.forEach((element) {
    cmsList.add(ProfileMenuItems(
        id: int.parse(element?.id ?? ""),
        title: element.title ?? '',
        icon: "",
        isCMS: true));
  });

  cmsList.add(
    ProfileMenuItems(
        id: 13,
        title: (_localizations?.translate(AppStringConstant.contactUs) ?? ''),
        icon: ""),
  );
  cmsList.add(
    ProfileMenuItems(
        id: isAr ? 1030 : 1028,
        title:
            (_localizations?.translate(AppStringConstant.aboutUnveels) ?? ''),
        isCMS: true,
        icon: ""),
  );
  cmsList.add(
    ProfileMenuItems(
        id: isAr ? 1022 : 1015,
        title: (_localizations?.translate(AppStringConstant.terms) ?? ''),
        isCMS: true,
        icon: ""),
  );
  cmsList.add(
    ProfileMenuItems(
        id: isAr ? 1024 : 1017,
        title: (_localizations?.translate(AppStringConstant.privacy) ?? ''),
        isCMS: true,
        icon: ""),
  );
  cmsList.add(
    ProfileMenuItems(
        id: isAr ? 1025 : 1018,
        title:
            (_localizations?.translate(AppStringConstant.howToRegister) ?? ''),
        isCMS: true,
        icon: ""),
  );
  cmsList.add(
    ProfileMenuItems(
        id: isAr ? 1021 : 1014,
        title:
            (_localizations?.translate(AppStringConstant.deliveryTerms) ?? ''),
        isCMS: true,
        icon: ""),
  );
  cmsList.add(
    ProfileMenuItems(
        id: isAr ? 1023 : 1016,
        title:
            (_localizations?.translate(AppStringConstant.promotionTerms) ?? ''),
        isCMS: true,
        icon: ""),
  );
  cmsList.add(
    ProfileMenuItems(
        id: isAr ? 1026 : 1019,
        title: (_localizations?.translate(AppStringConstant.frequentlyAsked) ??
            ''),
        isCMS: true,
        icon: ""),
  );
  cmsList.add(
    ProfileMenuItems(
        id: isAr ? 1027 : 1020,
        title: (_localizations?.translate(AppStringConstant.exchangeReturns) ??
            ''),
        isCMS: true,
        icon: ""),
  );
  cmsList.add(
    ProfileMenuItems(id: isAr ? 1027 : 1020, title: "", isCMS: true, icon: ""),
  );
  cmsList.add(
    ProfileMenuItems(id: isAr ? 1027 : 1020, title: "", isCMS: true, icon: ""),
  );
  return cmsList;
}
// Exchange & Returns - ID : 1020
// الاستبدال والإرجاع :1027

Widget profileTiles(
    BuildContext context,
    Function logoutFunction,
    ProfileMenuItems item,
    AppLocalizations? _localizations,
    VoidCallback setState,
    {double iconWidth = 20.0,
    double? iconHeight = 20.0}) {
  return ListTile(
    onTap: () {
      callBack(context, item.id, logoutFunction, _localizations, setState);
    },
    leading: (item.id == 12 || item.id == 14 || item.id == 21)
        ? null
        : item.iconData != null
            ? Icon(
                item.iconData!,
                size: iconHeight,
                // color: Theme.of(context).iconTheme.color,
              )
            : FluxImage(
                imageUrl: item.icon,
                height: iconHeight,
                width: iconWidth,
                // color: Theme.of(context).iconTheme.color,
              ),
    trailing: (item.id == 12 || item.id == 14 || item.id == 21)
        ? null
        : const Icon(
            Icons.arrow_forward_ios,
            size: 15,
            color: Color(0xff012F5D),
          ),
    title: item.id == 12
        ? dropdownProfileTile(context, item, logoutFunction, _localizations,
            setState, getOtherChildren(_localizations))
        : item.id == 14
            ? dropdownProfileTile(
                context,
                item,
                logoutFunction,
                _localizations,
                setState,
                getPreferencesChildren(_localizations),
              )
            : item.id == 21
                ? dropdownProfileTile(
                    context,
                    item,
                    logoutFunction,
                    _localizations,
                    setState,
                    getMyWalletChildren(_localizations),
                  )
                : Text(item.title,
                    style: KTextStyle.of(context)
                        .boldSixteen
                        .copyWith(fontSize: 14)),
  );
}

void callBack(BuildContext context, int id, Function logoutFunction,
    AppLocalizations? _localizations, VoidCallback setState,
    {FooterMenu? cmsData}) async {
  if (id > 18 && cmsData != null) {
    print("dwaasa---$id");
  } else {
    print("dwaasa---$id");
    switch (id) {
      case 1:
        Navigator.of(context).pushNamed(AppRoutes.dashboard).then((value) {
          setState();
        });
        break;
      case 2:
        Navigator.of(context).pushNamed(AppRoutes.wishlist);
        break;
      case 3:
        Navigator.of(context).pushNamed(AppRoutes.orderList, arguments: false);
        break;
      case 4:
        Navigator.of(context)
            .pushNamed(AppRoutes.downloadableProducts, arguments: false);
        break;
      case 5:
        Navigator.of(context)
            .pushNamed(AppRoutes.productReview, arguments: false);
        break;
      case 6:
        Navigator.of(context).pushNamed(AppRoutes.addressBook);
        break;
      case 7:
        Navigator.of(context).pushNamed(AppRoutes.accountInfo).then((value) {
          setState();
        });
        break;
      case 8:
        Navigator.of(context).pushNamed(AppRoutes.signInSignUp);
        break;
      case 9:
        Navigator.of(context).pushNamed(AppRoutes.settingsScreen);
        break;
      case 11:
        DialogHelper.confirmationDialog(
          Utils.getStringValue(context, AppStringConstant.logoutDescription),
          context,
          AppLocalizations.of(context),
          title: Utils.getStringValue(context, AppStringConstant.logoutTitle),
          onConfirm: () {
            logoutFunction();
          },
        );

        break;
      case 13:
        Navigator.of(context).pushNamed(AppRoutes.contactUs);
        break;
      case 15:
        Navigator.pushNamed(context, AppRoutes.compareProduct);
        break;

      case 16:
        Navigator.pushNamed(context, AppRoutes.ordersAndReturns);
        break;

      case 17:
        // Navigator.of(context).pushNamed(AppRoutes.languageScreen);
        // showLanguageBottomSheet(context);
        languageBottomModelSheet(context);
        break;
      case 18:
        showCurrencyBottomSheet(context);
        // Navigator.of(context).pushNamed(AppRoutes.currencyScreen);
        break;
      case 19:
        showWebsiteBottomSheet(context);
        break;
      case 20:
        Navigator.pushNamed(context, AppRoutes.qrScreen);
        break;
      case 22:
        Navigator.pushNamed(context, AppRoutes.manageWallet);
        break;

      case 23:
        Navigator.pushNamed(context, AppRoutes.transferWallet);
        break;

      case 24:
        Navigator.pushNamed(context, AppRoutes.addAccount);
        break;

      default:
    }
  }
}

Widget expansionChildren(
    BuildContext context,
    String title,
    int id,
    Function logoutFunction,
    AppLocalizations? _localizations,
    VoidCallback setState,
    FooterMenu? cmsData,
    bool isCMS) {
  return ListTile(
    dense: true,
    horizontalTitleGap: 0,
    contentPadding: const EdgeInsetsDirectional.only(start: 8),
    onTap: () {
      if (isCMS) {
        Navigator.of(context).pushNamed(
          AppRoutes.cmsPage,
          arguments: getCmsPageArguments(id.toString() ?? "", title ?? ""),
        );
      } else {
        callBack(context, id, logoutFunction, _localizations, setState,
            cmsData: cmsData);
      }
    },
    title: Text(title, style: Theme.of(context).textTheme.labelLarge),
  );
}
