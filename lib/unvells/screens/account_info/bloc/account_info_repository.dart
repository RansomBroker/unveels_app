/*
 *
  

 *
 * /
 */

import 'dart:convert';

import 'package:test_new/unvells/network_manager/api_client.dart';

import '../../../models/account_info/account_info_model.dart';
import '../../../models/base_model.dart';


abstract class AccountInfoRepository {
  Future<AccountInfoModel> getAccountInfoData();
  Future<BaseModel> saveAccountInfo(
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
      );

  Future<BaseModel> deleteAccount(String email, String password);
}

class AccountInfoRepositoryImp implements AccountInfoRepository {
@override
  Future<AccountInfoModel> getAccountInfoData() async {
    var model = await ApiClient().accountInfoData();
    return model!;
  }

// @override
//   Future<AccountInfoModel> getAccountAccountInfo(String wkToken) async {
//     var model = await ApiClient().userDetail(wkToken);
//     return model;
//   }

  @override
  Future<BaseModel> saveAccountInfo(
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
    var model = await ApiClient()
        .saveAccountInfo(
          prefix,
          firstName,
          middleName,
          lastName,
          suffix,
          dob,
          taxvat,
          gender,
          email,
          mobile,
          newPassword,
          currentPassword,
          confirmPassword,
          doChangeEmail,
          doChangePassword,
        );
    return model!;
  }

  @override
  Future<BaseModel> deleteAccount(String email, String password) async {
    var model = await ApiClient().deleteAccount(email, password);
    return model!;
  }

  // @override
  // Future<LoginModel>? loginCustomer(
  //     String wkToken, String name, String password, String fcmToken) async {
  //   LoginModel model =
  //   await ApiClient().loginCustomer(wkToken, name, password, fcmToken);
  //   return model;
  // }
  // @override
  // Future<BaseModel>? deleteAccount() async {
  //   BaseModel model =
  //   await ApiClient().deleteUser(await AppSharedPref.getWkToken());
  //   return model;
  // }
}
