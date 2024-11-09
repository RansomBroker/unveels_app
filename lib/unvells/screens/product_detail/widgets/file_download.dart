/*
 *


 *
 * /
 */

// ignore_for_file: empty_catches

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_new/unvells/constants/app_constants.dart';

import '../../../app_widgets/app_alert_message.dart';
import '../../../constants/app_string_constant.dart';
import '../../../helper/utils.dart';


class DownloadFile {
  var tag = "DownloadFile";

  Future downloadPersonalData(String url, String fileName,String fileType, BuildContext context) async {
    NotificationService notificationService = NotificationService();
    try {
      print("DOWNLOAD_URL==> ${url}");

      if(Platform.isAndroid) {
        var androidInfo = await DeviceInfoPlugin().androidInfo;
        if (int.parse(androidInfo.version.release??"10") >= 12) {
          requestManageStoragePermission();
        }
      }
      Map<Permission, PermissionStatus> status = await [
        Permission.storage,
        Permission.manageExternalStorage,
        //add more permission to request here.
      ].request()/*.whenComplete(() {
        debugPrint("enableeeeee");
      })*/;

      print("PERMISSION==> ${status[Permission.manageExternalStorage]!.isGranted}");
      print("PERMISSION==> ${status[Permission.storage]!.isGranted}");

      // Dio dio = Dio();
      if (status[Permission.storage]!.isGranted || status[Permission.manageExternalStorage]!.isGranted) {
        var dir = await getApplicationDocumentsDirectory();
        if(dir != null){

          String saveName = "";
          if (fileType.isNotEmpty) {
            saveName = "${fileName.toString()??""}." + fileType;
          } else {
            saveName = "${fileName.toString()??""}";
          }

          String savePath = dir.path + "/$saveName";
          print("FileType:: $fileType  $saveName Path is $savePath");

          AlertMessage.showSuccess(Utils.getStringValue(context, AppStringConstant.downloadStarted), context);


          Directory? directory;
          directory = await getApplicationDocumentsDirectory();
          // File saveFile = File("/storage/emulated/0/Download/$saveName");

          File saveFile = await (Platform.isAndroid) ? File("/storage/emulated/0/Download/$saveName") : File(directory.path + "/$saveName");
          try {
            await Dio().download(url, saveFile.path,
                onReceiveProgress: (received, total) {
                  if (total != -1) {
                    print((received / total * 100).toStringAsFixed(0) + "%");

                    /*notificationService.createNotification(
                        100, ((received / total) * 100).toInt(), 0, saveFile.path, saveName);*/
                  }
                }

            );

            notificationService.createNotification(
                100, 0, 0, saveFile.path, saveName);
            initNotification(saveFile.path);
            print("demo =======");
            AlertMessage.showSuccess(Utils.getStringValue(context, AppStringConstant.fileSavedOnDownloadFolder), context);
            print("File is saved to download folder.");
          } on DioError catch (e) {
            print("error downloading file $e");
          }
        }
      } else if (status[Permission.storage]!.isDenied) {
        await Permission.storage.request();
        AlertMessage.showError(Utils.getStringValue(context, AppStringConstant.noPermissionToReadWriteStorage), context);
        debugPrint(tag + "permission is denied ->requesting");
      } else if (status[Permission.manageExternalStorage]!.isDenied) {
        await Permission.manageExternalStorage.request();
        AlertMessage.showError(Utils.getStringValue(context, AppStringConstant.noPermissionToReadWriteStorage), context);
        debugPrint(tag + "permission is denied for manageExternalStorage ->requesting");
      }
    } catch (e) {
      AlertMessage.showError(Utils.getStringValue(context, AppStringConstant.somethingWentWrong), context);
      debugPrint(tag + "exception while downloading invoice " + e.toString());
    }
  }


  Future<String> getFilePath(fileName) async {
    String path = '';
    // var pat_h = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
    // Directory dir = await getApplicationDocumentsDirectory();
    Directory? dir =  Platform.isAndroid
        ? await getExternalStorageDirectory() //FOR ANDROID
        : await getApplicationDocumentsDirectory();
    path = '${dir?.path}/$fileName';
    return path;
  }

  Future<void> requestManageStoragePermission() async {
    var status = await Permission.manageExternalStorage.request();
    if (status.isGranted) {
      print("Permission granted");
    } else {
      print("Permission denied");
    }
  }

  // initialized notification content

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initNotification(dynamic savePath) async {
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('ic_status');
    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings();
    final MacOSInitializationSettings initializationSettingsMacOS =
    MacOSInitializationSettings();
    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
        macOS: initializationSettingsMacOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) {
          if (payload != null) OpenFile.open(payload);
        });
  }
}


class NotificationService {
  //Hanle displaying of notifications.
  static final NotificationService _notificationService =
  NotificationService._internal();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings _androidInitializationSettings =
  const AndroidInitializationSettings('ic_status');

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal() {
    init();
  }

  void init() async {
    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: _androidInitializationSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void createNotification(int count, int i, int id, dynamic savePath,String saveName) {
    //show the notifications.
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'progress channel', 'progress channel',
        channelDescription: 'progress channel description',
        channelShowBadge: false,
        importance: Importance.max,
        priority: Priority.high,
        onlyAlertOnce: true,
        showProgress: false,
        maxProgress: count,
        progress: i);
    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    _flutterLocalNotificationsPlugin.show(id, /*'Download'*/ 'Downloaded - $saveName',
        '', platformChannelSpecifics,
        payload: savePath);
  }

}
