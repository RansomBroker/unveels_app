import 'dart:async';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:drag_ball/drag_ball.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test_new/unvells/app_widgets/flux_image.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/constants/app_routes.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/app_storage_pref.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/screens/cart/bloc/cart_screen_bloc.dart';
import 'package:test_new/unvells/screens/cart/bloc/cart_screen_repository.dart';
import 'package:test_new/unvells/screens/category/category_screen.dart';
import 'package:test_new/unvells/screens/profile/bloc/profile_screen_repository.dart';
import 'package:test_new/unvells/screens/tech/tech_screen.dart';
import '../../constants/app_constants.dart';
import '../../screens/cart/cart_screen.dart';
import '../../screens/category/bloc/category_screen_bloc.dart';
import '../../screens/category/bloc/category_screen_repository.dart';
import '../../screens/category_listing/category_listing_screen.dart';
import '../../screens/home/bloc/home_screen_bloc.dart';
import '../../screens/home/bloc/home_screen_repository.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/profile/bloc/profile_screen_bloc.dart';
import '../../screens/profile/profile_screen.dart';
import 'badge_icon_update.dart';

class TabBarController {
  static StreamController<int> countController =
      StreamController<int>.broadcast();

  TabBarController._privateConstructor();

  static final TabBarController _instance =
      TabBarController._privateConstructor();

  factory TabBarController() {
    return _instance;
  }

  static void dispose() {}
}

class BottomTabBarWidget extends StatefulWidget {
  const BottomTabBarWidget({Key? key}) : super(key: key);

  @override
  _BottomTabBarWidgetState createState() => _BottomTabBarWidgetState();
}

class _BottomTabBarWidgetState extends State<BottomTabBarWidget> {
  int _selectedIndex = 0;
  int categoryIndex = 0;

  @override
  void initState() {
    _selectedIndex = 0;
    _setCartBadge();
    super.initState();
  }

  //to sync cart count on badge.
  void _setCartBadge() async {
    TabBarController.countController.sink.add(appStoragePref.getCartCount());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void moveToCategory(int index) {
    setState(() {
      _selectedIndex = index;
      categoryIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetList = [
      MultiBlocProvider(
        providers: [
          BlocProvider<HomeScreenBloc>(
            create: (context) => HomeScreenBloc(
              repository: HomeScreenRepositoryImp(),
            ),
          ),
        ],
        child: const HomeScreen(),
      ),
      MultiBlocProvider(
        providers: [
          BlocProvider<CategoryScreenBloc>(
            create: (context) => CategoryScreenBloc(
              repository: CategoryScreenRepositoryImp(),
            ),
          ),
        ],
        child: const CategoryScreen(),
      ),
      const TechScreen(),
      MultiBlocProvider(
        providers: [
          BlocProvider<ProfileScreenBloc>(
            create: (context) => ProfileScreenBloc(
              repository: ProfileScreenRepositoryImp(),
            ),
          ),
        ],
        child: const ProfileScreen(),
      ),
    ];

    return DoubleBack(
        message: Utils.getStringValue(
            context, AppStringConstant.pressBackAgainToExit),
        child: Dragball(
          ball: FloatingActionButton(
              mini: true,
              backgroundColor: const Color(0xFF303030),
              shape: const CircleBorder(),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.vaOnboarding);
              },
              child: Image.asset(
                'assets/images/va-logo.png',
              )),
          initialPosition: const DragballPosition(
              top: 500, isRight: true, ballState: BallState.show),
          onTap: () => debugPrint('Dragball Tapped'),
          withIcon: false,
          scrollAndHide: false,
          onPositionChanged: (DragballPosition position) =>
              debugPrint(position.toString()),
          child: Scaffold(
            body: widgetList.elementAt(_selectedIndex),
            extendBody: true,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.tryOn);
              },
              shape: const CircleBorder(),
              child: const FluxImage(
                  imageUrl: "assets/icons/camera.svg", color: Colors.black),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              child: BottomAppBar(
                elevation: 0,
                color: Colors.black,

                // notchMargin: 7,
                height: AppSizes.deviceHeight * .067,

                padding: const EdgeInsets.symmetric(horizontal: 10),
                shape: const CircularNotchedRectangle(),
                child: BottomNavigationBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: _selectedIndex,
                  onTap: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  selectedItemColor: AppColors.gold,
                  unselectedItemColor: Colors.white,
                  selectedLabelStyle: KTextStyle.of(context).boldTwelve,
                  unselectedLabelStyle: KTextStyle.of(context)
                      .boldTwelve
                      .copyWith(color: Colors.white),
                  items: [
                    BottomNavigationBarItem(
                      label:
                          Utils.getStringValue(context, AppStringConstant.home),
                      icon: _selectedIndex == 0
                          ? const FluxImage(
                              imageUrl: "assets/icons/home.svg",
                              color: AppColors.gold)
                          : const FluxImage(
                              imageUrl: "assets/icons/home.svg",
                              color: Colors.white),
                    ),
                    BottomNavigationBarItem(
                      icon: _selectedIndex == 1
                          ? const FluxImage(
                              imageUrl: "assets/icons/category.svg",
                              color: AppColors.gold)
                          : const FluxImage(
                              imageUrl: "assets/icons/category.svg",
                              color: Colors.white),
                      label: Utils.getStringValue(
                          context, AppStringConstant.categories),
                    ),
                    BottomNavigationBarItem(
                      icon: _selectedIndex == 2
                          ? const FluxImage(
                              imageUrl: "assets/icons/ai.png",
                              color: AppColors.gold)
                          : const FluxImage(
                              imageUrl: "assets/icons/ai.png",
                              color: Colors.white),
                      label:
                          Utils.getStringValue(context, AppStringConstant.tech),
                    ),
                    BottomNavigationBarItem(
                      icon: _selectedIndex == 3
                          ? const FluxImage(
                              imageUrl: "assets/icons/More.svg",
                              color: AppColors.gold)
                          : const FluxImage(
                              imageUrl: "assets/icons/More.svg",
                              color: Colors.white),
                      label: Utils.getStringValue(
                          context, AppStringConstant.account),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
