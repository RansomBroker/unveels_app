
/*
 *


 *
 * /
 */

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:test_new/unvells/helper/app_localizations.dart';
import 'package:test_new/unvells/helper/constants_helper.dart';
import 'package:test_new/unvells/helper/extension.dart';
import 'package:html/parser.dart';

import '../constants/app_constants.dart';
import 'LocalDb/floor/database.dart';

class Utils{

  static String getStringValue(BuildContext context, String key) {
    return AppLocalizations.of(context)?.translate(key) ?? key;
  }

  static void hideSoftKeyBoard() {
    SystemChannels.textInput.invokeMethod("TextInput.hide");
  }

  static Color orderStatusBackground(String status, String statusColor) {
    switch (status.toLowerCase()) {
      case ConstantsHelper.orderStatusDownload:
        if (statusColor.isEmpty) {
          return AppColors.orderStatusDownloadedColor;
        } else {
          return HexColor.fromHex(statusColor);
        }
      case ConstantsHelper.orderStatusComplete:
        if (statusColor.isEmpty) {
          return AppColors.orderStatusCompleteColor;
        } else {
          return HexColor.fromHex(statusColor);
        }
      case ConstantsHelper.orderStatusPending:
        if (statusColor.isEmpty) {
          return AppColors.orderStatusPendingColor;
        } else {
          return HexColor.fromHex(statusColor);
        }
      case ConstantsHelper.orderStatusProcessing:
        if (statusColor.isEmpty) {
          return AppColors.orderStatusProcessingColor;
        } else {
          return HexColor.fromHex(statusColor);
        }
      case ConstantsHelper.orderStatusHold:
        if (statusColor.isEmpty) {
          return AppColors.orderStatusHoldColor;
        } else {
          return HexColor.fromHex(statusColor);
        }
      case ConstantsHelper.orderStatusCancel:
        if (statusColor.isEmpty) {
          return AppColors.orderStatusCancelColor;
        } else {
          return HexColor.fromHex(statusColor);
        }
      case ConstantsHelper.orderStatusNew:
        if (statusColor.isEmpty) {
          return AppColors.orderStatusNewColor;
        } else {
          return HexColor.fromHex(statusColor);
        }
      case ConstantsHelper.orderStatusClosed:
        if (statusColor.isEmpty) {
          return AppColors.orderStatusClosedColor;
        } else {
          return HexColor.fromHex(statusColor);
        }
      default:
        return AppColors.yellow;
    }
  }

  static ratingBackground(String ratingValue) {
    if(ratingValue.isNotEmpty) {
      if (double.parse(ratingValue) < 2) {
        return AppColors.singleStarColor;
      } else if (double.parse(ratingValue) < 3) {
        return AppColors.twoStarColor;
      } else if (double.parse(ratingValue) < 4) {
        return AppColors.threeStarColor;
      } else if (double.parse(ratingValue) < 5) {
        return AppColors.fourStarColor;
      }  else if (double.parse(ratingValue) == 5) {
        return AppColors.fiveStarColor;
      } else {
        return AppColors.singleStarColor;
      }
    } else {
      AppColors.singleStarColor;
    }
  }

  static getColor(String color) {
    if (color != null) {
      String removeHex = color.replaceFirst("#", '').toString();
      String newColor = "0xFF$removeHex";
      int colorValue = int.parse(newColor);
      return colorValue;
    } else {
      return 0xFFF5F5DC;
    }
  }

  static Future<bool> connectedToNetwork() async{
    // print('RESULT----->${result}');

    var result = await Connectivity().checkConnectivity();
    print('RESULT----->${result}');
    if(result == ConnectivityResult.mobile) {
      print("Internet connection is from Mobile data");
      return true;
    }else if(result == ConnectivityResult.wifi) {
      print("internet connection is from wifi");
      return true;
    }else if(result == ConnectivityResult.ethernet){
      print("internet connection is from wired cable");
      return true;
    }else if(result == ConnectivityResult.bluetooth){
      print("internet connection is from bluethooth threatening");
      return true;
    }else {
      print("No internet connection");
      return false;
    }
    print('RESULT----->${result}');
  }

  static String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body?.text??"").documentElement?.text??"";

    return parsedString;
  }

  static void clearRecentProducts() {
    AppDatabase.getDatabase().then(
            (value) => value.recentProductDao
            .deleteRecentProducts());
  }

  static String? replaceWhitespacesUsingRegex(String s, String replace) {
    final pattern = RegExp('\\s+');
    return s.replaceAll(pattern, replace);
  }
  static String? getCustomAttribute(customAttributes, attribute) {
    String? value;
    if (customAttributes != null && customAttributes.length > 0) {
      for (var item in customAttributes) {
        if (item['attribute_code'] == attribute) {
          value = item['value'];
          break;
        }
      }
    }
    return value;
  }
}