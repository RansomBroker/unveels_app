/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/app_widgets/lottie_animation.dart';
import 'package:test_new/unvells/helper/app_storage_pref.dart';
import 'package:test_new/unvells/models/address/get_address.dart';
import 'package:test_new/unvells/models/order_list/order_list_model.dart';
import 'package:test_new/unvells/screens/dashboard/views/collapse_appbar.dart';
import 'package:test_new/unvells/screens/dashboard/views/contact_info.dart';

import '../../app_widgets/Tabbar/common_banner_view.dart';
import '../../app_widgets/app_alert_message.dart';
import '../../app_widgets/app_bar.dart';
import '../../app_widgets/app_outlined_button.dart';
import '../../app_widgets/app_tool_bar.dart';
import '../../app_widgets/loader.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_routes.dart';
import '../../constants/app_string_constant.dart';
import '../../helper/app_localizations.dart';
import '../../models/account_info/account_info_model.dart';
import '../../models/dashboard/UserDataModel.dart';
import '../checkout/shipping_info/widget/address_item_card.dart';
import '../orders_list/bloc/order_screen_bloc.dart';
import '../orders_list/bloc/order_screen_repository.dart';
import '../orders_list/orders_screen.dart';
import '../reviews/block/reviews_screen_bloc.dart';
import '../reviews/block/reviews_screen_repository.dart';
import '../reviews/reviews_screen.dart';
import 'bloc/dashboard_bloc.dart';
import 'bloc/dashboard_events.dart';
import 'bloc/dashboard_state.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;
  bool defaultShipping = false;
  bool showAddressPage = false;
  TabController? _tabController;
  AppLocalizations? _localizations;
  DashboardBloc? _dashboardBloc;
  String? name, email;
  OrderListModel? orderList;
  GetAddress? addressList;
  String? billingAddressUrl;
  AccountInfoModel? imageModel;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  Widget orderScreen = BlocProvider(
      create: (context) =>
          OrderScreenBloc(repository: OrderScreenRepositoryImp()),
      child: OrderScreen(true));

  Widget reviewsScreen = BlocProvider(
      create: (context) =>
          ReviewsScreenBloc(repository: ReviewsScreenRepositoryImp()),
      child: ReviewsScreen(true));

  @override
  void initState() {
    _dashboardBloc = context.read<DashboardBloc>();
    _dashboardBloc?.add(DashboardAddressFetchEvent());
    UserDataModel? userData = appStoragePref.getUserData();
    name = userData?.name ?? "";
    email = userData?.email;
    _tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: commonAppBar(
            _localizations?.translate(AppStringConstant.dashboard) ?? "",
            context,
            // actions: [
            //   IconButton(onPressed: (){
            //     Navigator.pushNamed(context, AppRoutes.settingsScreen,);
            //   }, icon: Icon(Icons.settings))
            // ],
            isElevated: false),
        body: BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, currentState) {
          if (currentState is DashboardLoadingState) {
            isLoading = true;
          } else if (currentState is DashboardSuccessState) {
            isLoading = false;
            orderList = currentState.order;
            addressList = currentState.address;
            if ((addressList?.shippingAddress?.value ?? "").trim().isNotEmpty) {
              defaultShipping = true;
            }
          } else if (currentState is DashboardErrorState) {
            isLoading = false;
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(currentState.message, context);
            });
          } else if (currentState is DashboardOrderSuccessState) {
            isLoading = false;
            orderList = currentState.order;
          } else if (currentState is DashboardAddressSuccessState) {
            isLoading = false;
            addressList = currentState.address;
            if ((addressList?.shippingAddress?.value ?? "").trim().isNotEmpty) {
              defaultShipping = true;
            }
          } else if (currentState is ChangeShippingAddressState) {
            showAddressPage = true;
          } else if (currentState is SaveShippingAddressState) {
            if (currentState.data.success ?? false) {
              showAddressPage = false;
              isLoading = false;
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showSuccess(
                    currentState.data.message ?? '', context);
              });
            }
          } else if (currentState is AddImageState) {
            isLoading = false;
            imageModel = currentState.model;
            if (currentState.model?.success ?? false) {

              var data = appStoragePref.getUserData();
              if (currentState.type == AppConstant.profileImage) {
                data?.profileImage = imageModel?.url;
              } else {
                data?.bannerImage = imageModel?.url;
              }
              // data?.profileImage = imageModel?.profileImage;
              // data?.bannerImage = imageModel?.bannerImage;
              appStoragePref.setUserData(data);
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showSuccess(
                    currentState.model?.message ?? '', context);
              });
            } else {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showError(
                    currentState.model?.message ?? '', context);
              });
            }
          } else if (currentState is DeleteImageState) {
            isLoading = false;
            if (currentState.model?.success ?? false) {
              var data = appStoragePref.getUserData();
              data?.profileImage = '';
              appStoragePref.setUserData(data);
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showSuccess(
                    currentState.model?.message ?? '', context);
              });
            } else {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showError(
                    currentState.model?.message ?? '', context);
              });
            }
          } else if (currentState is DeleteBannerImageState) {
            isLoading = false;
            if (currentState.model?.success ?? false) {
              var data = appStoragePref.getUserData();
              data?.bannerImage = '';
              appStoragePref.setUserData(data);
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showSuccess(
                    currentState.model?.message ?? '', context);
              });
            } else {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showError(
                    currentState.model?.message ?? '', context);
              });
            }
          }
          return _buildUI();
        }),
      ),
    );
  }

  Widget _buildUI() {
    return collapseAppBar(
      context,
      CommonBannerView((image, type) {
        print("TEST_LOG ==profile=> ${type}");
        _dashboardBloc?.add(AddImageEvent(image, type));
      }, true, isLoading),
      Stack(children: [
        TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              ///orderScreen
              Column(
                children: [
                  Expanded(child: orderScreen),
                  Container(
                    color: Theme.of(context).cardColor,
                    padding: const EdgeInsets.all(AppSizes.paddingGeneric),
                    child: appOutlinedButton(context, () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.orderList, arguments: false);
                    },
                        _localizations?.translate(AppStringConstant.viewAll) ??
                            '',
                        backgroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        textColor: AppColors.white),
                  ),
                ],
              ),

              /// addressScreen,
              Column(
                children: [
                  Expanded(
                    child: getTabScreens((addressList != null && (!isLoading))
                        ? addressInfo(_localizations
                                ?.translate(AppStringConstant.addressBook) ??
                            '')
                        : Container()),
                  ),
                  if (defaultShipping)
                    Container(
                      color: Theme.of(context).cardColor,
                      margin: EdgeInsets.zero,
                      padding: const EdgeInsets.all(AppSizes.paddingGeneric),
                      child: appOutlinedButton(context, () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.addressBook, arguments: false);
                      },
                          _localizations?.translate(
                                  AppStringConstant.manageAddress) ??
                              '',
                          backgroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          textColor: AppColors.white),
                    )
                ],
              ),

              ///reviewScreen
              Column(
                children: [
                  Expanded(child: reviewsScreen),
                  Container(
                    color: Theme.of(context).cardColor,
                    padding: const EdgeInsets.all(AppSizes.paddingGeneric),
                    child: appOutlinedButton(context, () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.productReview, arguments: false);
                    },
                        _localizations?.translate(AppStringConstant.viewAll) ??
                            '',
                        backgroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        textColor: AppColors.white),
                  ),
                ],
              ),
            ]),
        Visibility(visible: isLoading, child: Loader())
      ]),
      AppSizes.deviceHeight * .4,
      tabBar: TabBar(
        isScrollable: true,
        indicatorColor: AppColors.black,
        controller: _tabController,
        labelPadding: const EdgeInsets.all(0.0),
        tabs: [
          _getTab(
              _localizations?.translate(AppStringConstant.recentOrder) ?? ''),
          _getTab(_localizations?.translate(AppStringConstant.address) ?? ''),
          _getTab(_localizations?.translate(AppStringConstant.review) ?? '')
        ],
      ),
    );
  }

  Widget getTabScreens(Widget child) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: child,
    );
  }

  Widget addressInfo(String title) {
    return (defaultShipping)
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addressItemWithHeading(
                  context,
                  _localizations?.translate(
                          AppStringConstant.defaultBillingAddress) ??
                      "",
                  addressList?.billingAddress?.value ?? "", callback: () {
                Navigator.of(context).pushNamed(AppRoutes.addEditAddress,
                    arguments: {
                      "addressId": addressList?.billingAddress?.id
                    }).then((value) {});
              }),
              addressItemWithHeading(
                  context,
                  _localizations?.translate(
                          AppStringConstant.defaultShippingAddress) ??
                      "",
                  addressList?.shippingAddress?.value ?? "", callback: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes.addEditAddress,
                        arguments: addressList?.shippingAddress?.value)
                    .then((value) {
                  if (value == true) {
                    _dashboardBloc?.add(DashboardAddressFetchEvent());
                  }
                });
              }),
            ],
          )
        : LottieAnimation(
            lottiePath: AppImages.emptyAddressLottie,
            title: _localizations?.translate(AppStringConstant.noAddress) ?? "",
            subtitle:
                _localizations?.translate(AppStringConstant.noAddressMessage) ??
                    "",
            buttonTitle:
                _localizations?.translate(AppStringConstant.addNewAddress) ??
                    "",
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(AppRoutes.addressBook, arguments: false);
            });
  }

  Tab _getTab(title) {
    return Tab(
      child: Container(
        width: AppSizes.deviceWidth / 3,
        height: AppSizes.deviceHeight / 20,
        padding:
            const EdgeInsets.symmetric(horizontal: AppSizes.paddingGeneric),
        color: Theme.of(context).cardColor,
        child: Center(
            child: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
        )),
      ),
    );
  }
}
