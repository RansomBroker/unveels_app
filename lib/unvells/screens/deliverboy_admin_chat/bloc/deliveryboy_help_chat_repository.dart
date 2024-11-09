
/*
 *


 *
 * /
 */

import 'package:flutter/foundation.dart';
import 'package:test_new/unvells/models/base_model.dart';
import '../../../helper/push_notifications_manager.dart';
import '../../../models/deliveryboyHelpChat/deliveryboy_help_chat_model.dart';
import '../../../network_manager/api_client.dart';
import '../../../network_manager/api_client_retrofit.dart';

abstract class DeliveryboyHelpChatRepository {
  Future<BaseModel> getUpdateToken(String mUserId,String userName, String avatar, String mAccountType, String osType, String sellerId);

}

class DeliveryboyHelpChatRepositoryImp implements DeliveryboyHelpChatRepository {

  @override
  Future<BaseModel> getUpdateToken(String mUserId,String userName, String avatar,
       String mAccountType, String osType, String sellerId)async{
    BaseModel? model;
    var firebaseToken = await PushNotificationsManager().createFcmToken();
    print("deviceId==>$firebaseToken");
    model = await ApiClientRetrofit(baseUrl: "https://us-central1-unvells-magento2-app.cloudfunctions.net").getUpdateToken(
      mUserId, userName, avatar, firebaseToken??"", mAccountType, osType, sellerId
    );
    return model!;
  }

    // try{
    //   final String response = await rootBundle
    //       .loadString('assets/responses/seller_list_data_response.json');
    //   Map<String, dynamic> userMap = jsonDecode(response);
    //   var sellerListModel = DeliveryboyHelpChatMpModel.fromJson(userMap);
    //   return sellerListModel;
    //
    // }
    // catch (e) {
    //   if (kDebugMode) {
    //     print(e);
    //   }
    //   throw Exception(e);
    // }

}
