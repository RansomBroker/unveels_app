/*
 *


 *
 * /
 */

//============================Map Keys==============================//

import '../models/checkout/shipping_info/shipping_address_model.dart';
import '../models/order_details/order_detail_model.dart';

const addressKey = "address";
const shippingMethodKey = 'shippingMethod';
const shippingIdKey = "shippingId";
const shippingAddressIdKey = "shippingAddressId";
const customerIdKey = "customerId";
const catalogIdKey = "catalogId";
const categoryIdKey = "categoryId";
const catalogNameKey = "catalogName";
const catalogTypeKey = "catalogType";
const urlKey = 'url';
const fromHomePageKey = "fromHomePage";
const productIdKey = "productId";
const productNameKey = "productName";
const subCategoryListKey = "subCategoryList";
const addressEndpointKey = "addressEndpoint";
const productData = "productData";
const reviewData = "reviewData";
const categoryNameKey = "categoryName";
const fromNotificationKey = "fromNotification";
const domainKey = "domain";
const productBloc = "productBloc";
const categoryId = "catalogId";
const productCategoryTypeKey = "productCategoryType";
const labelKey = "label";
const comment = "comment";
const isShippingRequired = "isShippingRequired";
const cmsPageId = "cmsPageId";                    
const cmsPageTitle = "cmsPageTitle";
const isFromCartForLogin = "isFromCartForLogin";
const isFromCartForSignup = "isFromCartForSignup";
const guestShippingData = "guestShippingData";
const guestShippingFunction = "guestShippingFunction";
const isForGuestShippingAddress = "isForGuestShippingAddress";
const isGuestCheckout = "isGuestCheckout";
const orderId = "orderId";
const boyId = "boyId";
const address = "address";
const addressId = "addressId";
const isDefaultAddress = "isDefaultAddress";
const informationId = "informationId";
const isCheckout = "isCheckout";
const isVirtualKey = "isVirtual";

// const orderDetailModel = "orderDetailModel";

const BUNDLE_KEY_CATALOG_TYPE_CATEGORY = "category";
const BUNDLE_KEY_CATALOG_TYPE_SEARCH = "search";
const BUNDLE_KEY_CATALOG_TYPE_CUSTOM_CAROUSEL = "customCarousel";
const BUNDLE_KEY_CATALOG_TYPE_CUSTOM_COLLECTION = "customCollection";
const BUNDLE_KEY_CATALOG_TYPE_ADV_SEARCH = "advSearch";

//===============================================================//

/*
* Method  will return the attribute which will be passed to product detail page at any product click event
*
* */
Map<String, dynamic> getProductDataAttributeMap(
    String? productName, String? productId) {
  Map<String, dynamic> args = {};
  args[productNameKey] = productName;
  args[productIdKey] = productId;
  return args;
}

Map<String, dynamic> categoryMap(int id, String label, String? type,
    [bool fromHomePage = false]) {
  var args = <String, dynamic>{};
  args[categoryId] = id;
  args[labelKey] = label;
  args[catalogTypeKey] = type ?? "";
  args[fromHomePageKey] = fromHomePage;
  return args;
}

Map<String, dynamic> getCatalogMap(String catalogId, String catalogName, String? type, bool fromNotification,{String? category_id,}) {
  Map<String, dynamic> args = {};
  args[catalogIdKey] = catalogId;
  args[categoryIdKey] = category_id;
  args[catalogTypeKey] = type;
  args[catalogNameKey] = catalogName;
  args[fromNotificationKey] = fromNotification;
  return args;
}

Map<String, dynamic> getCheckoutMap(
    String shippingMethod, ShippingAddressModel? address, {bool isVirtual = false}) {
  Map<String, dynamic> args = {};
  args[shippingMethodKey] = shippingMethod;
  args[addressKey] = address;
  args[isVirtualKey] = isVirtual;
  return args;
}

Map<String, dynamic> getSignInSignUpPageArgument(
    bool isLoginCall, bool isRegisterCall) {
  Map<String, dynamic> args = {};
  args[isFromCartForLogin] = isLoginCall;
  args[isFromCartForSignup] = isRegisterCall;
  return args;
}

Map<String, dynamic>? getCmsPageArguments(String id, String title) {
  Map<String, dynamic> args = {};
  args[cmsPageId] = id;
  args[cmsPageTitle] = title;
  return args;
}

Map<String, dynamic>? getNotificationArguments(String accountType, String senderId) {
  Map<String, dynamic> args = {};
  args[accountType] = accountType;
  args[senderId] = senderId;
  return args;
}

