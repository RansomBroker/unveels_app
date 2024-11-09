/*
 *


 *
 * /
 */

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:test_new/unvells/models/checkout/payment_info/payment_info_model.dart';
import 'package:test_new/unvells/models/checkout/place_order/place_order_model.dart';

import '../../../../helper/push_notifications_manager.dart';
import '../../../../models/base_model.dart';
import '../../../../models/checkout/place_order/billing_data_request.dart';
import '../../../../models/checkout/shipping_info/shipping_address_model.dart';
import '../../../../models/wallet_extension_models/wallet_dashboard_model.dart';
import '../../../../network_manager/api_client.dart';

abstract class PaymentInfoScreenRepository {
  Future<PaymentInfoModel> getPaymentInfo(String shippingMethod);

  Future<ShippingAddressModel> getCheckoutAddress();

  Future<PlaceOrderModel> placeOrder(
      String wallet, String paymentMethod, BillingDataRequest billingData);

  Future<BaseModel> applyCoupon(String couponCode, int remove);

  Future<BaseModel> applyGiftCoupon(String giftCode, int remove);

  Future<BaseModel> applyRewardPoint(String amount, int remove);

  Future<WalletDashboardModel?> applyPaymentAmount(String wallet);
}

class PaymentInfoScreenRepositoryImp implements PaymentInfoScreenRepository {
  @override
  Future<PaymentInfoModel> getPaymentInfo(String shippingMethod) async {
    PaymentInfoModel? responseData;
    try {
      responseData = await ApiClient().reviewAndPayment(shippingMethod);
    } catch (error, stacktrace) {
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
    return responseData!;
  }

  @override
  Future<ShippingAddressModel> getCheckoutAddress() async {
    ShippingAddressModel? responseData;
    try {
      responseData = await ApiClient().checkoutAddress();
    } catch (error, stacktrace) {
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
    return responseData!;
  }

  @override
  Future<PlaceOrderModel> placeOrder(String wallet, String paymentMethod,
      BillingDataRequest billingData) async {
    PlaceOrderModel? responseData;
    try {
      var firebaseToken = await PushNotificationsManager().createFcmToken();
      print("deviceId==>$firebaseToken");
      responseData = await ApiClient()
          .placeOrder(wallet, paymentMethod, billingData, firebaseToken ?? "");
    } catch (error, stacktrace) {
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
    return responseData!;
  }

  @override
  Future<BaseModel> applyCoupon(String couponCode, int remove) async {
    BaseModel? responseData;
    try {
      responseData = await ApiClient().applyCoupon(couponCode, remove);
    } catch (error, stacktrace) {
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }

    return responseData!;
  }

  @override
  Future<BaseModel> applyGiftCoupon(String couponCode, int remove) async {
    BaseModel? responseData;
    try {
      if (remove == 1) {
        responseData = await ApiClient().removeGiftCoupon(couponCode);
      } else {
        responseData = await ApiClient().applyGiftCoupon(couponCode);
      }
    } catch (error, stacktrace) {
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }

    return responseData!;
  }

  @override
  Future<BaseModel> applyRewardPoint(String amount, int remove) async {
    BaseModel? responseData;
    try {

        responseData = await ApiClient().applyRewardPoint(remove==1?'0':amount);
    } catch (error, stacktrace) {
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }

    return responseData!;
  }

  @override
  @override
  Future<WalletDashboardModel?> applyPaymentAmount(String wallet) async {
    var model = await ApiClient().applyPaymentAmount(wallet);
    return model;
  }
}
