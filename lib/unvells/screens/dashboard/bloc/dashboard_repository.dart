/*
 *


 *
 * /
 */

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:test_new/unvells/models/order_list/order_list_model.dart';

import '../../../constants/app_constants.dart';
import '../../../models/account_info/account_info_model.dart';
import '../../../models/address/get_address.dart';
import '../../../models/base_model.dart';
import '../../../network_manager/api_client.dart';

abstract class DashboardRepository{
  Future<GetAddress> getAddressList();
  Future<AccountInfoModel> setImage(String image,String type);
}

class DashboardRepositoryImp implements DashboardRepository{

  @override
  Future<GetAddress> getAddressList() async {
    GetAddress? addressdata;
    try{
      addressdata = await ApiClient().getAddressData(1);
    } catch(error, stacktrace) {
      print("Error --> " + error.toString());
      print("Stacktrace --> " + stacktrace.toString());
    }
    return addressdata!;
  }

  @override
  Future<AccountInfoModel> setImage(String image,String type) async{
    try {
      AccountInfoModel? model;
      if (type == AppConstant.profileImage) {
        model = await ApiClient().uploadProfile(image);
      } else {
        model = await ApiClient().uploadBannerPic(image);
      }
      return model!;
    } catch (e, str) {
      print(e);
      print(str);
      throw Exception(e);
    }
  }
}