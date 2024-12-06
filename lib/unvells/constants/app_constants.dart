/*
 *


 *
 * /
 */

import 'dart:ffi';

import 'package:flutter/material.dart';

import '../helper/extension.dart';

class ApiConstant {

  ///(.com Domain)

  ///(.in Domain)
  static const String webUrl = 'http://ec2-13-53-99-251.eu-north-1.compute.amazonaws.com';
  static const String mediaUrl = '$webUrl/media/';
  static const String apiKey = 'mobikuluser';
  static const String apiPassword = 'Gxd5]UP;^?';

  static const String baseUrl = '$webUrl/graphql';

  static const String baseData = "liveSecretKey:liveSecretKey";
  static const String googlePlace = "place/textsearch/json?query={endPoint}";
  static const String updateToken = "/updateTokenToDataBase";
  static const String firebaseUrl = "https://unveels-92787-default-rtdb.firebaseio.com"; //for mp app

  static const String techWebUrl = 'https://b52b-103-236-190-109.ngrok-free.app';
  static const String techToken = 'hb2vxjo1ayu0agrkr97eprrl5rccqotc';
}

class AppConstant {
  /// Firebase Configuration ///
  static const fcmMessagingTopicAndroid = "mobikul_android";
  static const fcmMessagingTopiciOS = "mobikul_ios";

  /// Google Map Configuration ///
  static const String googleKey = "AIzaSyBAlqVDV_6ec8DKG3yJPAE29HV4f-GOsdk";
  static const String channelName = "com.webkul.magento_mobikul/channel";
  static const String searchText = "searchText";
  static const String searchImage = "searchImage";
  static const String defaultStoreId = "1";
  static const String defaultStoreCode = "en";
  static const String defaultWebsiteId = "1";
  static const String defaultCurrency = "KWD";
  static const bool isDeliveryBoyEnable = true;

  static const String appDocPath = "";
  static const List<String> supportedLanguages = ['en', 'ar'];
  static const String mainPageBanner = "banner";
  static const String mainPageCategory = "category";
  static const String mainPagePopular = "popular";
  static const String mainPageBest = "best";
  static const String mainFeatureFeature = "featured";
  static const String mainPageLatest = "latest";
  static const String mainPageCarousel = "carousel";
  static const String productTypeNotification = "product";
  static const String categoryTypeNotification = "category";
  static const String customTypeNotification = "custom";
  static const String otherTypeNotification = "others";
  static const String orderTypeNotification = "order";
  static const String chatTypeNotification = "chat";

  /// Demo login credentials ///
  static const String demoEmail = "ahmedmaher.programmer@gmail.com";
  static const String demoPassword = "Test@123";

  /// Payment Methods ///
  static const String cashondelivery = "cashondelivery";
  static const String banktransfer = "banktransfer";
  static const String checkmo = "checkmo";
  static const String m2Wallet = "walletsystem";

  static const List<String> allowedPaymentMethods = [cashondelivery, banktransfer, checkmo];

  static const bool advanceSearch = false;
  static const bool enableArCore = true;
  static const bool enablePrecache = false;

  /// app key constants ///
  static const userBannerImage = "bannerImage";
  static const profileImage = "image";
  static const bannerImage = 'banner';
}

class AppSizes {
  static const double linePadding = 2;
  static double deviceHeight =
      MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;
  static double deviceWidth =
      MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;
  static const int splashScreenTitleFontSize = 14;
  static const int splashTiming = 2;
  static const double size15 = 15;
  static const double size14 = 14;
  static const double size12 = 12;
  static const double size8 = 8;
  static const double size4 = 4;
  static const double size6 = 6;
  static const double size16 = 16;
  static const double size24 = 24;
  static const double size10 = 10;
  static const double size20 = 20;
  static const double size18 = 18;
  static const double size22 = 22;
  static const double size26 = 26;
  static const double size30 = 30;
  static const double size34 = 34;
  static const double size90 = 90;
  static const double size1 = 1;
  static const double size2 = 2;
  static const double size240 = 240;
  static const double size58 = 58;
  static const double appBarSize = 56.0;
  static const double size40 = 40;
  static const double size44 = 44;
  static const double size50 = 50;
  static const double size0 = 0;
  static const double productListHeight = 210;
  static const double categoryImageSizeSmall = 90;
  static const double catProductItemHeight = 160;
  static const double categoryImageSizeMedium = 130;
  static const double cartProductSize = 96;
  static const double paddingNormal = 8.0;
  static const double paddingGeneric = 10;
  static const double paddingMedium = 12.0;
  static const double size100 = 100;
  static const double genericButtonHeight = 54.0;

  static const double socialLoginIconSize = 48;
  static const double loginSignupIconSize = 60;

  static const double reviewProductIconSize = 80;
  static const double featuredCategoryImageSizeSmall = 50;
  static const double profileIconSize = 60;
  static const double profileBannerSize = 100;

  static const double categoryListingImageSize = 50;

  /// Text size ///
  static const double textSizeTiny = 10;
  static const double textSizeSmall = 12;
  static const double textSizeMedium = 14;
  static const double textSizeLarge = 18;
  static const double textSizeXLarge = 22;

  /// Spacing ///
  static const double spacingTiny = 4;
  static const double spacingGeneric = 8;
  static const double spacingSmall = 10;
  static const double spacingNormal = 14;
  static const double spacingLarge = 20;
  static const double spacingHuge = 26;
  static const double spacingMax = 64;
  static const double spacingInfinity = 10;

  static const double itemHeight = 45;
  static const double buttonRadius = 25;

  static const double bottomWishlistVertical = 55;
  static const double bottomProgressSize = 18;
}

class AppColors {
  static const red = Color(0xFFDB3022);
  static const gold = Color(0xFFCA9C43);

  static const lightRed = Color(0xFFF65F53);
  static const yellow = Color(0xFFEA9301);
  static const black = Color(0xFF222222);
  static const lightGray = Color(0xFF9B9B9B);
  static const darkGray = Color(0xFF979797);
  static const white = Color(0xFFFFFFFF);
  static const orange = Color(0xFFFFBA49);
  static const transparent = Color(0x00000000);
  static const transparentBackground = Color(0x3B7F7D7D);
  static const green = Color(0xFF2AA952);
  static const blue = Color(0xFF3D79EC);
  static Color success = HexColor.fromHex("22bb33");
  static Color error = HexColor.fromHex("BB2124");
  static Color warning = HexColor.fromHex("f0ad4e");
  static Color discount = HexColor.fromHex("6BC700");

  // static const material_background = Color(value)
  /// Order status color ///
  static Color orderStatusDownloadedColor = HexColor.fromHex("d5d5d5");
  static Color orderStatusCompleteColor = HexColor.fromHex("66BB6A");
  static Color orderStatusPendingColor = HexColor.fromHex("fead4c");
  static Color orderStatusProcessingColor = HexColor.fromHex("3F51B5");
  static Color orderStatusHoldColor = HexColor.fromHex("F9A825");
  static Color orderStatusCancelColor = HexColor.fromHex("E53935");
  static Color orderStatusNewColor = HexColor.fromHex("448AFF");
  static Color orderStatusClosedColor = HexColor.fromHex("e44c53");

  /// Text color ///
  static const Color textColorPrimary = Color(0xFF000000);
  static const Color textColorSecondary = Color(0xFF8A8A8A);
  static const Color textColorLink = Color(0xFF3F60DA);
  static const Color textColorPrice = Color(0xFF000000);

  /// Rating color ///
  static Color singleStarColor = HexColor.fromHex("E51A1A");
  static Color twoStarColor = HexColor.fromHex("E91E63");
  static Color threeStarColor = HexColor.fromHex("FFA100");
  static Color fourStarColor = HexColor.fromHex("FFCC00");
  static Color fiveStarColor = HexColor.fromHex("6BC700");

  static Color discountColor = HexColor.fromHex("6BC700");
  static Color outOfStockColor = HexColor.fromHex("FF4848");
  static const Color lightPrimaryColor1 = Color(0xFFF3E5F5);

  /// Icon color ///
  static const Color darkIconColorPrimary = Color(0xFFFFFFFF);
  static const Color lightIconColorPrimary = Color(0xFF000000);
  static const Color darkIconColorSecondary = Color(0xFFFFFFFF);
  static const Color lightIconColorSecondary = Color(0xFF000000);

  /// Bg color ///
  static const Color darkScaffoldBgColor = Colors.black12;
  static const Color lightScaffoldBgColor = Color(0xFFFFFFFF);
  static const Color lightAppBarBgColor = Color(0xFFFFFFFF);
  static const Color darkAppBarBgColor = Color(0xFF000000);
}

class AppColorsDark {
  /// Text color ///
  static const Color textColorPrimary = Color(0xFFFFFFFF);
  static const Color textColorSecondary = Color(0xFFFFFFFF);
  static const Color textColorLink = Color(0xFF3F60DA);
  static const Color textColorPrice = Color(0xFF000000);

  /// icon color ///
  static const Color iconColorPrimary = Color(0xFFFFFFFF);
  static const Color iconColorSecondary = Color(0xFFFFFFFF);
}

class AppImages {
  //================Icons==================//
  static const googleIcon = "assets/icons/ic_google.png";
  static const facebookIcon = "assets/icons/ic_facebook.png";
  static const appleIcon = "assets/icons/ic_apple.png";
  static const appleIconDark = "assets/icons/ic_apple_dark.png";
  static const settingsIcon = "assets/icons/settings.png";
  static const translationIcon = "assets/icons/translation.png";
  static const loginIcon = "assets/icons/login.png";
  static const accountIcon = "assets/icons/account.png";
  static const accountInfoIcon = "assets/icons/account_information.svg";
  static const addressIcon = "assets/icons/address_book.svg";
  static const dashboardIcon = "assets/icons/dashboard.png";
  static const logoutIcon = "assets/icons/logout.png";
  static const ordersIcon = "assets/icons/orders.svg";
  static const wishlistsIcon = "assets/icons/wishlist.svg";
  static const cancelIcon = "assets/icons/close.png";
  static const deleteIcon = "assets/icons/ic_delete.png";

  //==============Lottie Assets============//
  static const fingerPrintLottie = "assets/lottie/finger_print.json";
  static const emptyAddressLottie = "assets/lottie/empty_address.json";
  static const emptyCartLottie = "assets/lottie/empty_cart.json";
  static const emptyOrderLottie = "assets/lottie/empty_order_list.json";
  static const emptyWishlistLottie = "assets/lottie/empty_wishlist.json";

  //=============Images===============//
  static const appIcon = "assets/images/appIcon.png";
  static const splashScreen = "assets/images/splash_screen.png";
  static const splashLogo = "assets/images/splashlogo.svg";
  static const placeholder = "assets/images/placeholder.png";
  static const newPlaceholder = "assets/images/placeholder.svg";
  static const bannerImage = "assets/images/customer_banner_placeholder.png";
  static const threeDIcon = "assets/images/ic_3d_icon.png";
  static const statusIcon = "assets/images/ic_status.png";
  static const walletIcon = "assets/images/wallet_icon.png";
  static const loginLogo = "assets/images/Logo.svg";
  static const homeBg = "assets/images/home_bg.png";
  static const splashBgVideo = "assets/images/splashbg.mp4";

}
