/*
 *


 *
 * /
 */

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../app_widgets/app_alert_message.dart';
import '../helper/app_localizations.dart';
import '../models/downloadable_products/downloadable_products_list_model.dart';

class Download {
  var tag = "DownloadInvoice ";
  String savePath = "";

  Future downloadProduct(DownloadableProductsListData? downloadItem, BuildContext context) async {
  //  if (fileType.isNotEmpty) {
     // var url =" ";
      //print(tag + url);
      try {
        Dio dio = Dio();
        var status = await Permission.storage.status;
        if (status.isGranted) {
          print(tag + "permission is granted");
          String fileName = downloadItem?.hash??"product";
          savePath = await getFilePath(fileName);

          AlertMessage.showSuccess(
              AppLocalizations.of(context)?.translate("downloading") ??
                  "Downloading",
              context);
          await dio.download( downloadItem?.hash??"", savePath,
              onReceiveProgress: (received, total) {
            print(tag +
                " Download started received" +
                received.toString() +
                " total " +
                total.toString());
          });
          const platform = MethodChannel('com.webkul.oc.methodchannel');
          try {
            if (Platform.isAndroid) {
              await platform.invokeMethod('fileviewer', savePath);
            } else {
              await platform.invokeMethod('fileviewer', fileName);
            }
          } on PlatformException catch (e) {
          }
          AlertMessage.showSuccess(
              AppLocalizations.of(context)?.translate("download_complete") ??
                  "Download completed",
              context);
        } else if (status.isDenied) {
          Permission.storage.request();
          print(tag + "permission is denied ->requesting");
        }
      } catch (e) {
        print(tag + "exception while downloading invoice " + e.toString());
      }
   // }
  }

  /*
  * Will return the directory path at which invoice will save.
  * it will not return the external directory path
  * ToDo: Need to check it to save it in external directory like Download
  * */
  Future<String> getFilePath(fileName) async {
    String path = '';
    // var pat_h = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
    // Directory dir = await getApplicationDocumentsDirectory();
    Directory? dir =  Platform.isAndroid
        ? await getExternalStorageDirectory() //FOR ANDROID
        : await getApplicationDocumentsDirectory(); ;
    path = '${dir?.path}/$fileName';
    return path;
  }
/*
  Future downloadInvoice(String invoiceId, BuildContext context) async {
    if (invoiceId.isNotEmpty) {
      var url = ApiConstant.baseUrl +
          Apis.getpdf +
          "id_order=" +
          invoiceId +
          "&id_lang=" +
          await AppSharedPref.getLanguage() +
          "&id_currency=" +
          await AppSharedPref.getCurrency() +
          "&id_customer=" +
          await AppSharedPref.getCustomerId() +
          "&ws_key=" +
          ApiConstant.wsKey +
          "&object=invoice";
      print(tag + url);
      try {
        Dio dio = Dio();
        var status = await Permission.storage.status;
        if (status.isGranted) {
          print(tag + "permission is granted");
          String fileName = "invoice" + invoiceId + ".pdf";
          savePath = await getFilePath(fileName);
          print(tag + "permission is granted  and path is: " + savePath);
          AlertMessage.showSuccess(
              AppLocalizations.of(context)?.translate("downloading") ??
                  "Downloading",
              context);
          await dio.download(url, savePath,
              onReceiveProgress: (received, total) {
            print(tag +
                " Download started received" +
                received.toString() +
                " total " +
                total.toString());
          });
          const platform = MethodChannel('com.mlkit');
          try {
            if (Platform.isAndroid) {
              await platform.invokeMethod('fileviewer', savePath);
            } else {
              await platform.invokeMethod('fileviewer', fileName);
            }
          } on PlatformException catch (e) {
          }
          AlertMessage.showSuccess(
              AppLocalizations.of(context)?.translate("download_complete") ??
                  "Download completed",
              context);
        } else if (status.isDenied) {
          Permission.storage.request();
          print(tag + "permission is denied ->requesting");
        }
      } catch (e) {
        print(tag + "exception while downloading invoice " + e.toString());
      }
    }
  }

  Future downloadCreditSlip(String slipId, BuildContext context) async {
    if (slipId.isNotEmpty) {
      var url = ApiConstant.baseUrl +
          Apis.getpdf +
          "id_order_slip=" +
          slipId +
          "&id_lang=" +
          await AppSharedPref.getLanguage() +
          "&id_currency=" +
          await AppSharedPref.getCurrency() +
          "&id_customer=" +
          await AppSharedPref.getCustomerId() +
          "&ws_key=" +
          ApiConstant.wsKey +
          "&object=credit_slips";
      print(tag + url);
      try {
        Dio dio = Dio();
        var status = await Permission.storage.status;
        if (status.isGranted) {
          print(tag + "permission is granted");
          String fileName = "creditSlip" + slipId + ".pdf";
          savePath = await getFilePath(fileName);

          AlertMessage.showSuccess(
              AppLocalizations.of(context)?.translate("downloading") ??
                  "Downloading",
              context);
          await dio.download(url, savePath,
              onReceiveProgress: (received, total) {
            print(tag +
                " Download started received" +
                received.toString() +
                " total " +
                total.toString());
          });

          const platform = MethodChannel('com.mlkit');
          try {
            if (Platform.isAndroid) {
              await platform.invokeMethod('fileviewer', savePath);
            } else {
              await platform.invokeMethod('fileviewer', fileName);
            }
          } on PlatformException catch (e) {
          }
          AlertMessage.showSuccess(
              AppLocalizations.of(context)?.translate("download_complete") ??
                  "Download completed",
              context);
        } else if (status.isDenied) {
          Permission.storage.request();
          print(tag + "permission is denied ->requesting");
        }
      } catch (e) {
        print(tag + "exception while downloading invoice " + e.toString());
      }
    }
  }*/
}
