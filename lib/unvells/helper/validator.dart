/*
 *


 *
 * /
 */

import 'package:flutter/cupertino.dart';

import '../constants/app_string_constant.dart';
import '../helper/app_localizations.dart';

class Validator {
  static bool isEmpty(String value) {
    return value.isEmpty;
  }

  static String? isEmailValid(String email, BuildContext context) {
    var emailRegExp = RegExp("[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+");
    if (isEmpty(email)) {
      return  AppLocalizations.of(context)
          ?.translate(AppStringConstant.required);
    } else if (!emailRegExp.hasMatch(email)) {
      return AppLocalizations.of(context)
          ?.translate( AppStringConstant.enterValidEmail);
    }
    return null;
  }

  static String? isValidPassword(String password,BuildContext context) {
    if (isEmpty(password)) {
      return   AppLocalizations.of(context)
          ?.translate(AppStringConstant.passwordIsRequired);
    } else if (password.trim().length < 4) {
      return   AppLocalizations.of(context)
          ?.translate( AppStringConstant.shortPasswordMsg);
    }
    return null;
  }

  static String? isValidName(String name) {
    var nameRegexp = RegExp("[^0-9!<>,;?=+()@#\"°{}_\$%:]*");
    if (isEmpty(name)) {
      return  AppStringConstant.enterValidName;
    } else if (!nameRegexp.hasMatch(name)) {
      return AppStringConstant.enterValidName;
    }
    return null;
  }
}
