import 'package:flutter/material.dart';

import '../helper/app_storage_pref.dart';

class KTextStyle {
  static KTextStyle? _instance;

  KTextStyle._internal() {
    _instance = this;
  }

  static KTextStyle of(BuildContext context) {
    return _instance ?? KTextStyle._internal();
  }

  static  String get fontFamily => appStoragePref.getStoreCode=="en"?'Lato':"Cairo";

  //Light

  //Getters

  TextStyle get eight {
    return  TextStyle(
      color: Colors.black,
      fontSize: 8,
      fontFamily: fontFamily,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle get boldEight {
    return  TextStyle(
      color: Colors.black,
      fontSize: 8,
      fontFamily: fontFamily,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get twelve {
    return  TextStyle(
      color: Colors.black,
      fontSize: 12,
      fontFamily: fontFamily,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle get eighteen {
    return TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontFamily: fontFamily,
      fontWeight: FontWeight.normal,
    );
  }
  TextStyle get twenty {
    return TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontFamily: fontFamily,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle get semiTwelve {
    return  TextStyle(
      color: Colors.black,
      fontSize: 12,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle get boldTwelve {
    return  TextStyle(
      color: Colors.black,
      fontSize: 12,
      fontFamily: fontFamily,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get sixteen {
    return  TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontFamily: fontFamily,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle get semiBoldSixteen {
    return  TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle get boldSixteen {
    return  TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
    );
  }  TextStyle get twentyFour {
    return  TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontFamily: fontFamily,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle get semiBold24 {
    return  TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle get bold24{
    return  TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle get bold32 {
    return  TextStyle(
      color: Colors.black,
      fontSize: 30,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle get error {
    return  TextStyle(
        color: Colors.red, fontSize: 15, fontFamily: fontFamily);
  }
}
