/*
 *


 *
 * /
 */

import 'dart:developer';
import 'dart:io';

import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:test_new/unvells/helper/app_storage_pref.dart';
import 'package:test_new/unvells/models/address/address_form_data.dart';
import 'package:test_new/unvells/models/base_model.dart';
import 'package:test_new/unvells/models/catalog/sorting_data.dart';
import 'package:test_new/unvells/models/login_signup/login_response_model.dart';
import 'package:test_new/unvells/models/login_signup/signup_response_model.dart';
import 'package:test_new/unvells/models/wallet_extension_models/view_transaction_model.dart';
import 'package:test_new/unvells/models/wishlist/wishlist_movecart_response_model.dart';

import '../constants/app_constants.dart';
import '../models/DeliveryboyLocationDetails/deliveryboy_location_details_model.dart';
import '../models/account_info/account_info_model.dart';
import '../models/address/cities_model.dart';
import '../models/cart/add_gift_to_cart_response.dart';
import '../models/cart/cart_details_model.dart';
import '../models/cart/customer_cart_model.dart';
import '../models/catalog/catalog_model.dart';
import '../models/categoryPage/category_page_response.dart';
import '../models/address/add_address_request.dart';
import '../models/address/get_address.dart';
import '../models/checkout/payment_info/payment_info_model.dart';
import '../models/checkout/place_order/billing_data_request.dart';
import '../models/checkout/place_order/place_order_model.dart';
import '../models/checkout/shipping_info/shipping_address_model.dart';
import '../models/checkout/shipping_info/shipping_methods_model.dart';
import '../models/cms_page/cms_page_model.dart';
import '../models/compare_products/compare_product_model.dart';
import '../models/deliveryBoyDetails/delivery_boy_details_model.dart';
import '../models/download_product/download_product.dart';
import '../models/downloadable_products/downloadable_products_list_model.dart';
import '../models/guestView/guestView.dart';
import '../models/homePage/add_to_wishlist_response.dart';
import '../models/homePage/home_screen_model.dart';
import '../models/invoice_view/invoice_view_model.dart';
import '../models/login_signup/sign_up_screen_model.dart';
import '../models/lookBook/look_book_model.dart';
import '../models/notifications/notification_screen_model.dart';
import '../models/order_details/order_detail_model.dart';
import '../models/order_list/order_list_model.dart';
import '../models/orders_and_returns/orders_and_returns_model.dart';
import '../models/printInvoiceView/print_invoice_model.dart';
import '../models/productDetail/add_to_cart_response.dart';
import '../models/productDetail/product_detail_page_model.dart';
import '../models/productDetail/product_new_model.dart';
import '../models/refund_view/refund_view_model.dart';
import '../models/reviews/rating_form_data_model.dart';
import '../models/reviews/review_details_model.dart';
import '../models/reviews/reviews_list_model.dart';
import '../models/search/advance_search_model.dart';
import '../models/search/search_screen_model.dart';
import '../models/shipment_view/shipment_view_model.dart';
import '../models/walk_through/walk_through_model.dart';
import '../models/wallet_extension_models/account_details_model.dart';
import '../models/wallet_extension_models/add_account_form_model.dart';
import '../models/wallet_extension_models/transaction_history_model.dart';
import '../models/wallet_extension_models/wallet_dashboard_model.dart';
import '../models/wishlist/wishlist_addallcart_response_model.dart';
import '../models/wishlist/wishlist_model.dart';
import 'graph_ql.dart';
import 'mutation_query.dart';

typedef Parser<T> = T Function(Map<String, dynamic> json);

class ApiClient {
  GraphQlApiCalling client = GraphQlApiCalling();
  MutationsData mutation = MutationsData();

  T? handleResponse<T>(
    QueryResult<Object?> result,
    String operation,
    Parser<T> parser, {
    bool? ignoreException = false,
  }) {
    /// Log response

    log("RESPONSE_DATA ----------------------------> ${result.data}");
    log("linkException ----------------------------> ${result.exception?.linkException.toString()}");

    final debugMessage = result
        .exception?.graphqlErrors.firstOrNull?.extensions?['debugMessage'];
    Map<String, dynamic>? data = {};
    if (result.hasException) {
      data.putIfAbsent("success", () => false);
      if (debugMessage != null) {
        data.putIfAbsent("message", () => debugMessage);
        log("debugMessage=>" + debugMessage);
      }

      if (ignoreException == true) {
        data = result.data![operation];
      }
    } else {
      data = result.data![operation];
      data?.putIfAbsent("success", () => true);
      data?.putIfAbsent("responseStatus", () => true);
    }
    return parser(data ?? {});
  }

  ///Get Home Page Data
  Future<HomePageData?> getHomePageData(bool isRefresh) async {
    var response = await (client.clientToQuery()).query(QueryOptions(
      cacheRereadPolicy: isRefresh
          ? CacheRereadPolicy.mergeOptimistic
          : CacheRereadPolicy.mergeOptimistic,
      fetchPolicy:
          isRefresh ? FetchPolicy.noCache : FetchPolicy.cacheAndNetwork,
      document: gql(
        mutation.homePageData(
            appStoragePref.getWebsiteId(),
            appStoragePref.getStoreId(),
            appStoragePref.getCurrencyCode(),
            (AppSizes.deviceWidth.toInt()).toString(),
            appStoragePref.getCustomerToken(),
            appStoragePref.getQuoteId()),
      ),
    ));
    return handleResponse(
      response,
      'homePageData',
      (json) => HomePageData.fromJson(json),
    );
  }

  ///Get Category Page Data
  Future<CategoryPageResponse?> getCategoryPageData(int categoryId) async {
    var response = await (client.clientToQuery()).query(QueryOptions(
      cacheRereadPolicy: CacheRereadPolicy.mergeOptimistic,
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      document: gql(
        mutation.categoryPageData(appStoragePref.getStoreId(), categoryId),
      ),
    ));
    return handleResponse(
      response,
      'categoryPageData',
      (json) => CategoryPageResponse.fromJson(json),
    );
  }

  ///Get Product Collection Data
  Future<CatalogModel?> getProductCollectionData(
      String type,
      String id,
      int page,
      List<Map<String, String>> filterData,
      Map<String, String>? sortData) async {
    var response = await (client.clientToQuery()).query(QueryOptions(
      cacheRereadPolicy: CacheRereadPolicy.mergeOptimistic,
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      document: gql(
        mutation.productCollection(
          appStoragePref.getStoreId(),
          appStoragePref.getCurrencyCode(),
          type,
          id,
          filterData,
          sortData,
          page,
        ),
      ),
    ));
    return handleResponse(
      response,
      'productCollection',
      (json) => CatalogModel.fromJson(json),
    );
  }

  ///Get Search suggestion Data
  Future<SearchScreenModel?> getSearchSuggestionData(String searchQuery) async {
    var response = await (client.clientToQuery()).query(QueryOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.searchSuggestion(appStoragePref.getStoreId(), searchQuery,
            appStoragePref.getCurrencyCode()),
      ),
    ));
    return handleResponse(
      response,
      'searchSuggestion',
      (json) => SearchScreenModel.fromJson(json),
    );
  }

  ///Get Advance Search form Data
  Future<AdvanceSearchModel?> getAdvancedSearchFormData() async {
    var response = await (client.clientToQuery()).query(QueryOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.advancedSearchFormData(appStoragePref.getStoreId()),
      ),
    ));
    return handleResponse(
      response,
      'advancedSearchFormData',
      (json) => AdvanceSearchModel.fromJson(json),
    );
  }

  ///Get Create account form data
  Future<SignUpScreenModel?> createAccountFormData() async {
    var response = await (client.clientToQuery()).query(QueryOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.createAccountFormData(appStoragePref.getStoreId()),
      ),
    ));
    return handleResponse(
      response,
      'createAccountFormData',
      (json) => SignUpScreenModel.fromJson(json),
    );
  }

  ///Create account
  Future<SignupResponseModel?> createAccount(
      String prefix,
      String firstName,
      String middleName,
      String lastName,
      String suffix,
      String dob,
      String taxvat,
      String gender,
      String email,
      String password,
      String mobile,
      String token,
      int isSocial) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.createAccount(
            appStoragePref.getWebsiteId(),
            appStoragePref.getStoreId(),
            Platform.isAndroid ? "android" : "iOS",
            token,
            appStoragePref.getQuoteId(),
            isSocial ?? 0,
            prefix,
            firstName,
            middleName,
            lastName,
            suffix,
            dob,
            taxvat,
            gender,
            email,
            password,
            mobile),
      ),
    ));
    return handleResponse(
      response,
      'createAccount',
      (json) => SignupResponseModel.fromJson(json),
    );
  }

  ///Customer Login
  Future<LoginResponseModel?> customerLogin(
    String email,
    String password,
    String token,
  ) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.customerLogin(
            appStoragePref.getWebsiteId(),
            appStoragePref.getStoreId(),
            email,
            password,
            token,
            appStoragePref.getQuoteId()),
      ),
    ));
    return handleResponse(
      response,
      'login',
      (json) => LoginResponseModel.fromJson(json),
    );
  }

  ///logout
  Future<BaseModel?> logout(String deviceToken) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.logout(appStoragePref.getStoreId(),
            appStoragePref.getCustomerToken(), deviceToken),
      ),
    ));
    return handleResponse(
      response,
      'logout',
      (json) => BaseModel.fromJson(json),
    );
  }

  ///forgot password
  Future<BaseModel?> forgotPassword(String email) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.forgotPassword(
            appStoragePref.getWebsiteId(), appStoragePref.getStoreId(), email),
      ),
    ));
    return handleResponse(
      response,
      'forgotPassword',
      (json) => BaseModel.fromJson(json),
    );
  }

  ///Get Notification list
  Future<NotificationScreenModel?> getNotificationList() async {
    var response = await (client.clientToQuery()).query(QueryOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.notificationList(
          appStoragePref.getStoreId(),
          (AppSizes.deviceWidth.toInt()).toString(),
        ),
      ),
    ));
    return handleResponse(
      response,
      'notificationList',
      (json) => NotificationScreenModel.fromJson(json),
    );
  }

  ///Get orders list
  Future<OrderListModel?> getOrderList(int pageNumber, int forDashboard) async {
    var response = await (client.clientToQuery()).query(QueryOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.getOrdersList(
          appStoragePref.getStoreId(),
          appStoragePref.getCustomerToken(),
          pageNumber,
          forDashboard,
        ),
      ),
    ));
    return handleResponse(
      response,
      'orderList',
      (json) => OrderListModel.fromJson(json),
    );
  }

  ///Get Review list
  Future<ReviewsListModel?> getReviewList(
      int pageNumber, int forDashboard) async {
    var response = await (client.clientToQuery()).query(QueryOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.reviewList(
          appStoragePref.getStoreId(),
          appStoragePref.getCustomerToken(),
          pageNumber,
          forDashboard,
        ),
      ),
    ));
    return handleResponse(
      response,
      'reviewList',
      (json) => ReviewsListModel.fromJson(json),
    );
  }

  ///Get Review Details
  Future<ReviewDetailsModel?> getReviewDetails(String reviewId) async {
    var response = await (client.clientToQuery()).query(QueryOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.reviewDetails(
          appStoragePref.getStoreId(),
          appStoragePref.getCustomerToken(),
          int.parse(reviewId),
        ),
      ),
    ));
    return handleResponse(
      response,
      'reviewDetails',
      (json) => ReviewDetailsModel.fromJson(json),
    );
  }

  ///Get Cart details
  Future<CartDetailsModel?> getCartDetails() async {
    var response = await (client.clientToQuery()).query(QueryOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.cartDetails(
            appStoragePref.getStoreId(),
            appStoragePref.getCurrencyCode(),
            appStoragePref.getCustomerToken(),
            appStoragePref.getQuoteId()),
      ),
    ));
    return handleResponse(
      response,
      'cartDetails',
      (json) => CartDetailsModel.fromJson(json),
    );
  }

  Future<CustomerCartData?> getCustomerCart() async {
    var response = await (client.clientToQuery()).query(QueryOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.customerCart(),
      ),
    ));
    return handleResponse(
      response,
      'customerCart',
      (json) => CustomerCartData.fromJson(json),
    );
  }

  ///Empty cart
  Future<BaseModel?> emptyCart() async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.emptyCart(
          appStoragePref.getStoreId(),
          appStoragePref.getCustomerToken(),
          appStoragePref.getQuoteId(),
        ),
      ),
    ));
    return handleResponse(
      response,
      'emptyCart',
      (json) => BaseModel.fromJson(json),
    );
  }

  ///Remove cart item
  Future<BaseModel?> removeCartItem(String itemId) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.removeCartItem(
          appStoragePref.getStoreId(),
          appStoragePref.getCustomerToken(),
          appStoragePref.getQuoteId(),
          itemId,
        ),
      ),
    ));
    return handleResponse(
      response,
      'removeCartItem',
      (json) => BaseModel.fromJson(json),
    );
  }

  ///Remove cart item
  Future<BaseModel?> wishlistToCart(String itemId) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.removeCartItem(
          appStoragePref.getStoreId(),
          appStoragePref.getCustomerToken(),
          appStoragePref.getQuoteId(),
          itemId,
        ),
      ),
    ));
    return handleResponse(
      response,
      'removeCartItem',
      (json) => BaseModel.fromJson(json),
    );
  }

  ///wishlist From Cart
  Future<BaseModel?> wishlistFromCart(
    String itemId,
    String productId,
    String qty,
  ) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.wishlistFromCart(
          appStoragePref.getStoreId(),
          appStoragePref.getCustomerToken(),
          itemId,
          productId,
          qty,
        ),
      ),
    ));
    return handleResponse(
      response,
      'wishlistFromCart',
      (json) => BaseModel.fromJson(json),
    );
  }

  /// Get WishList
  Future<WishlistModel?> getWishlist(int pageNumber) async {
    var response = await (client.clientToQuery()).query(QueryOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.wishList(
            int.parse(appStoragePref.getStoreId()),
            appStoragePref.getCustomerToken().toString(),
            appStoragePref.getCurrencyCode(),
            pageNumber),
      ),
    ));
    return handleResponse(
      response,
      'wishlist',
      (json) => WishlistModel.fromJson(json),
    );
  }

  // (int storeId, int websiteId, String customerToken, String email, String message

  ///  Wishlist Sharing
  Future<BaseModel?> shareWishList(String email, String message) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.shareWishlist(
            int.parse(appStoragePref.getStoreId()),
            int.parse(appStoragePref.getWebsiteId()),
            appStoragePref.getCustomerToken(),
            email,
            message),
      ),
    ));
    return handleResponse(
      response,
      'shareWishlist',
      (json) => BaseModel.fromJson(json),
    );
  }

  ///  Wishlist MoveToCart
  Future<WishlistMovecartResponseModel?> moveToCart(
      int itemId, int productId, int qty) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.moveToCart(int.parse(appStoragePref.getStoreId()),
            appStoragePref.getCustomerToken(), itemId, productId, qty),
      ),
    ));
    return handleResponse(
      response,
      'wishlistToCart',
      (json) => WishlistMovecartResponseModel.fromJson(json),
    );
  }

  ///  Wishlist AddAllToCart
  Future<WishlistAddallcartResponseModel?> allToCart(
      List<Map<String, String>> itemData) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.allToCart(
            int.parse(appStoragePref.getStoreId()),
            int.parse(appStoragePref.getWebsiteId()),
            appStoragePref.getCustomerToken(),
            itemData ?? []),
      ),
    ));
    return handleResponse(
      response,
      'allToCart',
      (json) => WishlistAddallcartResponseModel.fromJson(json),
    );
  }

  /// Remove wishlist
  Future<BaseModel?> removeFromWishlist(String itemId) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.removeFromWishlist(
            int.parse(appStoragePref.getStoreId()),
            int.parse(appStoragePref.getWebsiteId()),
            appStoragePref.getCustomerToken(),
            itemId),
      ),
    ));
    return handleResponse(
      response,
      'removeFromWishlist',
      (json) => WishlistAddallcartResponseModel.fromJson(json),
    );
  }

  /// Add to wishlist
  Future<AddToWishlistResponse?> addToWishlist(String productId) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.addToWishlist(int.parse(appStoragePref.getStoreId()),
            appStoragePref.getCustomerToken(), productId),
      ),
    ));
    return handleResponse(
      response,
      'addToWishlist',
      (json) => AddToWishlistResponse.fromJson(json),
    );
  }

  /// Get Address List
  Future<GetAddress?> getAddressData(int forDashboard) async {
    var response = await (client.clientToQuery()).query(QueryOptions(
        cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
        fetchPolicy: FetchPolicy.noCache,
        document: gql(
          mutation.addressBookData(int.parse(appStoragePref.getStoreId()),
              appStoragePref.getCustomerToken().toString(), forDashboard),
        )));
    return handleResponse(
      response,
      'addressBookData',
      (json) => GetAddress.fromJson(json),
    );
  }

  /// Get cities List
  Future<List<GetCitiesByRegion>?> getCitiesByRegion(
      {required int regionId}) async {
    var response = await (client.clientToQuery()).query(QueryOptions(
        cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
        fetchPolicy: FetchPolicy.noCache,
        document: gql(
          mutation.getCitiesByRegion(region_id: regionId),
        )));
    return handleResponse(
      response,
      'data',
      (json) {
        List<GetCitiesByRegion> cities = [];
        for (var item in response.data!['getCitiesByRegion']) {
          cities.add(GetCitiesByRegion.fromJson(item));
        }

        return cities;
      },
    );
  }

  /// Address Form Data
  Future<CheckoutAddressFormDataModel?> checkoutAddressFormData(
      String addressId) async {
    var response = await (client.clientToQuery()).query(QueryOptions(
        cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
        fetchPolicy: FetchPolicy.noCache,
        document: gql(
          mutation.checkoutAddressFormData(
              int.parse(appStoragePref.getStoreId()),
              appStoragePref.getCustomerToken().toString(),
              (addressId != "") ? addressId : "0"),
        )));
    return handleResponse(
      response,
      'checkoutAddressFormData',
      (json) => CheckoutAddressFormDataModel.fromJson(json),
    );
  }

  /// Delete Address
  Future<BaseModel?> deleteAddress(String addressId) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.deleteAddress(addressId, appStoragePref.getCustomerToken()),
      ),
    ));
    return handleResponse(
      response,
      'deleteAddress',
      (json) => BaseModel.fromJson(json),
    );
  }

  /// Save Address
  Future<BaseModel?> saveAddress(
      String addressId, AddAddressRequest addAddressRequest) async {
    print("TEST_LOG--> ${addAddressRequest.street}");
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.saveAddress(
          int.parse(appStoragePref.getStoreId()),
          addressId != "" ? addressId : "0",
          appStoragePref.getCustomerToken(),
          addAddressRequest.firstName ?? "",
          addAddressRequest.lastName ?? "",
          addAddressRequest.city ?? "",
          addAddressRequest.regionName ?? "",
          addAddressRequest.telephone ?? "",
          addAddressRequest.postcode ?? "",
          addAddressRequest.region_id ?? "",
          addAddressRequest.country_id ?? "",
          ((addAddressRequest.street ?? []).isNotEmpty)
              ? "${addAddressRequest.street?[0]}"
              : "",
          ((addAddressRequest.street ?? []).length > 1)
              ? "${addAddressRequest.street?[1]}"
              : "",
          ((addAddressRequest.street ?? []).length > 2)
              ? "${addAddressRequest.street?[2]}"
              : "",
          addAddressRequest.default_billing ?? 0,
          addAddressRequest.default_shipping ?? 0,
          addAddressRequest.company,
          addAddressRequest.address_title,
          addAddressRequest.apt_number,
          addAddressRequest.building_name,
          addAddressRequest.floor,
          addAddressRequest.avenue,
          addAddressRequest.city_id

          // addAddressRequest
        ),
      ),
    ));
    return handleResponse(
      response,
      'saveAddress',
      (json) => BaseModel.fromJson(json),
    );
  }

  /// Order Details
  Future<OrderDetailModel?> getOrderDetails(String increementId) async {
    var response = await (client.clientToQuery()).query(QueryOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.orderDetails(
          int.parse(appStoragePref.getStoreId()),
          appStoragePref.getCustomerToken(),
          increementId,
        ),
      ),
    ));
    return handleResponse(
      response,
      'orderDetails',
      (json) => OrderDetailModel.fromJson(json),
    );
  }

  /// Invoice View
  Future<InvoiceViewModel?> getInvoiceView(String invoiceId) async {
    var response = await (client.clientToQuery()).query(QueryOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.invoiceView(
          int.parse(appStoragePref.getStoreId()),
          appStoragePref.getCustomerToken(),
          invoiceId,
        ),
      ),
    ));
    return handleResponse(
      response,
      'invoiceView',
      (json) => InvoiceViewModel.fromJson(json),
    );
  }

  /// Shipment View
  Future<ShipmentViewModel?> getShipmentView(String shipmentId) async {
    var response = await (client.clientToQuery()).query(QueryOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.shipmentView(
          int.parse(appStoragePref.getStoreId()),
          appStoragePref.getCustomerToken(),
          shipmentId,
        ),
      ),
    ));
    return handleResponse(
      response,
      'shipmentView',
      (json) => ShipmentViewModel.fromJson(json),
    );
  }

  /// Checkout Address
  Future<ShippingAddressModel?> checkoutAddress() async {
    var response = await (client.clientToQuery()).query(QueryOptions(
        cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
        fetchPolicy: FetchPolicy.noCache,
        document: gql(
          mutation.checkoutAddress(
            int.parse(appStoragePref.getStoreId()),
            appStoragePref.getCustomerToken().toString(),
            appStoragePref.getQuoteId(),
          ),
        )));
    return handleResponse(
      response,
      'checkoutAddress',
      (json) => ShippingAddressModel.fromJson(json),
    );
  }

  /// Checkout Address
  Future<ShippingMethodsModel?> shippingMethods(
      String addressId, AddressDataModel addressDataModel) async {
    log("cutomattributes${addressDataModel.custom_attributes}");
    var response = await (client.clientToQuery()).query(QueryOptions(
        cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
        fetchPolicy: FetchPolicy.noCache,
        document: gql(
          mutation.shippingMethods(
              int.parse(appStoragePref.getStoreId()),
              appStoragePref.getCurrencyCode().toString(),
              appStoragePref.getCustomerToken().toString(),
              appStoragePref.getQuoteId(),
              addressId ?? '',
              "1",
              addressDataModel),
        )));
    return handleResponse(
      response,
      'shippingMethods',
      (json) => ShippingMethodsModel.fromJson(json),
    );
  }

  /// Review and payment
  Future<PaymentInfoModel?> reviewAndPayment(String shippingMethod) async {
    var response = await (client.clientToQuery()).query(QueryOptions(
        cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
        fetchPolicy: FetchPolicy.noCache,
        document: gql(
          mutation.reviewAndPayment(
              int.parse(appStoragePref.getStoreId()),
              appStoragePref.getCurrencyCode().toString(),
              appStoragePref.getCustomerToken().toString(),
              appStoragePref.getQuoteId(),
              shippingMethod),
        )));
    return handleResponse(
      response,
      'reviewAndPayment',
      (json) => PaymentInfoModel.fromJson(json),
    );
  }

  ///Place order
  Future<PlaceOrderModel?> placeOrder(String wallet, String paymentMethod,
      BillingDataRequest billingData, String token) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.placeOrder(
          appStoragePref.getStoreId(),
          wallet,
          appStoragePref.getCurrencyCode().toString(),
          appStoragePref.getCustomerToken(),
          appStoragePref.getQuoteId(),
          paymentMethod,
          appStoragePref.isLoggedIn() ? "customer" : "guest",
          Platform.isAndroid ? "android" : "iOS",
          billingData,
          appStoragePref.getUserAddressData() ?? AddressDataModel(),
          token,
        ),
      ),
    ));
    debugPrint(response.toString());
    return handleResponse(
      response,
      'placeOrder',
      (json) => PlaceOrderModel.fromJson(json),
    );
  }

  /// Product details
  Future<ProductDetailPageModel?> productPageData(String productId) async {
    var response = await (client.clientToQuery()).query(
      QueryOptions(
        cacheRereadPolicy: CacheRereadPolicy.mergeOptimistic,
        fetchPolicy: FetchPolicy.cacheAndNetwork,
        document: gql(
          mutation.productPageData(
            int.parse(appStoragePref.getStoreId()),
            appStoragePref.getCurrencyCode().toString(),
            int.parse(productId),
            appStoragePref.getCustomerToken(),
            AppStoragePref().getQuoteId(),
          ),
        ),
      ),
    );
    return handleResponse(
      response,
      'productPageData',
      (json) => ProductDetailPageModel.fromJson(json),
    );
  }

  /// Product details for is try on
  Future<ProductsNewModel?> productPageDataForNew(String sku) async {
    QueryResult<Object?> response = await (client.clientToQuery()).query(
      QueryOptions(
        cacheRereadPolicy: CacheRereadPolicy.mergeOptimistic,
        fetchPolicy: FetchPolicy.cacheAndNetwork,
        document: gql(
          mutation.productDetailsNewData(sku),
        ),
      ),
    );
    return handleResponse(response, 'products', (json) {
      Map<String, dynamic> fullJson = {
        'items': json['items'],
        'bssGetListTimezone': response.data!['bssGetListTimezone'],
      };
      return ProductsNewModel.fromJson(fullJson);
    }, ignoreException: true);
  }

  /// Product details prechache
  productPageDataPrecache(String productId) {
    print("==->${productId}");
    var response = (client.clientToQuery()).query(QueryOptions(
        cacheRereadPolicy: CacheRereadPolicy.mergeOptimistic,
        fetchPolicy: FetchPolicy.cacheAndNetwork,
        document: gql(
          mutation.productPageData(
              int.parse(appStoragePref.getStoreId()),
              appStoragePref.getCurrencyCode().toString(),
              int.parse(productId),
              appStoragePref.getCustomerToken(),
              AppStoragePref().getQuoteId()),
        )));
    print("----===>${response}");
  }

  /// Product detailsnew prechache
  productPageDataForNewPrecache(String sku) {
    print("==->${sku}");
    var response = (client.clientToQuery()).query(QueryOptions(
        cacheRereadPolicy: CacheRereadPolicy.mergeOptimistic,
        fetchPolicy: FetchPolicy.cacheAndNetwork,
        document: gql(
          mutation.productDetailsNewData(sku),
        )));
    print("----===>${response}");
  }

  /// Product Configurable Data
  Future<ProductDetailPageModel?> productConfigurableData(
      String productId) async {
    var response = await (client.clientToQuery()).query(QueryOptions(
        cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
        fetchPolicy: FetchPolicy.noCache,
        document: gql(
          mutation.productConfigurableData(
              int.parse(appStoragePref.getStoreId()),
              appStoragePref.getCurrencyCode().toString(),
              int.parse(productId),
              appStoragePref.getCustomerToken(),
              AppStoragePref().getQuoteId()),
        )));
    return handleResponse(
      response,
      'productPageData',
      (json) => ProductDetailPageModel.fromJson(json),
    );
  }

  /// Product Updated Data
  Future<ProductDetailPageModel?> getProductUpdatedData(
      String productId) async {
    var response = await (client.clientToQuery()).query(QueryOptions(
        cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
        fetchPolicy: FetchPolicy.noCache,
        document: gql(
          mutation.getProductUpdatedData(
              int.parse(appStoragePref.getStoreId()),
              appStoragePref.getCurrencyCode().toString(),
              int.parse(productId),
              appStoragePref.getCustomerToken(),
              AppStoragePref().getQuoteId()),
        )));
    return handleResponse(
      response,
      'productPageData',
      (json) => ProductDetailPageModel.fromJson(json),
    );
  }

  ///accountInfo
  Future<AccountInfoModel?> accountInfoData() async {
    var response = await (client.clientToQuery()).query(QueryOptions(
        cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
        fetchPolicy: FetchPolicy.noCache,
        document: gql(
          mutation.accountInfoData(
            int.parse(appStoragePref.getStoreId()),
            appStoragePref.getCustomerToken(),
          ),
        )));
    return handleResponse(
      response,
      'accountInfoData',
      (json) => AccountInfoModel.fromJson(json),
    );
  }

  ///ordersAndReturns
  Future<GuestView?> ordersAndReturnsData(String incrementId, String email,
      String lastName, String zipCode, String type) async {
    var response = await (client.clientToQuery()).query(QueryOptions(
        cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
        fetchPolicy: FetchPolicy.noCache,
        document: gql(
          mutation.ordersAndReturnsData(int.parse(appStoragePref.getStoreId()),
              incrementId, email, lastName, zipCode, type),
        )));
    return handleResponse(
      response,
      'guestView',
      (json) => GuestView.fromJson(json),
    );
  }

  ///addToCart
  Future<AddToCartResponse?> addToCart(
      String productId,
      int qty,
      Map<String, dynamic> productParamsJSON,
      List<dynamic> relatedProducts) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.addToCart(
            appStoragePref.getStoreId(),
            appStoragePref.getCustomerToken(),
            appStoragePref.getQuoteId(),
            productId,
            qty,
            productParamsJSON,
            relatedProducts),
      ),
    ));
    return handleResponse(
      response,
      'addToCart',
      (json) => AddToCartResponse.fromJson(json),
    );
  }

  ///addGiftToCart
  Future<AddGiftToCartResponse?> addGiftToCart(
      {required Map<String, dynamic> productParamsJSON,
      required String sku}) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.addGIftToCart(productParamsJSON: productParamsJSON, sku: sku),
      ),
    ));
    return handleResponse(
      response,
      'addGiftCardProductsToCart',
      ignoreException: true,
      (json) => AddGiftToCartResponse.fromJson(json),
    );
  }

  ///reorder
  Future<BaseModel?> reorder(String incrementId) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.reorder(
          appStoragePref.getStoreId(),
          appStoragePref.getCustomerToken(),
          incrementId,
        ),
      ),
    ));
    return handleResponse(
      response,
      'reOrder',
      (json) => AddToCartResponse.fromJson(json),
    );
  }

  ///cmsPage
  Future<CmsPageModel?> cmsPage(String id) async {
    var response = await (client.clientToQuery()).query(QueryOptions(
        cacheRereadPolicy: CacheRereadPolicy.mergeOptimistic,
        fetchPolicy: FetchPolicy.cacheAndNetwork,
        document: gql(
          mutation.cmsPage(int.parse(id)),
        )));
    return handleResponse(
      response,
      'cmsData',
      (json) => CmsPageModel.fromJson(json),
    );
  }

  ///lookbook
  Future<List<LookBookCategories>?> lookBookCategories() async {
    var response = await (client.clientToQuery()).query(QueryOptions(
        cacheRereadPolicy: CacheRereadPolicy.mergeOptimistic,
        fetchPolicy: FetchPolicy.cacheAndNetwork,
        document: gql(
          mutation.lookBookCategories(),
        )));
    return handleResponse(
      response,
      '',
      (json) {
        debugPrint("response=>${json}");
        List<LookBookCategories>? lookBookCategories = [];
        for (var item in response.data!['lookBookCategories']) {
          lookBookCategories.add(LookBookCategories.fromJson(item));
        }
        debugPrint("lookBookCategories=>${lookBookCategories.first.title}");
        return lookBookCategories;
      },
    );
  }

  ///myDownloadableProduct
  Future<DownloadableProductsListModel?> myDownloadsList(
      String pageNumber) async {
    var response = await (client.clientToQuery()).query(QueryOptions(
        cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
        fetchPolicy: FetchPolicy.noCache,
        document: gql(
          mutation.myDownloadsList(
            int.parse(appStoragePref.getStoreId()),
            int.parse(pageNumber),
            appStoragePref.getCustomerToken(),
          ),
        )));
    return handleResponse(
      response,
      'myDownloadsList',
      (json) => DownloadableProductsListModel.fromJson(json),
    );
  }

  ///downloadProduct
  Future<DownloadProduct?> downloadProduct(String hash) async {
    var response = await (client.clientToQuery()).query(QueryOptions(
        cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
        fetchPolicy: FetchPolicy.noCache,
        document: gql(
          mutation.downloadProduct(
            hash,
            appStoragePref.getCustomerToken(),
          ),
        )));
    return handleResponse(
      response,
      'downloadProduct',
      (json) => DownloadProduct.fromJson(json),
    );
  }

  ///Apply coupon
  Future<BaseModel?> applyCoupon(String couponCode, int remove) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.applyCoupon(
          appStoragePref.getStoreId(),
          appStoragePref.getCustomerToken(),
          appStoragePref.getQuoteId(),
          remove,
          couponCode,
        ),
      ),
    ));
    return handleResponse(
      response,
      'applyCoupon',
      (json) => BaseModel.fromJson(json),
    );
  }

  ///Apply coupon
  Future<BaseModel?> applyGiftCoupon(String couponCode) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.applyGiftCoupon(
          storeCode: appStoragePref.getStoreId(),
          cartId: appStoragePref.getCartId(),
          quoteId: appStoragePref.getQuoteId(),
          giftCode: couponCode,
        ),
      ),
    ));
    return handleResponse(
      response,
      'applyGiftCardCodeToCart',
      (json) => BaseModel.fromJson(json),
    );
  }

  ///Apply reward
  Future<BaseModel?> applyRewardPoint(String amount) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.applyRewardPoint(
          storeCode: appStoragePref.getStoreId(),
          cartId: appStoragePref.getCartId(),
          amount: amount,
        ),
      ),
    ));
    return handleResponse(
      response,
      'mstRewardsApplyPointsToCart',
      (json) => BaseModel.fromJson(json),
    );
  }

  ///REMOVE coupon
  Future<BaseModel?> removeGiftCoupon(String couponCode) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.removeGiftCoupon(
          storeCode: appStoragePref.getStoreId(),
          cartId: appStoragePref.getCartId(),
          quoteId: appStoragePref.getQuoteId(),
          giftCode: couponCode,
        ),
      ),
    ));
    return handleResponse(
      response,
      'removeGiftCardCodeFromCart',
      (json) => BaseModel.fromJson(json),
    );
  }

  ///Update Cart
  Future<BaseModel?> updateCart(List<Map<String, String>> itemIds) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.updateCart(
            appStoragePref.getStoreId(),
            appStoragePref.getCustomerToken(),
            appStoragePref.getQuoteId(),
            itemIds),
      ),
    ));
    return handleResponse(
      response,
      'updateCart',
      (json) => BaseModel.fromJson(json),
    );
  }

  ///saveAccountInfo
  Future<BaseModel?> saveAccountInfo(
    String prefix,
    String firstName,
    String middleName,
    String lastName,
    String suffix,
    String dob,
    String taxvat,
    String gender,
    String email,
    String mobile,
    String newPassword,
    String currentPassword,
    String confirmPassword,
    int doChangeEmail,
    int doChangePassword,
  ) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.saveAccountInfo(
            appStoragePref.getWebsiteId(),
            appStoragePref.getStoreId(),
            appStoragePref.getCustomerToken(),
            prefix,
            firstName,
            middleName,
            lastName,
            suffix,
            dob,
            taxvat,
            ((gender ?? "").isNotEmpty) ? int.parse(gender) : 0,
            email,
            mobile,
            newPassword,
            currentPassword,
            confirmPassword,
            doChangeEmail == 0 ? false : true,
            doChangePassword == 0 ? false : true),
      ),
    ));
    return handleResponse(
      response,
      'saveAccountInfo',
      (json) => BaseModel.fromJson(json),
    );
  }

  /// walkThroughData
  Future<WalkThroughModel?> getWalkThrough() async {
    var response = await (client.clientToQuery()).query(QueryOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.getWalkThroughData(
          int.parse(appStoragePref.getStoreId()),
          "1000",
        ),
      ),
    ));
    return handleResponse(
      response,
      'walkthrough',
      (json) => WalkThroughModel.fromJson(json),
    );
  }

  /// customerCompareList
  Future<CompareProductModel?> customerCompareList() async {
    var response = await (client.clientToQuery()).query(QueryOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.customerCompareList(
          int.parse(appStoragePref.getStoreId()),
          appStoragePref.getCurrencyCode(),
          appStoragePref.getCustomerToken(),
          appStoragePref.getQuoteId(),
        ),
      ),
    ));
    return handleResponse(
      response,
      'customerCompareList',
      (json) => CompareProductModel.fromJson(json),
    );
  }

  /// add compare
  Future<BaseModel?> addToCompare(String itemId) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.addToCompare(
            int.parse(appStoragePref.getStoreId()),
            int.parse(appStoragePref.getWebsiteId()),
            appStoragePref.getCustomerToken(),
            itemId),
      ),
    ));
    return handleResponse(
      response,
      'addToCompare',
      (json) => WishlistAddallcartResponseModel.fromJson(json),
    );
  }

  /// Remove compare
  Future<BaseModel?> removeFromCompare(String itemId) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.removeFromCompare(
            int.parse(appStoragePref.getStoreId()),
            int.parse(appStoragePref.getWebsiteId()),
            appStoragePref.getCustomerToken(),
            itemId),
      ),
    ));
    return handleResponse(
      response,
      'removeFromCompare',
      (json) => WishlistAddallcartResponseModel.fromJson(json),
    );
  }

  ///deleteAccount
  Future<BaseModel?> deleteAccount(String email, String password) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.deleteAccount(
          appStoragePref.getWebsiteId(),
          appStoragePref.getStoreId(),
          appStoragePref.getCustomerToken(),
          email,
          password,
        ),
      ),
    ));
    return handleResponse(
      response,
      'deleteAccount',
      (json) => BaseModel.fromJson(json),
    );
  }

  ///save review
  Future<BaseModel?> saveReview(String productId, String nickname,
      String detail, String title, List<Map<String, String>> ratingData) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.saveReview(
            appStoragePref.getStoreId(),
            appStoragePref.getCustomerToken(),
            productId,
            nickname,
            detail,
            title,
            ratingData),
      ),
    ));
    return handleResponse(
      response,
      'saveReview',
      (json) => BaseModel.fromJson(json),
    );
  }

  ///uploadProfilePic
  Future<AccountInfoModel?> uploadProfile(String image) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.uploadProfilePic(appStoragePref.getCustomerToken(), image,
            (AppSizes.deviceWidth.toInt()).toString(), "1"),
      ),
    ));
    return handleResponse(
      response,
      'uploadProfilePic',
      (json) => AccountInfoModel.fromJson(json),
    );
  }

  ///uploadBannerPic
  Future<AccountInfoModel?> uploadBannerPic(String image) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.uploadBannerPic(appStoragePref.getCustomerToken(), image,
            (AppSizes.deviceWidth.toInt()).toString(), "1"),
      ),
    ));
    return handleResponse(
      response,
      'uploadBannerPic',
      (json) => AccountInfoModel.fromJson(json),
    );
  }

  /// ratingFormData
  Future<RatingFormDataModel?> getRatingFormData() async {
    var response = await (client.clientToQuery()).query(QueryOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.getRatingFormData(
          int.parse(appStoragePref.getStoreId()),
        ),
      ),
    ));
    return handleResponse(
      response,
      'ratingFormData',
      (json) => RatingFormDataModel.fromJson(json),
    );
  }

  /// Invoice View
  Future<RefundViewModel?> getCreditView(String creditMemoId) async {
    var response = await (client.clientToQuery()).query(QueryOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.getCreditView(
          int.parse(appStoragePref.getStoreId()),
          appStoragePref.getCustomerToken(),
          creditMemoId,
        ),
      ),
    ));
    return handleResponse(
      response,
      'creditView',
      (json) => RefundViewModel.fromJson(json),
    );
  }

  Future<BaseModel?> contact(
      String name, String email, String telephone, String comment) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.contact(
            appStoragePref.getStoreId(), name, email, telephone, comment),
      ),
    ));
    return handleResponse(
      response,
      'contact',
      (json) => BaseModel.fromJson(json),
    );
  }

  ///Get cart count
  Future<HomePageData?> getCartCount() async {
    var response = await (client.clientToQuery()).query(QueryOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreAll,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.getCartCount(
            appStoragePref.getWebsiteId(),
            appStoragePref.getStoreId(),
            appStoragePref.getCurrencyCode(),
            (AppSizes.deviceWidth.toInt()).toString(),
            appStoragePref.getCustomerToken(),
            appStoragePref.getQuoteId()),
      ),
    ));
    return handleResponse(
      response,
      'homePageData',
      (json) => HomePageData.fromJson(json),
    );
  }

  /// Print Invoice
  Future<PrintInvoiceModel?> printInvoice(
      String? invoiceId, String? increementId) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.printInvoice(appStoragePref.getStoreId(),
            appStoragePref.getCustomerToken(), invoiceId, increementId),
      ),
    ));
    return handleResponse(
      response,
      'printInvoice',
      (json) => PrintInvoiceModel.fromJson(json),
    );
  }

  /// DeliveryBoy Details
  Future<DeliveryBoyDetailsModel?> getDeliveryBoyDetails(
      String increementId) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.getDeliveryBoyDetails(
            appStoragePref.getStoreId(), increementId),
      ),
    ));
    return handleResponse(
      response,
      'GetOrderInfo',
      (json) => DeliveryBoyDetailsModel.fromJson(json),
    );
  }

  /// DeliveryBoy Location Details
  Future<DeliveryBoyLocationDetailsModel?> getDeliveryBoyLocationDetails(
      int? deliveryboyId) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.getDeliveryBoyLocationDetails(
            appStoragePref.getStoreId(), deliveryboyId),
      ),
    ));
    return handleResponse(
      response,
      'GetLocation',
      (json) => DeliveryBoyLocationDetailsModel.fromJson(json),
    );
  }

  /// DeliveryBoy save review
  Future<BaseModel?> deliveryBoySaveReview(
      int? rating,
      int? customerId,
      String? title,
      String? comment,
      int? deliveryboyId,
      String? orderId,
      String? nickName) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.saveDeliveryBoyAddReview(
          appStoragePref.getStoreId(),
          title,
          rating,
          customerId,
          comment,
          deliveryboyId,
          orderId,
          nickName,
        ),
      ),
    ));
    return handleResponse(
      response,
      'AddReview',
      (json) => BaseModel.fromJson(json),
    );
  }

  /// QR Scanner
  Future<BaseModel?> qrScan(String barCodeData) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.qrScan(barCodeData, appStoragePref.getCustomerToken()),
      ),
    ));
    return handleResponse(
      response,
      'watchLogin',
      (json) => BaseModel.fromJson(json),
    );
  }

  ///Customization Wallet Extension

  Future<WalletDashboardModel?> getWalletDashboard() async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.getWalletDashboard(
          appStoragePref.getCustomerToken(),
        ),
      ),
    ));
    return handleResponse(
      response,
      'Dashboard',
      (json) => WalletDashboardModel.fromJson(json),
    );
  }

  Future<WalletDashboardModel?> getWalletTransfer() async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.getWalletTransfer(
          appStoragePref.getCustomerToken(),
        ),
      ),
    ));
    return handleResponse(
      response,
      'Transfer',
      (json) => WalletDashboardModel.fromJson(json),
    );
  }

  Future<BaseModel?> addPayee(String email, String name) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.addPayee(
          int.parse(appStoragePref.getStoreId()),
          appStoragePref.getCustomerToken(),
          email,
          name,
        ),
      ),
    ));
    return handleResponse(
      response,
      'Addpayee',
      (json) => BaseModel.fromJson(json),
    );
  }

  Future<BaseModel?> updatePayee(int id, String name) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.updatePayee(
          int.parse(appStoragePref.getStoreId()),
          id,
          name,
          appStoragePref.getCustomerToken(),
        ),
      ),
    ));
    return handleResponse(
      response,
      'Updatepayee',
      (json) => BaseModel.fromJson(json),
    );
  }

  Future<BaseModel?> deletePayee(int id) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.deletePayee(
          int.parse(appStoragePref.getStoreId()),
          id,
          appStoragePref.getCustomerToken(),
        ),
      ),
    ));
    return handleResponse(
      response,
      'Deletepayee',
      (json) => BaseModel.fromJson(json),
    );
  }

  Future<BaseModel?> deleteBankAccount(int id) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.deleteAccountDetails(
          id,
        ),
      ),
    ));
    return handleResponse(
      response,
      'customerrequestdeleteaccount',
      (json) => BaseModel.fromJson(json),
    );
  }

  Future<BaseModel?> sendCodeForTransferMoney(
      int id, int amount, String note) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.sendCodeForTransferMoney(
          amount,
          id,
          note,
          appStoragePref.getCustomerToken(),
        ),
      ),
    ));
    return handleResponse(
      response,
      'Sendcode',
      (json) => BaseModel.fromJson(json),
    );
  }

  Future<BaseModel?> sendMoney(
      int id, int amount, String note, String otp) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.sendMoney(
          amount,
          id,
          note,
          otp,
          appStoragePref.getCustomerToken(),
        ),
      ),
    ));
    return handleResponse(
      response,
      'Sendamount',
      (json) => BaseModel.fromJson(json),
    );
  }

  Future<BaseModel?> addMoneyToWallet(String amount, int productId) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.addMoneyToWallet(
          int.parse(amount.toString()),
          int.parse(appStoragePref.getStoreId()),
          productId,
          appStoragePref.getCurrencyCode(),
          appStoragePref.getCustomerToken(),
        ),
      ),
    ));
    return handleResponse(
      response,
      'Add',
      (json) => BaseModel.fromJson(json),
    );
  }

  Future<BaseModel?> transferAmountToBank(
      int amount, String id, String note) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.transferAmountToBank(
            amount, note, appStoragePref.getCustomerToken(), id),
      ),
    ));
    return handleResponse(
      response,
      'Bankaccount',
      (json) => BaseModel.fromJson(json),
    );
  }

  Future<ViewTransactionModel?> viewTransaction(int id) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.getTransactionDetails(
          id,
          appStoragePref.getCurrencyCode(),
          appStoragePref.getCustomerToken(),
        ),
      ),
    ));
    return handleResponse(
      response,
      'Viewtransaction',
      (json) => ViewTransactionModel.fromJson(json),
    );
  }

  Future<WalletDashboardModel?> applyPaymentAmount(String wallet) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.applyPaymentAmount(
          int.parse(appStoragePref.getStoreId()),
          wallet,
          appStoragePref.getCustomerToken(),
        ),
      ),
    ));
    return handleResponse(
      response,
      'Applypaymentamount',
      (json) => WalletDashboardModel.fromJson(json),
    );
  }

  Future<AccountDetailsModel?> getAccountDetails() async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.getAccountDetails(
          appStoragePref.getCustomerToken(),
        ),
      ),
    ));
    return handleResponse(
      response,
      'customerbankaccountdetails',
      (json) => AccountDetailsModel.fromJson(json),
    );
  }

  Future<BaseModel?> addAccountDetails(AddAccountFormModel model) async {
    var response = await (client.clientToQuery()).mutate(MutationOptions(
      cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
      fetchPolicy: FetchPolicy.noCache,
      document: gql(
        mutation.addAccountDetails(
          model,
          appStoragePref.getCustomerToken(),
        ),
      ),
    ));
    return handleResponse(
      response,
      'customeraddbankaccountdetails',
      (json) => BaseModel.fromJson(json),
    );
  }

// Future<TransactionDetails?> getTransactionDetails() async {
//   var response = await (client.clientToQuery()).mutate(MutationOptions(
//     cacheRereadPolicy: CacheRereadPolicy.ignoreOptimisitic,
//     fetchPolicy: FetchPolicy.noCache,
//     document: gql(
//       mutation.getWalletTransactionHistory(
//         int.parse(await appStoragePref.getUserData()?.customerId ?? "0")
//       ),
//     ),
//   ));
//   return handleResponse(
//     response,
//     'data',
//         (json) => TransactionDetails.fromJson(json),
//   );
// }
}
