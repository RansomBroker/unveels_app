/*
 *


 *
 * /
 */

import 'dart:math';

import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test_new/unvells/app_widgets/Tabbar/badge_icon_update.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/constants/app_routes.dart';
import 'package:test_new/unvells/helper/PreCacheApiHelper.dart';
import 'package:test_new/unvells/helper/app_storage_pref.dart';
import 'package:test_new/unvells/helper/extension.dart';
import 'package:test_new/unvells/screens/home/widgets/category_widget_type1.dart';
import 'package:test_new/unvells/screens/home/widgets/category_widget_type2.dart';
import 'package:test_new/unvells/screens/home/widgets/home_banners.dart';
import 'package:test_new/unvells/screens/home/widgets/home_slider.dart';
import 'package:test_new/unvells/screens/home/widgets/product_carasoul_widget_type1.dart';
import 'package:test_new/unvells/screens/home/widgets/product_carasoul_widget_type2.dart';
import 'package:test_new/unvells/screens/home/widgets/product_carasoul_widget_type4.dart';
import 'package:test_new/unvells/screens/home/widgets/recent_view.dart';
import 'package:test_new/voice_command/services/voice_command_cubit.dart';
import '../../app_widgets/app_dialog_helper.dart';
import '../../app_widgets/app_tool_bar.dart';
import '../../app_widgets/badge_icon.dart';
import '../../app_widgets/flux_image.dart';
import '../../app_widgets/image_view.dart';
import '../../app_widgets/loader.dart';
import '../../constants/app_string_constant.dart';
import '../../constants/global_data.dart';
import '../../helper/app_localizations.dart';
import '../../helper/bottom_sheet_helper.dart';
import '../../helper/push_notifications_manager.dart';
import '../../helper/utils.dart';
import '../../models/homePage/home_page_carausel.dart';
import '../../models/homePage/home_screen_model.dart';
import '../../models/homePage/sort_order.dart';
import '../../models/productDetail/product_detail_page_model.dart';
import 'widgets/product_carasoul_widget_type3.dart';
import 'bloc/home_screen_bloc.dart';
import 'bloc/home_screen_events.dart';
import 'bloc/home_screen_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  @override
  bool get wantKeepAlive => true;
  HomeScreenBloc? homePageBloc;
  bool isLoading = true;
  HomePageData? homePageData;
  List<Widget> homePageWidgets = [];
  List<SortOrder> sortedOrder = [];

  // bool appStoragePref.isFirstTime()=true;

  @override
  void initState() {
    super.initState();

    debugPrint("appStoragePref.isFirstTime() $homePageData");
    debugPrint("${appStoragePref.getBearerToken()} bearerToken");
    debugPrint("${appStoragePref.getCartId()} cartId");
    if (appStoragePref.isFirstTime()) {
      // PushNotificationsManager().setUpFirebase(context);
      // PushNotificationsManager().checkInitialMessage(context);
      HiveStore.openBox("graphqlClientStore").then((value) {
        mainBox = value;
      });
      if (homePageData?.categories != null &&
          homePageData!.categories!.isNotEmpty) {
        precCacheCategoryPage(homePageData?.categories?[0].id ?? 0);
      }
    }

    // Get the BLoC
    homePageBloc = context.read<HomeScreenBloc>();

    // Initialize Hive box asynchronously

    // Set isFirstTime to false after the first check

    // Check if GlobalData.homePageData is available
    if (GlobalData.homePageData != null) {
      // Always override homePageData with GlobalData.homePageData to ensure the data is fresh
      homePageData = GlobalData.homePageData;

      // Emit loading state, then let the UI react to this new data
      homePageBloc?.emit(HomeScreenSuccess(homePageData!, false));
    } else {
      // If there's no global data, fetch the data fresh from the network or cache
      homePageBloc?.add(const HomeScreenDataFetchEvent(false));
    }

    debugPrint("Updated homePageData: $homePageData");

    // Pre-cache category page if the data exists

    // Set up Firebase after page load
  }

  @override
  Widget build(BuildContext context) {
    print("first call${appStoragePref.isFirstTime()}");
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      // floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      // floatingActionButton: Column(
      //
      //   children: [
      //     FloatingActionButton(
      //       onPressed: () {
      //       },
      //       backgroundColor: Colors.transparent,
      //       child: const FluxImage(imageUrl: 'assets/icons/ai1.png',),
      //     ),
      //     FloatingActionButton(
      //       onPressed: () {
      //       },
      //       backgroundColor: Colors.transparent,
      //       child: const FluxImage(imageUrl: 'assets/icons/ai2.png',),
      //
      //     ),
      //
      //   ],
      // ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: AppSizes.deviceHeight * .08,

        // titleSpacing: 5,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.cart);
              },
              icon: const BadgeIconUpdate(
                iconColor: Colors.white,
              )),
        ],

        titleSpacing: 0,
        // leadingWidth: 20,
        leading: const Padding(
          padding: EdgeInsetsDirectional.only(start: 10),
          child: FluxImage(
            imageUrl: AppImages.placeholder,
            // height: 44,
            // width: 43,
          ),
        ),
        centerTitle: true,

        title: Padding(
          padding: const EdgeInsetsDirectional.only(start: 8),
          child: SizedBox(
            height: 40,
            // width: 43,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.search);
              },
              child: CupertinoSearchTextField(
                  suffixMode: OverlayVisibilityMode.always,
                  // padding: const EdgeInsets.all(8),
                  // backgroundColor: Colors.re,
                  itemSize: 20,
                  suffixIcon: const Icon(
                    Icons.mic,
                    // color: Colors.red,
                  ),
                  enabled: false,
                  itemColor: const Color(0xff5E6672),

                  // readOnly: _isLisstening,
                  // controller: _searchText,
                  // onChanged: (searchKey) {
                  //   print("Search key ---> " + searchKey);
                  //   searchBloc?.add(SearchSuggestionEvent(searchKey));
                  // },
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0xFFE2E2E2),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  style: KTextStyle.of(context).semiBoldSixteen.copyWith(
                      color: const Color(
                        0xFFB1B1B1,
                      ),
                      height: 1)),
            ),
          ),
        ),
      ),

      // appBar: appToolBar(
      //     Utils.getStringValue(context, AppStringConstant.appName), context,
      //     isHomeEnable: true,
      //     actions: [
      //       IconButton(
      //           onPressed: () {
      //             Navigator.pushNamed(context, AppRoutes.search);
      //           },
      //           icon: const Icon(
      //             Icons.search,
      //           )),
      //       IconButton(
      //           onPressed: () {
      //             notificationBottomModelSheet(context);
      //           },
      //           icon: const Icon(
      //             Icons.notifications,
      //           ))
      //     ]),
      body: mainView(),
    );
  }

  Widget mainView() {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, currentState) {
        debugPrint("currentState: " + currentState.toString());
        if (currentState is HomeScreenInitial) {
          isLoading = true;
        } else if (currentState is HomeScreenDataLoading) {
          // isLoading = false;
          // setUpDynamicLayouts();
        } else if (currentState is HomeScreenSuccess) {
          debugPrint("asdasdasdasdds");
          // HiveStore().reset();

          isLoading = false;
          homePageWidgets = [];
          homePageData == null;
          setUpDynamicLayouts();
          GlobalData.homePageData = currentState.homePageData;
          homePageData = currentState.homePageData;
          appStoragePref
              .setWatchEnabled(currentState.homePageData.watchEnabled ?? false);

          homePageBloc?.add(const CartCountFetchEvent());
          homePageBloc?.emit(HomeScreenDataLoading());
        } else if (currentState is CartCountSuccess) {
          isLoading = false;
          appStoragePref.setCartCount(currentState.homePageData.cartCount);
          homePageBloc?.emit(HomeScreenEmptyState());
        } else if (currentState is OtherError) {
          isLoading = false;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AppDialogHelper.errorDialog(
              currentState.message ?? AppStringConstant.errorRequest,
              context,
              AppLocalizations.of(context),
              title: AppStringConstant.somethingWentWrong,
              cancelable: true,
              onConfirm: () async {
                appStoragePref.logoutUser();
                homePageBloc?.add(const HomeScreenDataFetchEvent(false));
              },
            );
          });
        } else if (currentState is HomeScreenError) {
          isLoading = false;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AppDialogHelper.errorDialog(
              AppStringConstant.errorRequest,
              context,
              AppLocalizations.of(context),
              title: AppStringConstant.somethingWentWrong,
              cancelable: true,
              onConfirm: () async {
                homePageBloc?.add(const HomeScreenDataFetchEvent(false));
              },
            );
          });
        }
        return _buildUI();
      },
    );
  }

  final ScrollController _scrollController = ScrollController();

  Widget _buildUI() {
    return Stack(
      children: [
        RefreshIndicator(
          color: Theme.of(context).iconTheme.color,
          onRefresh: () {
            return Future.delayed(Duration.zero).then((value) {
              // HiveStore().reset();
              // homePageBloc?.add(const HomeScreenDataFetchEvent(true));
            });
          },
          child: Visibility(
              visible: (homePageData != null),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    primary: false,
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        if (appStoragePref.isLoggedIn())
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const FluxImage(
                                          imageUrl:
                                              "assets/icons/home_welcome.png"),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        "${Utils.getStringValue(context, Utils.getStringValue(context, AppStringConstant.hello))}${appStoragePref.getUserData()?.name}",
                                        style:
                                            KTextStyle.of(context).boldSixteen,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  SizedBox(
                                      width: AppSizes.deviceHeight * .3,
                                      child: Text(
                                        Utils.getStringValue(
                                            context,
                                            Utils.getStringValue(
                                                context,
                                                AppStringConstant
                                                    .homeHelloMessage)),
                                        style: KTextStyle.of(context)
                                            .twelve
                                            .copyWith(
                                                color: const Color(0xff959393)),
                                      ))
                                ],
                              ),
                              Container(
                                width: 65.80,
                                height: 65.80,
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: OvalBorder(),
                                ),
                                child: Center(
                                    child: ClipOval(
                                        child: FluxImage(
                                  imageUrl: appStoragePref
                                          .getUserData()
                                          ?.profileImage ??
                                      "assets/icons/profile-header.svg",
                                  fit: BoxFit.contain,
                                  color: AppColors.gold,
                                  height: 40,
                                  width: 40,
                                ))),
                              ),
                            ],
                          ),
                        Column(
                          children: homePageWidgets,
                        ),
                        space(),

                        (appStoragePref.getShowRecentProduct())
                            ? Column(children: [
                                const RecentView(),
                                space(),
                              ])
                            : Container(),
                        //Will show at the end of the page!
                        footer(context),
                      ],
                    ),
                  ),
                  Positioned(
                    top: AppSizes.deviceHeight * .58,
                    right: 10,
                    child: Column(
                      children: [
                        FloatingActionButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, AppRoutes.vaOnboarding);
                          },
                          backgroundColor: Colors.transparent,
                          child: const FluxImage(
                            imageUrl: 'assets/icons/ai2.png',
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            final speechService = context.read<VoiceCommandCubit>();

                            speechService.toggleListening();
                          },
                          backgroundColor: Colors.transparent,
                          child: const FluxImage(
                            imageUrl: 'assets/icons/ai1.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
        Visibility(visible: isLoading, child: const Loader()),
        // Column(
        //   children: [
        //     FloatingActionButton(
        //       onPressed: () {
        //
        //       },
        //       child: const FluxImage(
        //         imageUrl: 'assets/icons/ai1.svg',
        //       ),
        //     ),
        //     FloatingActionButton(
        //       onPressed: () {},
        //       child: const FluxImage(
        //         imageUrl: 'assets/icons/ai2.svg',
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }

  void setUpDynamicLayouts() async {
    appStoragePref
        .setIsTabCategoryView(((homePageData?.tabCategoryView ?? "1") == "1"));
    setOnBoardingVersion();

    sortedOrder = getSortedCarouselsData(homePageData?.sortOrder) ?? [];
    if (kDebugMode) {
      print("TEST_LOG==> SortOrder ==> $sortedOrder");
    }
    if ((sortedOrder ?? []).isNotEmpty) {
      if (appStoragePref.isFirstTime() == true) {
        print("objectsadasd§");

        if (homePageData?.bannerImages?.isNotEmpty ?? false) {
          var bannerImage = Carousel();
          bannerImage.id = "bannerimage";
          bannerImage.type = "banner";
          bannerImage.banners = homePageData?.bannerImages;
          homePageData?.carousel?.add(bannerImage);
        }

        if (homePageData?.featuredCategories?.isNotEmpty ?? false) {
          var category = Carousel();
          category.id = "featuredcategories";
          category.type = "category";
          category.featuredCategories = homePageData?.featuredCategories;
          homePageData?.carousel?.add(category);
        }
        appStoragePref.setFirstTime(false);
      }

      sortedOrder.forEach((element) {
        for (var item in homePageData!.carousel!) {
          if (element.layoutId == item.id) {
            switch (item.type) {
              case "product":
                {
                  addProductCarousel(item);
                  break;
                }
              case "image":
                {
                  homePageWidgets.add(Column(
                    children: [
                      space(),
                      HomeBanners(
                        (item.banners ?? []),
                        false,
                        imageSize: item.image_size ?? '',
                      ),
                    ],
                  ));
                  break;
                }
              case "category":
                {
                  homePageWidgets.add(Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      space(),
                      homePageData?.themeType != 1
                          ? CategoryWidgetType2(
                              carousel: item.featuredCategories)
                          : CategoryWidgetType1(
                              context, item.featuredCategories),
                    ],
                  ));
                  break;
                }
              case "banner":
                {
                  homePageWidgets.add(Column(
                    children: [
                      space(),
                      HomeSliders((item.banners ?? []), true),
                    ],
                  ));
                  break;
                }
            }
          }
        }
      });
    } else {
      var bannerImage = Carousel();
      bannerImage.id = "bannerimage";
      bannerImage.type = "banner";
      bannerImage.banners = homePageData?.bannerImages;

      var category = Carousel();
      category.id = "featuredcategories";
      category.type = "category";
      category.featuredCategories = homePageData?.featuredCategories;
    }
  }

  List<SortOrder>? getSortedCarouselsData(List<SortOrder>? sortedOrder) {
    List<SortOrder>? sortOrder = [];

    sortedOrder?.forEach((mainElement) {
      if (mainElement.getPositionArray().length == 1) {
        sortOrder.add(mainElement);
      } else {
        mainElement.getPositionArray().forEach((element) {
          SortOrder? sortOrderObject = SortOrder.empty();
          sortOrderObject.position = element;
          sortOrderObject.layoutId = mainElement.layoutId;
          sortOrderObject.type = mainElement.type;
          sortOrder.add(sortOrderObject);
        });
      }
    });

    sortOrder.sort((a, b) => int.parse(a.position!.replaceAll(",", "") ?? "")
        .compareTo(int.parse(b.position!.replaceAll(",", "") ?? "")));
    return sortOrder;
  }

  void addProductCarousel(Carousel carousel) async {
    homePageWidgets.add(Column(
      children: [
        space(),
        ProductCarasoulType2(
          (carousel.productList ?? []),
          context,
          carousel.id ?? '',
          carousel.category_id ?? '',
          (carousel.block_title ?? ''),
          description: carousel.block_description,
        ),
      ],
    ));
    // switch (selectRandomCarouselLayout(carousel.productList!.length)) {
    //   case 1:
    //     {
    //       homePageWidgets.add(Column(
    //         children: [
    //           space(),
    //           ProductCarasoulType2(
    //             (carousel.productList ?? []),
    //             context,
    //             carousel.id ?? '',
    //             (carousel.label ?? ''),
    //           ),
    //         ],
    //       ));
    //       break;
    //     }
    //   case 2:
    //     {
    //       homePageWidgets.add(Column(
    //         children: [
    //           space(),
    //           productCarasoulWidgetType3(
    //               (carousel.productList ?? []),
    //               (carousel.id ?? ""),
    //               (carousel.label ?? ''),
    //               context,
    //               homePageBloc ?? HomeScreenBloc()),
    //         ],
    //       ));
    //       break;
    //     }
    //   case 3:
    //     {
    //       homePageWidgets.add(Column(
    //         children: [
    //           space(),
    //           ProductCarasoulType1(
    //               (carousel.productList ?? []),
    //               context,
    //               (carousel.id ?? ''),
    //               (carousel.label ?? ''),
    //               homePageBloc ?? HomeScreenBloc()),
    //         ],
    //       ));
    //       break;
    //     }
    //   case 4:
    //     {
    //       // homePageWidgets?.add(Column(
    //       //   children: [
    //       //     ProductCarasoulype4(
    //       //         (carousel?.productList ?? []),
    //       //         context,
    //       //         (carousel?.id ?? ''),
    //       //         (carousel?.label ?? ''),
    //       //         homePageBloc ?? HomeScreenBloc()),
    //       //   ],
    //       // ));
    //
    //       homePageWidgets.add(Column(
    //         children: [
    //           space(),
    //           ProductCarasoulType1(
    //               (carousel.productList ?? []),
    //               context,
    //               (carousel.id ?? ''),
    //               (carousel.label ?? ''),
    //               homePageBloc ?? HomeScreenBloc()),
    //         ],
    //       ));
    //       break;
    //     }
    // }
  }

  int selectRandomCarouselLayout(int size) {
    if (size > 1) {
      return Random().nextInt(size - 1) + 1;
    } else {
      return 1;
    }
  }

  Widget footer(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 120.0),
        child: GestureDetector(
          child: Text(
              Utils.getStringValue(context, AppStringConstant.backToTop),
              style: KTextStyle.of(context)
                  .sixteen
                  .copyWith(color: AppColors.gold)),
          onTap: () => {
            _scrollController.animateTo(
                _scrollController.position.minScrollExtent,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease)
          },
        ),
      ),
    );
  }

  Widget space() {
    return const SizedBox(
      height: AppSizes.size16,
    );
  }

  void setOnBoardingVersion() {
    if (homePageData?.walkthroughVersion?.isNotEmpty ?? false) {
      if (double.parse(
              appStoragePref.getWalkThroughVersion().toString() ?? "") <
          double.parse(homePageData?.walkthroughVersion.toString() ?? "0.0")) {
        appStoragePref.setShowWalkThrough(true);
        appStoragePref.setWalkThroughVersion(
            homePageData?.walkthroughVersion.toString() ?? "");
      }
    }
  }
}
