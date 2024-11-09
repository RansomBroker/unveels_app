/*
 *


 *
 * /
 */

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:test_new/unvells/helper/app_storage_pref.dart';

import '../constants/app_constants.dart';

class UnvellsTheme {
  static  Color primaryColor = const Color(0xFF000000);
  static  Color accentColor = const Color(0xFFcb9d46);

// static  Color primaryColor = Colors.green;
// static  Color accentColor = Color(0xFFECE607);

  static  Color diffColor = const Color(0xFF339EF1);
}

class AppTheme {
  AppTheme._();

  //Applied on Scaffold
  static final Color _lightScaffoldColor = Colors.grey.shade200;
  static  const Color _darkScaffoldColor = Colors.black26;

  //Applied on Scaffold where TextFormFields are used
  static  const Color _lightCustomScaffoldBgColor = Colors.white;
  static  const Color _darkCustomScaffoldBgColor = Colors.black;

  //Applied on AppBar
  static  const Color _lightAppBarColor = Colors.white;
  static  const Color _darkAppBarColor = Colors.black;

  //Applied on Icons
  static  const Color _lightIconColor = Colors.black;
  static  const Color _darkIconColor = Colors.white;

  //Applied on Card/Container
  static  const Color _lightCardColor = Colors.white;
  static  const Color _darkCardColor = Colors.black54;

  //Applied on Divider
  static  const Color _lightDividerColor = Colors.black26;
  static  const Color _darkDividerColor = Colors.white70;

  //Applied on Button
  static  final Color _lightBtnColor = UnvellsTheme.accentColor;
  static  const Color _darkBtnColor = Colors.green;

  //Applied on CustomOutlineButton ( Used on "All Orders Screen" )
  static  final Color _lightCustomOutlineBtnColor = UnvellsTheme.accentColor;
  static  const Color _darkCustomOutlineBtnColor = Colors.green;

  //Applied on OutlinedTextButton's Text
  static  final Color _lightOutlinedCenterTextColor = UnvellsTheme.accentColor;
  static  const Color _darkOutlinedCenterTextColor = Colors.white;

  static  final Color _lightPrimaryColor = UnvellsTheme.accentColor;
  static  const Color _darkPrimaryColor = Colors.green;

  // static  Color _darkPrimaryVariantColor = Colors.black87;

  static  const Color _lightSecondaryColor = Colors.green;
  static  const Color _darkSecondaryColor = Colors.black;

  // static  Color _darkSecondaryColor = Colors.white;

  static  const Color _lightOnPrimaryColor = Colors.black;
  static  const Color _darkOnPrimaryColor = Colors.green;

  /// light theme ///
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme:  AppBarTheme(
      titleTextStyle: TextStyle(
          color: _darkSecondaryColor,
          fontFamily: fontFamily,
          fontWeight: FontWeight.bold,
          fontSize: AppSizes.textSizeXLarge),
      color: _lightAppBarColor,
      iconTheme: const IconThemeData(color: _lightIconColor),
    ),
    // bottomNavigationBarTheme:  BottomNavigationBarThemeData(
    //     backgroundColor: _lightAppBarColor,
    //     selectedIconTheme: IconThemeData(color: _lightIconColor),
    //     selectedLabelStyle: TextStyle(color: _lightIconColor)),
    colorScheme:  ColorScheme.light(
      primary: _lightPrimaryColor,
      primaryContainer: _lightPrimaryColor,
      // primaryVariant: _lightPrimaryColor,
      secondary: _lightSecondaryColor,
      onPrimary: _lightOnPrimaryColor,
      outline: _lightOutlinedCenterTextColor,
      //Applied on Scaffold white
      background: _lightCustomScaffoldBgColor,
    ),
    iconTheme:  const IconThemeData(
      color: _lightIconColor,
    ),
    textTheme: _lightTextTheme,
    dividerTheme:  const DividerThemeData(color: _lightDividerColor),
    cardColor: _lightCardColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 5.0,
        backgroundColor: _lightBtnColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle:  const TextStyle(
            color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
      ),
    ),
    // textButtonTheme: TextButtonThemeData(
    //   style: ButtonStyle(
    //     backgroundColor: MaterialStateProperty.all<Color>(_lightBtnColor),
    //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    //       RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(8.0),
    //       ),
    //     ),
    //   ),
    // ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          side:  BorderSide(color: UnvellsTheme.accentColor),
          shape:  const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          backgroundColor: Colors.transparent),
    ),
    buttonTheme:  ButtonThemeData(
        colorScheme:
            ColorScheme.light(background: _lightCustomOutlineBtnColor)),
    // buttonColor: _lightCustomOutlineBtnColor,
    // Override the button color for the date picker dialog
    dialogTheme:  const DialogTheme(
      contentTextStyle: TextStyle(
        decorationColor: Colors.blue,
      ),
    ),
  );

  /// dark theme ///
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: _darkScaffoldColor,
    appBarTheme:  const AppBarTheme(
      color: _darkAppBarColor,
      iconTheme: IconThemeData(color: _darkIconColor),
    ),
    colorScheme:  const ColorScheme.dark(
      primary: _darkPrimaryColor,
      primaryContainer: _darkPrimaryColor,
      // primaryVariant: _darkPrimaryColor,
      secondary: _darkSecondaryColor,
      onPrimary: _darkOnPrimaryColor,
      outline: _darkOutlinedCenterTextColor,

      //Applied on Scaffold white
      background: _darkCustomScaffoldBgColor,
    ),
    iconTheme:  const IconThemeData(color: _darkIconColor),
    textTheme: _darkTextTheme,
    // bottomNavigationBarTheme:  BottomNavigationBarThemeData(
    //     backgroundColor: _darkAppBarColor,
    //     selectedIconTheme: IconThemeData(color: _darkIconColor),
    //     selectedLabelStyle: TextStyle(color: _darkIconColor)),
    dividerTheme:  const DividerThemeData(color: _darkDividerColor),
    cardColor: _darkCardColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 5.0,
        backgroundColor: _darkBtnColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle:  const TextStyle(
            color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
      ),
    ),
    // textButtonTheme: TextButtonThemeData(
    //   style: ButtonStyle(
    //     backgroundColor: MaterialStateProperty.all<Color>(_darkBtnColor),
    //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    //       RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(8.0),
    //       ),
    //     ),
    //   ),
    // ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          side:  const BorderSide(
            color: Colors.white,
          ),
          shape:  const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          backgroundColor: Colors.black45),
    ),
    buttonTheme:  const ButtonThemeData(
        colorScheme: ColorScheme.dark(background: _darkCustomOutlineBtnColor)),
    // buttonColor: _darkCustomOutlineBtnColor,
    dialogTheme:  const DialogTheme(
      contentTextStyle: TextStyle(
        decorationColor: Colors.blue,
      ),
    ),
  );

  static  final TextTheme _lightTextTheme = TextTheme(
    displayLarge: _lightScreenHeading1TextStyle,
    displayMedium: _lightScreenHeading2TextStyle,
    displaySmall: _lightScreenHeading3TextStyle,
    headlineMedium: _lightScreenHeading4TextStyle,
    headlineSmall: _lightScreenHeading5TextStyle,
    titleLarge: _lightScreenHeading6TextStyle,
    titleMedium: _lightScreenSubTile1TextStyle,
    titleSmall: _lightScreenSubTile2TextStyle,
    bodyLarge: _lightScreenTaskNameTextStyle,
    bodyMedium: _lightScreenTaskDurationTextStyle,
    labelLarge: _lightScreenButtonTextStyle,
  );

  static  String get fontFamily => appStoragePref.getStoreCode=="en"?'Lato':"Cairo";

  static  const TextTheme _darkTextTheme = TextTheme(
      // headline1: _darkScreenHeading1TextStyle,
      // displayMedium: _darkScreenHeading2TextStyle,
      // displaySmall: _darkScreenHeading3TextStyle,
      // headlineLarge: _darkScreenHeading4TextStyle,
      // headlineSmall: _darkScreenHeading5TextStyle,
      // titleLarge: _darkScreenHeading6TextStyle,
      // titleMedium: _darkScreenSubTile1TextStyle,
      // titleSmall: _darkScreenSubTile2TextStyle,
      // bodyLarge: _darkScreenTaskNameTextStyle,
      // bodyMedium: _darkScreenTaskDurationTextStyle,
      // button: _darkScreenButtonTextStyle,
      );

  /// light theme text style ///
  static  final TextStyle _lightScreenHeading1TextStyle = TextStyle(
      fontSize: AppSizes.textSizeXLarge,
      fontWeight: FontWeight.bold,
      color: AppColors.textColorPrimary,
      fontFamily: fontFamily);

  static  final TextStyle _lightScreenHeading2TextStyle = TextStyle(
    fontSize: AppSizes.textSizeLarge,
    fontWeight: FontWeight.bold,
    color: AppColors.textColorPrimary,
    fontFamily: fontFamily,
  );

  static  final TextStyle _lightScreenHeading3TextStyle = TextStyle(
      fontSize: AppSizes.textSizeMedium,
      fontWeight: FontWeight.bold,
      color: AppColors.textColorPrimary,
      fontFamily: fontFamily);

  static  final TextStyle _lightScreenHeading4TextStyle = TextStyle(
      fontSize: AppSizes.textSizeMedium,
      fontWeight: FontWeight.bold,
      color: AppColors.textColorSecondary,
      fontFamily: fontFamily);

  static  final TextStyle _lightScreenHeading5TextStyle = TextStyle(
      fontSize: AppSizes.textSizeSmall,
      fontWeight: FontWeight.bold,
      color: AppColors.textColorPrimary,
      fontFamily: fontFamily);

  static  final TextStyle _lightScreenHeading6TextStyle = TextStyle(
    fontSize: AppSizes.textSizeSmall,
    fontWeight: FontWeight.bold,
    color: AppColors.textColorSecondary,
    fontFamily: fontFamily,
  );

  static  final TextStyle _lightScreenTaskNameTextStyle = TextStyle(
      fontSize: AppSizes.textSizeSmall,
      color: AppColors.textColorPrimary,
      fontFamily: fontFamily);

  static  final TextStyle _lightScreenTaskDurationTextStyle = TextStyle(
      fontSize: AppSizes.textSizeSmall,
      color: AppColors.textColorSecondary,
      fontFamily: fontFamily);

  static  final TextStyle _lightScreenSubTile1TextStyle = TextStyle(
      fontSize: AppSizes.textSizeMedium,
      color: AppColors.textColorPrimary,
      fontFamily: fontFamily);

  static  final TextStyle _lightScreenSubTile2TextStyle = TextStyle(
      fontSize: AppSizes.textSizeMedium,
      color: AppColors.textColorSecondary,
      fontFamily: fontFamily);

  static  final TextStyle _lightScreenButtonTextStyle = TextStyle(
      fontSize: AppSizes.textSizeMedium,
      fontWeight: FontWeight.bold,
      color: UnvellsTheme.accentColor,
      fontFamily: fontFamily);

  /// dark theme text style ///
  static final TextStyle _darkScreenHeading1TextStyle =
      _lightScreenHeading1TextStyle.copyWith(
          color: AppColorsDark.textColorPrimary);

  static final TextStyle _darkScreenHeading2TextStyle =
      _lightScreenHeading2TextStyle.copyWith(
          color: AppColorsDark.textColorPrimary);

  static final TextStyle _darkScreenHeading3TextStyle =
      _lightScreenHeading3TextStyle.copyWith(
          color: AppColorsDark.textColorPrimary);

  static final TextStyle _darkScreenHeading4TextStyle =
      _lightScreenHeading4TextStyle.copyWith(
          color: AppColorsDark.textColorSecondary);

  static final TextStyle _darkScreenHeading5TextStyle =
      _lightScreenHeading5TextStyle.copyWith(
          color: AppColorsDark.textColorPrimary);

  static final TextStyle _darkScreenHeading6TextStyle =
      _lightScreenHeading6TextStyle.copyWith(
          color: AppColorsDark.textColorSecondary);

  static final TextStyle _darkScreenTaskNameTextStyle =
      _lightScreenTaskNameTextStyle.copyWith(
          color: AppColorsDark.textColorPrimary);

  static final TextStyle _darkScreenTaskDurationTextStyle =
      _lightScreenTaskDurationTextStyle.copyWith(
          color: AppColorsDark.textColorSecondary);

  static final TextStyle _darkScreenSubTile1TextStyle =
      _lightScreenSubTile1TextStyle.copyWith(
          color: AppColorsDark.textColorPrimary);

  static final TextStyle _darkScreenSubTile2TextStyle =
      _lightScreenSubTile2TextStyle.copyWith(
          color: AppColorsDark.textColorSecondary);

  static  final TextStyle _darkScreenButtonTextStyle = TextStyle(
      fontSize: AppSizes.textSizeMedium,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontFamily: fontFamily);
}

//Manage the theme by toggle from profile
class CheckTheme extends ChangeNotifier {
  late String _isDark;
  late AppStoragePref _appStoragePref;

  String get isDark => _isDark;

  CheckTheme() {
    _isDark = "false";
    _appStoragePref = AppStoragePref();
    getPreferences();
  }

//Switching the themes
  set isDark(String value) {
    _isDark = value;
    _appStoragePref.setTheme(value);
    notifyListeners();
  }

  getPreferences() async {
    _isDark = await _appStoragePref.getTheme();
    notifyListeners();
    print(_isDark);
    if (_isDark == "") {
      print("Fetching Device Theme Data");
      if (window.platformBrightness == Brightness.dark) {
        _isDark = "true";
        _appStoragePref.setTheme("true");
      } else {
        _isDark = "false";
        _appStoragePref.setTheme("false");
      }
    } else {
      _isDark = await _appStoragePref.getTheme();
      notifyListeners();
      print(_isDark);
    }
  }
}
