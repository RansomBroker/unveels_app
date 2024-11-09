/*
 *


 *
 * /
 */

import 'dart:ui';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:test_new/unvells/app_widgets/Tabbar/bottom_tabbar.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/app_storage_pref.dart';
import 'package:upgrader/upgrader.dart';
import 'unvells/configuration/unvells_theme.dart';
import 'unvells/constants/app_constants.dart';
import 'unvells/constants/app_routes.dart';
import 'unvells/helper/PreCacheApiHelper.dart';
import 'unvells/helper/app_localizations.dart';
import 'unvells/helper/push_notifications_manager.dart';
import 'unvells/screens/home/widgets/item_card_bloc/item_card_bloc.dart';
import 'unvells/screens/home/widgets/item_card_bloc/item_card_repository.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  var data = message.data;
  if (kDebugMode) {
    print("===>>>${message.data}");
  }
  if (data.isNotEmpty) {
    var notificationId = data["id"];
    var notificationType = data["notificationType"];
    var notificationTitle = data["title"];
    var notificationBody = data["body"];
    var notificationBanner = data["banner_url"];

    PushNotificationsManager().showNotification(notificationTitle!,
        notificationBody!, json.encode(data), notificationBanner);
  }
  print('Handling a background message ${message.messageId}');
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await initHiveForFlutter();
  await GetStorage().initStorage;
  await AppStoragePref().init();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  mainBox = await HiveStore.openBox("graphqlClientStore");
  // HttpOverrides.global =  MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await Upgrader.clearSavedSettings(); ///Debug use only
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStringConstant.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UpgradeAlert(
        upgrader: Upgrader(),
        child: const UnvellsApp(),
      ),
    );
  }
}

class UnvellsApp extends StatefulWidget {
  const UnvellsApp({Key? key}) : super(key: key);

  //for change locale run time
  static void setLocale(BuildContext context, Locale newLocale) {
    _UnvellsAppState? state =
        context.findAncestorStateOfType<_UnvellsAppState>();
    state!.refresh(newLocale);
  }

  @override
  State<UnvellsApp> createState() => _UnvellsAppState();
}

class _UnvellsAppState extends State<UnvellsApp> {
  bool isDarkMode = false;
  Locale? _locale;

  @override
  void initState() {
    // PushNotificationsManager().setUpFirebase(context);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var locale = _fetchLocale();
      setState(() {
        _locale = locale;
        AppLocalizations.of(context)?.load(_locale ??
            Locale.fromSubtags(languageCode: appStoragePref.getStoreCode));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: ChangeNotifierProvider(
          create: (_) => CheckTheme(),
          child: Consumer<CheckTheme>(
              builder: (context, CheckTheme themeNotifier, child) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<ItemCardBloc>(
                  create: (context) => ItemCardBloc(
                    repository: ItemCardRepositoryImp(),
                  ),
                ),
              ],
              child: MaterialApp(
                  theme: AppTheme.lightTheme,
                  // darkTheme: AppTheme.darkTheme,
                  onGenerateRoute: AppRoutes.generateRoute,
                  supportedLocales:
                      AppConstant.supportedLanguages.map((e) => Locale(e)),
                  locale: _locale,
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate, //
                  ],
                  initialRoute: AppRoutes.splash,
                  home: const BottomTabBarWidget(),
                  debugShowCheckedModeBanner: false,
                  navigatorKey: navigatorKey,
                  localeResolutionCallback: (locale, supportedLocales) {
                    if (supportedLocales.contains(_locale)) {
                      return _locale;
                    } else {
                      return supportedLocales.first;
                    }
                  }),
            );
          })),
    );
  }

  //check isDarkMode
  void checkDarkMode() {
    setState(() {
      isDarkMode = appStoragePref.isDarkMode();
    });
  }

  //refresh locale
  refresh(Locale newLocale) => setState(() {
        _locale = newLocale;
      });

  Locale _fetchLocale() {
    final String savedLocale = appStoragePref.getStoreCode;
    var locale = const Locale('en', 'US');
    if (savedLocale == 'en') {
      locale = const Locale('en', 'US');
    } else if (savedLocale == 'ar') {
      locale = const Locale('ar', 'AE');
    }
    return locale;
  }
}
