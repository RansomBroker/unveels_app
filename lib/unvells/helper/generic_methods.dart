/*
 *


 *
 * /
 */

import 'dart:io';

import 'package:dio/dio.dart';
// import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_new/unvells/helper/utils.dart';
import '../app_widgets/app_alert_message.dart';
import '../constants/app_constants.dart';
import '../constants/app_string_constant.dart';
import 'app_localizations.dart';

class GenericMethods {
  static String getStringValue(BuildContext context, String key) {
    return AppLocalizations.of(context)?.translate(key) ?? key;
  }

  static showAlertMessages(BuildContext context, String message) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      AlertMessage.showSuccess(message, context);
    });
  }

  static showErrorAlertMessages(BuildContext context, String message) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      AlertMessage.showError(message, context);
    });
  }



  /*
  *
  * Method to show time picker and return time
  *
  * */
  Future<String> showTimePickerAndGetSelectedTime(BuildContext context,String title) async {
    final TimeOfDay? result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now(),helpText: title);
    if (result != null) {
      return result.format(context);
    }
    return "";
  }

  /*
  * Method will return the selected date from Date picker
  * */

  showDatePickerAndGetSelectedDate(
      BuildContext context, DateTime currentDate,String title ) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
        helpText: title,
    );
    if (selectedDate != null) return selectedDate;
    return "";
  }

  static Future loadArOnIOS(BuildContext context, String fileUrl) async {
    try {
      print("DOWNLOAD_URL==> ${fileUrl}");
      Map<Permission, PermissionStatus> status = await [
        Permission.storage,
        Permission.manageExternalStorage,
      ].request();

      if (status[Permission.storage]!.isGranted || status[Permission.manageExternalStorage]!.isGranted) {
        var dir = await getApplicationDocumentsDirectory();
        if(dir != null){

          String fileName = "PersonalData." + "usdz";
          String savePath = dir.path + "/$fileName";
          try {
            await Dio().download(
                fileUrl,
                savePath,
                onReceiveProgress: (received, total) {
                  if (total != -1) {
                    print((received / total * 100).toStringAsFixed(0) + "%");
                  }
                });

            AlertMessage.showSuccess(Utils.getStringValue(context, AppStringConstant.fileSavedOnDownloadFolder), context);
            print("File is saved: $savePath");
            const platform = MethodChannel(AppConstant.channelName);
            try {
              if (Platform.isIOS) {
                await platform.invokeMethod('fileviewer', fileName);
              }
            } on PlatformException catch (e) {
              print("Platform exception: ${e.message}");
            }
          } on DioError catch (e) {
            print(e.message);
          }
        }
      } else if (status[Permission.storage]!.isDenied) {
        Permission.storage.request();
        AlertMessage.showError(Utils.getStringValue(context, AppStringConstant.noPermissionToReadWriteStorage), context);
        debugPrint("permission is denied ->requesting");
      }
    } catch (e) {
      AlertMessage.showError(Utils.getStringValue(context, AppStringConstant.somethingWentWrong), context);
      debugPrint("exception while downloading file " + e.toString());
    }

  }
}
