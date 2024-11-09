/*
 *


 *
 * /
 */

import 'dart:developer';

import '../../../models/notifications/notification_screen_model.dart';
import '../../../network_manager/api_client.dart';

abstract class NotificationScreenRepository {
  Future<NotificationScreenModel?> getNotification();
}

class NotificationScreenRepositoryImp implements NotificationScreenRepository {
  @override
  Future<NotificationScreenModel?> getNotification() async{

    NotificationScreenModel? responseData;
    try{
      responseData = await ApiClient().getNotificationList();
    }
    catch(error,stacktrace){
      log("Error --> $error");
      log("StackTrace --> $stacktrace");
    }
    return responseData!;
  }
}


