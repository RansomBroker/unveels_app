/*
 *


 *
 * /
 */

import 'dart:convert';

import '../../../helper/push_notifications_manager.dart';
import '../../../models/account_info/account_info_model.dart';
import '../../../models/base_model.dart';
import '../../../network_manager/api_client.dart';
abstract class ProfileScreenRepository{
  Future<BaseModel> logOut();
  Future<AccountInfoModel> setImage(String image,String type);
}

class ProfileScreenRepositoryImp implements ProfileScreenRepository{
  @override
  Future<BaseModel> logOut() async{
    BaseModel? model;
    var firebaseToken = await PushNotificationsManager().createFcmToken();
    print("deviceId for logOut==>$firebaseToken");
    model = await ApiClient().logout(firebaseToken ?? "");
    return model!;
  }

  @override
  Future<AccountInfoModel> setImage(String image,String type) async{
    AccountInfoModel? model;
    // Map<String,dynamic> data = {};
    // data[type] = image;
    // String body = json.encode(data);
    // model = await ApiClient().saveAccountInfo(body);
    return model!;
  }
}
