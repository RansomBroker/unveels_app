/*
 *


 *
 * /
 */

import 'dart:collection';
import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/helper/preferences.dart';

import '../models/address/address_form_data.dart';
import '../models/dashboard/UserDataModel.dart';

final appStoragePref = AppStoragePref();

class AppStoragePref {
  var customerStorage =
      GetStorage("customerStorage"); //-----Use only for user specific data

  var configurationStorage = GetStorage(
      "configurationStorage"); //-----Use only for user app configuration data

  var priceFormatStorage = GetStorage(
      "priceFormatStorage"); //-----Use only for user app configuration data

  init() async {
    await GetStorage.init("customerStorage");
    await GetStorage.init("configurationStorage");
    await GetStorage.init("priceFormatStorage");
    return true;
  }

  /// configuration storage start

  String getWebsiteId() {
    return configurationStorage.read(Preferences.WEBSITE_ID) ??
        AppConstant.defaultWebsiteId;
  }

  setWebsiteId(String websiteId) {
    configurationStorage.write(Preferences.WEBSITE_ID, websiteId);
  }

  String getWebsiteUrl() {
    return configurationStorage.read(Preferences.WEBSITE_URL) ??
        ApiConstant.webUrl;
  }

  setWebsiteUrl(String websiteUrl) {
    configurationStorage.write(Preferences.WEBSITE_URL, websiteUrl);
  }

  String getStoreId() {
    return configurationStorage.read(Preferences.STORE_ID) ??
        AppConstant.defaultStoreId;
  }

  setStoreId(String storeId) {
    configurationStorage.write(Preferences.STORE_ID, storeId);
  }

  String get getStoreCode =>
      configurationStorage.read(Preferences.STORE_CODE) ??
      AppConstant.defaultStoreCode;

  setStoreCode(String code) {
    configurationStorage.write(Preferences.STORE_CODE, code);
  }

  setWatchEnabled(bool value) {
    configurationStorage.write(Preferences.KEY_WATCH_ENABLED, value);
  }

  bool getWatchEnabled() {
    return configurationStorage.read(Preferences.KEY_WATCH_ENABLED) ?? false;
  }

  String getCurrencyCode() {
    return configurationStorage.read(Preferences.CURRENCY_CODE) ?? "";
  }

  setCurrencyCode(String? value) {
    configurationStorage.write(Preferences.CURRENCY_CODE, value);
  }

  String getCurrencyLabel() {
    return configurationStorage.read(Preferences.CURRENCY_LABEL) ??
        AppConstant.defaultCurrency;
  }

  setCurrencyLabel(String? value) {
    configurationStorage.write(Preferences.CURRENCY_LABEL, value);
  }

  String getDeviceId() {
    return configurationStorage.read(Preferences.DEVICE_ID) ?? "";
  }

  setDeviceId(String? value) {
    configurationStorage.write(Preferences.DEVICE_ID, value);
  }

  setFingerPrintUser(String savedKey) {
    configurationStorage.write(Preferences.FINGER_PRINT_USER, savedKey);
  }

  String? getFingerPrintUser() {
    return configurationStorage.read(Preferences.FINGER_PRINT_USER) ?? "";
  }

  setFingerPrintPassword(String savedKey) {
    configurationStorage.write(Preferences.FINGER_PRINT_PASSWORD, savedKey);
  }

  String? getFingerPrintPassword() {
    return configurationStorage.read(Preferences.FINGER_PRINT_PASSWORD) ?? "";
  }

  /// Settings starts

  setTheme(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(Preferences.THEME_KEY, value);
  }

  getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(Preferences.THEME_KEY) ?? "";
  }

  setAllowAllNotifications(bool value) {
    configurationStorage.write(Preferences.KEY_ALLOW_ALL_NOTIFICATION, value);
  }

  bool getAllowAllNotifications() {
    return configurationStorage.read(Preferences.KEY_ALLOW_ALL_NOTIFICATION) ??
        true;
  }

  setAllowOrderNotifications(bool value) {
    configurationStorage.write(Preferences.KEY_ALLOW_ORDER_NOTIFICATION, value);
  }

  bool getAllowOrderNotifications() {
    return configurationStorage
            .read(Preferences.KEY_ALLOW_ORDER_NOTIFICATION) ??
        true;
  }

  setAllowOfferNotifications(bool value) {
    configurationStorage.write(Preferences.KEY_ALLOW_OFFER_NOTIFICATION, value);
  }

  bool getAllowOfferNotifications() {
    return configurationStorage
            .read(Preferences.KEY_ALLOW_OFFER_NOTIFICATION) ??
        true;
  }

  setShowRecentProduct(bool value) {
    configurationStorage.write(Preferences.KEY_SHOW_RECENT_PRODUCT, value);
  }

  bool getShowRecentProduct() {
    return configurationStorage.read(Preferences.KEY_SHOW_RECENT_PRODUCT) ??
        true;
  }

  setShowSearchTag(bool value) {
    configurationStorage.write(Preferences.KEY_SHOW_SEARCH_TAG, value);
  }

  bool getShowSearchTag() {
    return configurationStorage.read(Preferences.KEY_SHOW_SEARCH_TAG) ?? true;
  }

  /// Settings End

  ///Theme data start

  setAppLogo(String value) {
    configurationStorage.write(Preferences.KEY_APP_LOGO_URL, value);
  }

  String getAppLogo() {
    return configurationStorage.read(Preferences.KEY_APP_LOGO_URL) ?? "";
  }

  setAppLogoDark(String value) {
    configurationStorage.write(Preferences.KEY_APP_LOGO_URL_DARK, value);
  }

  String getAppLogoDark() {
    return configurationStorage.read(Preferences.KEY_APP_LOGO_URL_DARK) ?? "";
  }

  setSplashScreen(String value) {
    configurationStorage.write(Preferences.KEY_SPLASH_SCREEN_URL, value);
  }

  String getSplashScreen() {
    return configurationStorage.read(Preferences.KEY_SPLASH_SCREEN_URL) ?? "";
  }

  setSplashScreenDark(String value) {
    configurationStorage.write(Preferences.KEY_SPLASH_SCREEN_URL_DARK, value);
  }

  String getSplashScreenDark() {
    return configurationStorage.read(Preferences.KEY_SPLASH_SCREEN_URL_DARK) ??
        "";
  }

  setIsTabCategoryView(bool value) {
    configurationStorage.write(Preferences.KEY_CATEGORY_TYPE, value);
  }

  bool getIsTabCategoryView() {
    return configurationStorage.read(Preferences.KEY_CATEGORY_TYPE) ?? true;
  }

  /// Theme data end

  /// configuration storage end

  /// configuration Price start

  setPricePattern(String savedKey) {
    priceFormatStorage.write(Preferences.PRICE_PATTERN, savedKey);
  }

  String? getPricePattern() {
    return priceFormatStorage.read(Preferences.PRICE_PATTERN);
  }

  setPrecision(int savedKey) {
    priceFormatStorage.write(Preferences.PRICE_PRECISION, savedKey);
  }

  int? getPrecision() {
    return priceFormatStorage.read(Preferences.PRICE_PRECISION);
  }

  /// configuration Price end

  bool showWalkThrough() {
    return configurationStorage.read(Preferences.SHOW_WALKTHROUGH) ?? true;
  }

  setShowWalkThrough(bool? value) {
    configurationStorage.write(Preferences.SHOW_WALKTHROUGH, value);
  }

  String? getWalkThroughVersion() {
    return configurationStorage.read(Preferences.WALKTHROUGH_VERSION) ?? "";
  }

  setWalkThroughVersion(String savedKey) {
    configurationStorage.write(Preferences.WALKTHROUGH_VERSION, savedKey);
  }

  /// configuration storage start

  bool isLoggedIn() {
    return customerStorage.read(Preferences.IS_LOGGED_IN) ?? false;
  }

  setIsLoggedIn(bool? value) {
    customerStorage.write(Preferences.IS_LOGGED_IN, value);
  }

  String getCustomerToken() {
    return customerStorage.read(Preferences.CUSTOMER_TOKEN) ?? "";
  }

  setCustomerToken(String? value) {
    customerStorage.write(Preferences.CUSTOMER_TOKEN, value ?? "");
  }

  String getBearerToken() {
    return customerStorage.read(Preferences.Bearer_TOKEN) ?? "";
  }

  String getBearerTokenCheck() {
    return getBearerToken().isNotEmpty
        ? "Bearer ${customerStorage.read(Preferences.Bearer_TOKEN)}"
        : "";
  }

  setBearerToken(String? value) {
    customerStorage.write(Preferences.Bearer_TOKEN, value ?? "");
  }

  int getQuoteId() {
    return customerStorage.read(Preferences.QUOTE_ID) ?? 0;
  }

  setQuoteId(int? value) {
    customerStorage.write(Preferences.QUOTE_ID, value ?? 0);
  }

  UserDataModel? getUserData() {
    var userMap = customerStorage.read(Preferences.USER_DATA);
    if (userMap != null) {
      return UserDataModel.fromJson(userMap);
    }
    return null;
  }

  setUserData(UserDataModel? userDataModel) {
    customerStorage.write(Preferences.USER_DATA, userDataModel?.toJson());
  }

  AddressDataModel? getUserAddressData() {
    var userMap = customerStorage.read(Preferences.USER_ADDRESS_DATA);
    if (userMap != null) {
      return AddressDataModel.fromJson(userMap);
    }
    return null;
  }

  setUserAddressData(AddressDataModel? addressDataModel) {
    customerStorage.write(
        Preferences.USER_ADDRESS_DATA, addressDataModel?.toJson());
  }

  int getCartCount() {
    return customerStorage.read(Preferences.CART_COUNT) ?? 0;
  }

  setCartCount(var value) {
    customerStorage.write(Preferences.CART_COUNT, value);
  }

  String getCartId() {
    return customerStorage.read(Preferences.CART_Id) ?? "0";
  }

  setCartId(var value) {
    customerStorage.write(Preferences.CART_Id, value);
  }

  logoutUser() {
    customerStorage.erase();
  }

  UserDataModel? getNewAddressData() {
    var userMap = customerStorage.read(Preferences.USER_DATA);
    if (userMap != null) {
      return UserDataModel.fromJson(userMap);
    }
    return null;
  }

  setNewAddressData(UserDataModel? userDataModel) {
    customerStorage.write(Preferences.USER_DATA, userDataModel?.toJson());
  }

  bool isDarkMode() {
    return customerStorage.read(Preferences.IS_DARK_MODE) ?? false;
  }

  setIsDarkMode(bool? value) {
    customerStorage.write(Preferences.IS_DARK_MODE, value);
  }
  bool isFirstTime() {
    return customerStorage.read(Preferences.IS_FirstTime) ?? false;
  }

  setFirstTime(bool? value) {
    customerStorage.write(Preferences.IS_FirstTime, value);
  }

  /// configuration storage end
}
