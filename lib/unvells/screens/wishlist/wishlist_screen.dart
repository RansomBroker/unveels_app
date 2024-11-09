/*
 *


 *
 * /
 */

import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:test_new/unvells/constants/app_routes.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/app_localizations.dart';
import 'package:test_new/unvells/helper/app_storage_pref.dart';
import 'package:test_new/unvells/models/wishlist/request/wishlist_product_request.dart';
import 'package:test_new/unvells/models/wishlist/wishlist_model.dart';
import 'package:test_new/unvells/screens/home/widgets/item_card_bloc/item_card_bloc.dart';
import 'package:test_new/unvells/screens/wishlist/bloc/wishlist_screen_bloc.dart';
import 'package:test_new/unvells/screens/wishlist/bloc/wishlist_screen_event.dart';
import 'package:test_new/unvells/screens/wishlist/bloc/wishlist_screen_state.dart';
import 'package:test_new/unvells/screens/wishlist/widget/bottom_wishlist_button.dart';
import 'package:test_new/unvells/screens/wishlist/widget/wishlist_item_view.dart';

import '../../app_widgets/app_alert_message.dart';
import '../../app_widgets/app_bar.dart';
import '../../app_widgets/badge_icon.dart';
import '../../app_widgets/loader.dart';
import '../../app_widgets/lottie_animation.dart';
import '../../constants/app_constants.dart';
import '../../helper/utils.dart';
import '../../network_manager/api_client.dart';
import '../home/bloc/home_screen_bloc.dart';
import '../home/bloc/home_screen_events.dart';
import '../home/widgets/item_card_bloc/item_card_state.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  late bool _loading = false;
  WishlistScreenBloc? _bloc;
  final ScrollController _scrollController = ScrollController();
  int _page = 1;
  WishlistModel? _model;
  List<WishlistData> _products = [];
  late WishlistProductRequest _request;
  String? productId;
  bool _isAction = false;
  int? cartCount = 0;
  Map<String, String>? selectedWishlistProductList = HashMap<String, String>();

  @override
  void initState() {
    // _loading = true;
    // _scrollController = ScrollController().addListener(paginationFunction);
    _bloc = context.read<WishlistScreenBloc>();
    _bloc?.add(WishlistDataFetchEvent(_page));
    _scrollController.addListener(() {
      paginationFunction();
    });
    // _callAPI();

    super.initState();
  }

  void paginationFunction() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent &&
        (_model?.totalCount ?? 0) > _products.length) {
      // setState(() {
      _page++;
      _bloc?.add(WishlistDataFetchEvent(_page));
      // });
    }
  }

  List<Map<String, String>> getupAddAllCartWishlistRequest() {
    List<Map<String, String>> itemData = [];
    Map<String, String> productData = {};
    if (_products.isNotEmpty) {
      for (int i = 0; i < _products.length; i++) {
        productData = HashMap<String, String>();
        setState(() {
          productData["id"] = "${_products[i].id}";
          productData["qty"] = "${_products[i].qty}";
        });
        itemData.add(productData);
      }
    }
    return itemData!;
  }

  bool hasMoreData() {
    var total = 0;
    if (_model != null) {
      total = _model?.totalCount ?? 0;
    } else {
      total = _model?.totalCount ?? 0;
    }
    return (total > _products.length && !_loading);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).canvasColor,
      /*appBar: appToolBar(
            Utils.getStringValue(context, AppStringConstant.wishList), context),*/
      appBar: commonAppBar(
        isLeadingEnable: true,
          Utils.getStringValue(context, AppStringConstant.wishList)
              .localized() /*_localizations?.translate(AppStringConstant.wishList) ?? ""*/,
          context,
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         if (_products.isEmpty) {
          //           AlertMessage.showError(
          //               Utils.getStringValue(
          //                   context, AppStringConstant.emptyWishListMsg),
          //               context);
          //         } else {
          //           Navigator.pushNamed(context, AppRoutes.wishListSharing);
          //         }
          //       },
          //       icon: const Icon(
          //         Icons.share,
          //       )),
          //   IconButton(
          //       onPressed: () {
          //         Navigator.pushNamed(context, AppRoutes.cart);
          //       },
          //       icon: BadgeIcon(
          //         icon: const Icon(Icons.shopping_cart),
          //         badgeColor: Colors.red,
          //       )),
          // ],
      ),
      body: BlocBuilder<WishlistScreenBloc, WishlistScreenState>(
        builder: (ctx, currentState) {
          if (currentState is WishlistInitialState) {
            _loading = true;
          } else if (currentState is WishlistScreenSuccess) {
            print("TEST_LOG=page=WishlistScreenSuccess> ${_products.length}");
            _loading = false;
            _isAction = false;
            appStoragePref.setCartCount(appStoragePref.getCartCount());
            _model = currentState.wishlistModel;
            if (_page == 1) {
              _products = _model?.wishList ?? [];
              print("TEST_LOG=page=Lenght> ${_products.length}");
            } else {
              _products.addAll(currentState.wishlistModel.wishList ?? []);
              print("TEST_LOG==Lenght> ${_products.length}");
            }
          } else if (currentState is WishlistActionState) {

            _isAction = true;
          } else if (currentState is MoveToCartSuccess) {
            _loading = false;
            _page = 1;
            cartCount = int.parse(currentState
                .wishlistMovecartResponseModel?.cartCount
                .toString() ??
                "0");
            AppStoragePref().setCartCount(
                currentState.wishlistMovecartResponseModel?.cartCount ?? "0");
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              // setState(() {});
              AlertMessage.showSuccess(
                  currentState.wishlistMovecartResponseModel?.message ?? '',
                  context);
            });
            _bloc?.add(WishlistDataFetchEvent(_page));
          } else if (currentState is RemoveItemSuccess) {
            _bloc?.add(WishlistDataFetchEvent(_page));

            _loading = false;
            _page = 1;
            // Future.delayed(Duration.zero).then((value) {
            //   HiveStore().reset();
            //   context.read<HomeScreenBloc>().add(const HomeScreenDataFetchEvent(false));
            // }
            // );
            // context.read<ItemCardBloc>().emit(WishlistIdleState());
            // if (widget.product?.wishlistItemId.toString() ==
            //     currentState.productId) {
            //   widget.product?.isInWishlist = false;
            // }

            // ApiClient().getHomePageData(true);
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showSuccess(
                  currentState.baseModel?.message ?? '', context);
              // setState(() {
              //
              // });
            });


          } else if (currentState is MoveAllToCartSuccess) {
            _loading = false;
            _page = 1;
            cartCount = int.parse(currentState
                .wishlistAddallcartResponseModel?.cartCount
                .toString() ??
                "0");
            AppStoragePref().setCartCount(
                currentState.wishlistAddallcartResponseModel?.cartCount ?? "0");
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showSuccess(
                  currentState.wishlistAddallcartResponseModel?.message ?? 'Item Moved InTo The Cart',
                  context);
              _bloc?.add(WishlistDataFetchEvent(_page));
              setState(() {});
            });
            _bloc?.emit(CompleteState());
          } else if (currentState is WishlistScreenError) {
            _loading = false;
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(currentState.message ?? '', context);
            });
          }
          return _buildUI(_products, context);
        },
      ),
    );
  }

  Widget _buildUI(List<WishlistData>? items, BuildContext context) {
    return Container(
      color: const Color(0xffF5F5F5),
      height: double.infinity,
      child: Stack(
        children: [
          if (_products.isNotEmpty )
            SingleChildScrollView(
                padding: const EdgeInsets.all( 16),
                physics: const BouncingScrollPhysics(),
                child: WishlistItemViewProducts(
                    items!, _bloc, context, _loading)),
          Visibility(
            visible: (_products.isEmpty && (!_loading)),
            child: Center(
              child: LottieAnimation(
                  lottiePath: AppImages.emptyWishlistLottie,
                  title: Utils.getStringValue(
                      context, AppStringConstant.noProductAvailable),
                  subtitle: "",
                  buttonTitle: Utils.getStringValue(
                      context, AppStringConstant.continueShopping),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutes.bottomTabBar, (route) => false);
                  }),
            ),
          ),
          Visibility(visible: WishlistScreenBloc.of(context).isLoadingAction||_loading, child: const Loader())
        ],
      ),
    );
  }
}
