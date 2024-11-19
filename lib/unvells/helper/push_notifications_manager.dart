/*
 *


 *
 * /
 */

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:test_new/unvells/constants/app_routes.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/constants/arguments_map.dart';
import 'package:test_new/unvells/helper/app_storage_pref.dart';

import '../../main.dart';
import '../constants/app_constants.dart';
import '../models/deliveryBoyDetails/delivery_boy_details_model.dart';

class PushNotificationsManager {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  static const initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  static const initializationSettingsIOS = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  final InitializationSettings initializationSettings =
  const InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS);

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  void setUpFirebase(BuildContext context) {
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) async {
          final String? payload = response.payload;
          if ((payload?.isNotEmpty ?? false) && appStoragePref.getAllowAllNotifications()) {
            print("payload---==>" + payload.toString());

            Map notificationModelMap = json.decode(payload.toString());
            var notificationId = notificationModelMap["id"];
            var notificationType = notificationModelMap["notificationType"];

            if (notificationType ==  AppConstant.productTypeNotification && appStoragePref.getAllowOfferNotifications()) {
              Navigator.of(navigatorKey.currentContext!).pushNamed(
                AppRoutes.productPage,
                arguments: getProductDataAttributeMap(
                  notificationModelMap["productName"] ?? "",
                  notificationModelMap["productId"] ?? "",
                ),
              );

            } else if (notificationType ==  AppConstant.categoryTypeNotification && appStoragePref.getAllowOfferNotifications()) {
              Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.catalog,
                  arguments: getCatalogMap(
                    notificationModelMap["categoryId"] ?? "",
                    notificationModelMap["categoryName"] ?? "",
                    BUNDLE_KEY_CATALOG_TYPE_CATEGORY,
                    false,
                  ));

            } else if (notificationType ==  AppConstant.customTypeNotification && appStoragePref.getAllowOfferNotifications()) {
              Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.catalog,
                  arguments: getCatalogMap(
                    notificationModelMap["id"] ?? "",
                    notificationModelMap["title"] ?? "",
                    BUNDLE_KEY_CATALOG_TYPE_CATEGORY,
                    false,
                  ));

            } else if (notificationType ==  AppConstant.otherTypeNotification && appStoragePref.getAllowOfferNotifications()) {
              Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.cmsPage,
                  arguments: getCmsPageArguments(
                      notificationModelMap["id"] ?? "",
                      notificationModelMap["title"] ?? ""
                  ));

            } else if (notificationType ==  AppConstant.chatTypeNotification) {
              print("CHECK_Data ==> ${int.parse(notificationModelMap["senderId"].split("-")[1] ?? "0")} ");
              AssignedDeliveryBoyDetails? deliveryBoys = AssignedDeliveryBoyDetails(sellerId:int.parse(notificationModelMap["senderId"].split("-")[1] ?? "0"),
                  customerId: 9, name: "Himani"
              );
              Navigator.pushNamed(context, AppRoutes.deliveryboyHelpChatScreen,arguments: deliveryBoys);

            } else if (notificationType ==  AppConstant.orderTypeNotification && appStoragePref.getAllowOrderNotifications()) {
              Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.orderDetail,
                  arguments: notificationModelMap["incrementId"] ?? ""
              );

            }
          }
        });
    _firebaseCloudMessagingListeners(context);
  }

  Future<StyleInformation?> getNotificationStyle(String? image) async {
    if (image != null) {
      final ByteData imageData =
      await NetworkAssetBundle(Uri.parse(image)).load("");
      return BigPictureStyleInformation(
          ByteArrayAndroidBitmap(imageData.buffer.asUint8List()));
    } else {
      return null;
    }
  }

  void showNotification(
      String title, String body, String? payload, String? image) async {
    var notificationStyle = await getNotificationStyle(image);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        '${Random().nextDouble()}', '${AppStringConstant.appName} Notification',
        importance: Importance.max,
        priority: Priority.max,
        playSound: true,
        styleInformation: notificationStyle);

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails(
      presentAlert: true,
      presentSound: true,
      presentBadge: true,
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: payload);
  }

  Future<String?> createFcmToken() async {
    return _firebaseMessaging.getToken();
  }

  void _firebaseCloudMessagingListeners(BuildContext context) async {
    if (Platform.isIOS) _iosPermission();

    createFcmToken();

    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print("deviceId${iosInfo.identifierForVendor}");
      AppStoragePref().setDeviceId(iosInfo.identifierForVendor.toString());
      _firebaseMessaging.subscribeToTopic(AppConstant.fcmMessagingTopiciOS);
    } else {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print("deviceId${androidInfo.id}");
      AppStoragePref().setDeviceId(androidInfo.id.toString());
      _firebaseMessaging.subscribeToTopic(AppConstant.fcmMessagingTopicAndroid);
    }



    //When app is in Working state
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {

      print('NOTIFICATION DATA ====>  ${message.data}');

      var data = message.data;
      if (data.isNotEmpty) {
        var notificationId = data["id"];
        var notificationType = data["notificationType"];
        var notificationTitle = data["title"];
        var notificationBody = data["body"];
        var notificationBanner = data["banner_url"];

        showNotification(notificationTitle!, notificationBody!, json.encode(data), notificationBanner);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("OnAppOpened}");
      print(message.data);
      if (message.data['type'] == "product") {
        print("product");
        Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.productPage,
            arguments:
            getProductDataAttributeMap(message.data['name'], message.data['id']));
      } else if (message.data['type'] == "category") {
        Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.catalog,
          arguments: getCatalogMap(
              message.data['id'],
              message.data['name'],
              "",
              false),
        );
      } else if (message.data['type'] == AppConstant.chatTypeNotification) {
        Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.deliveryboyHelpChatScreen,
            arguments: getNotificationArguments(
                message.data["accountType"] ?? "",
                message.data["senderId"] ?? ""
            ));
      } else if (message.data['type'] == AppConstant.customTypeNotification) {
        Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.catalog,
          arguments: getCatalogMap(
              message.data['id'],
              message.data['name'],
              "",
              false),
        );
      }
    });

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      print("open app data");
      var data = message?.data;
      // if (data!.isNotEmpty) {
      //   var notificationId = data["id"];
      //   var notificationType = data["notificationType"];
      //   var notificationTitle = data["title"];
      //   var notificationBody = data["body"];
      //   var notificationBanner = data["banner_url"];
      //
      //   showNotification(notificationTitle!, notificationBody!, json.encode(data), notificationBanner);
      // }
    });


  }

  void checkInitialMessage(BuildContext context) {
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      print("open app data");
      if (message?.data != null && appStoragePref.getAllowAllNotifications()) {

        print("payload==> ${message?.data}" );
        var notificationModelMap = message!.data;
        var notificationType = notificationModelMap["notificationType"];

        if (notificationType ==  AppConstant.productTypeNotification && appStoragePref.getAllowOfferNotifications()) {
          Navigator.of(navigatorKey.currentContext!).pushNamed(
            AppRoutes.productPage,
            arguments: getProductDataAttributeMap(
              notificationModelMap["productName"] ?? "",
              notificationModelMap["productId"] ?? "",
            ),
          );

        } else if (notificationType ==  AppConstant.categoryTypeNotification && appStoragePref.getAllowOfferNotifications()) {
          Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.catalog,
              arguments: getCatalogMap(
                notificationModelMap["categoryId"] ?? "",
                notificationModelMap["categoryName"] ?? "",
                BUNDLE_KEY_CATALOG_TYPE_CATEGORY,
                false,
              ));

        } else if (notificationType ==  AppConstant.customTypeNotification && appStoragePref.getAllowOfferNotifications()) {
          Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.catalog,
              arguments: getCatalogMap(
                notificationModelMap["id"] ?? "",
                notificationModelMap["title"] ?? "",
                BUNDLE_KEY_CATALOG_TYPE_CATEGORY,
                false,
              ));

        } else if (notificationType ==  AppConstant.otherTypeNotification && appStoragePref.getAllowOfferNotifications()) {
          Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.cmsPage,
              arguments: getCmsPageArguments(
                  notificationModelMap["id"] ?? "",
                  notificationModelMap["title"] ?? ""
              ));

        } else if (notificationType ==  AppConstant.chatTypeNotification) {
          Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.deliveryboyHelpChatScreen,
              arguments: getNotificationArguments(
                  notificationModelMap["accountType"] ?? "",
                  notificationModelMap["senderId"] ?? ""
              ));
        } else if (notificationType ==  AppConstant.orderTypeNotification && appStoragePref.getAllowOrderNotifications()) {
          Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.orderDetail,
              arguments: notificationModelMap["incrementId"] ?? ""
          );

        }
      }
    });
  }

  void _iosPermission() {
    _firebaseMessaging
        .requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    )
        .then((value) {
      print("Settings registered: $value");
    });
  }
}
