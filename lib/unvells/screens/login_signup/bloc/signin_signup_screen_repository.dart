/*
 *


 *
 * /
 */

import 'dart:convert';

import 'package:test_new/unvells/helper/app_storage_pref.dart';
import 'package:test_new/unvells/models/login_signup/signup_response_model.dart';

import '../../../helper/push_notifications_manager.dart';
import '../../../models/base_model.dart';
import '../../../models/cart/customer_cart_model.dart';
import '../../../models/login_signup/login_response_model.dart';
import '../../../models/login_signup/sign_up_screen_model.dart';
import '../../../models/login_signup/social_login_model.dart';
import '../../../network_manager/api_client.dart';

abstract class AuthRepository {
  Future<SignUpScreenModel>? signUpFormData();

  Future<SignupResponseModel>? signUp(
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
      String mobile);

  Future login(String email, String password);

  Future<CustomerCartData>? customerCart();

  Future forgotPassword(String email);

  Future<SignupResponseModel>? socialLogin(SocialLoginModel socialLoginRequest);
}

class SigninSignupScreenRepositoryImp implements AuthRepository {
  @override
  Future<SignUpScreenModel>? signUpFormData() async {
    SignUpScreenModel? responseModel;
    try {
      responseModel = await ApiClient().createAccountFormData();
    } catch (e, stacktrace) {
      print("Error --> $e");
      print("StackTrace --> $stacktrace");
    }
    return responseModel!;
  }

  @override
  Future<CustomerCartData>? customerCart() async {
    CustomerCartData? responseModel;
    try {
      responseModel = await ApiClient().getCustomerCart();
    } catch (e, stacktrace) {
      print("Error --> $e");
      print("StackTrace --> $stacktrace");
    }
    return responseModel!;
  }

  @override
  Future<SignupResponseModel>? signUp(
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
      String mobile) async {
    // var firebaseToken = await PushNotificationsManager().createFcmToken();
    // print("deviceId==>$firebaseToken");
    SignupResponseModel? responseModel;
    try {
      responseModel = await ApiClient().createAccount(
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
          mobile,
          // firebaseToken ?? "",
          '',
          0);
    } catch (e, stacktrace) {
      print("Error --> $e");
      print("StackTrace --> $stacktrace");
    }
    return responseModel!;
  }

  @override
  Future forgotPassword(String email) async {
    BaseModel? responseModel;
    try {
      responseModel = await ApiClient().forgotPassword(email);
    } catch (e, stacktrace) {
      print("Error --> $e");
      print("StackTrace --> $stacktrace");
    }
    return responseModel!;
  }

  @override
  Future login(String email, String password) async {
    // var firebaseToken = await PushNotificationsManager().createFcmToken();
    // print("deviceId==>$firebaseToken");
    LoginResponseModel? responseModel;
    try {
      responseModel =
          await ApiClient().customerLogin(email, password, "" ?? "");
    } catch (e, stacktrace) {
      print("Error --> $e");
      print("StackTrace --> $stacktrace");
    }
    return responseModel!;
  }

  @override
  Future<SignupResponseModel>? socialLogin(
      SocialLoginModel socialLoginRequest) async {
    var firebaseToken = await PushNotificationsManager().createFcmToken();
    print("deviceId==>$firebaseToken");
    SignupResponseModel? responseModel;
    try {
      responseModel = await ApiClient().createAccount(
          "",
          socialLoginRequest.firstName ?? "",
          "middleName",
          socialLoginRequest.lastName ?? "",
          "",
          "",
          "",
          "",
          socialLoginRequest.email ?? "",
          socialLoginRequest.id ?? "",
          "",
          firebaseToken ?? "",
          1);
    } catch (e, stacktrace) {
      print("Error --> $e");
      print("StackTrace --> $stacktrace");
    }
    return responseModel!;
  }
}
