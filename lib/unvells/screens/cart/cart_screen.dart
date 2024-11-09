/*
 *


 *
 * /
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/app_widgets/app_alert_message.dart';
import 'package:test_new/unvells/app_widgets/app_bar.dart';
import 'package:test_new/unvells/app_widgets/app_order_button.dart';
import 'package:test_new/unvells/app_widgets/loader.dart';
import 'package:test_new/unvells/app_widgets/lottie_animation.dart';
import 'package:test_new/unvells/configuration/unvells_theme.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/constants/app_routes.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/app_localizations.dart';
import 'package:test_new/unvells/helper/app_storage_pref.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/models/base_model.dart';
import 'package:test_new/unvells/models/cart/cart_details_model.dart';
import 'package:test_new/unvells/screens/cart/widgets/cart_main_view.dart';

import '../../app_widgets/app_dialog_helper.dart';
import '../../constants/arguments_map.dart';
import '../product_detail/widgets/guest_checkout_bottomsheet.dart';
import 'bloc/cart_screen_bloc.dart';
import 'bloc/cart_screen_event.dart';
import 'bloc/cart_screen_state.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  AppLocalizations? _localizations;
  bool isLoading = false;
  CartDetailsModel? cartViewModel;
  CartScreenBloc? cartScreenBloc;
  BaseModel? baseModel;

  @override
  void initState() {
    cartScreenBloc = context.read<CartScreenBloc>();
    cartScreenBloc?.add(const CartScreenDataFetchEvent());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
          _localizations?.translate(AppStringConstant.cart) ?? "", context,
          ),
      body: SafeArea(
        child: BlocBuilder<CartScreenBloc, CartScreenState>(
          builder: (context, state) {
            if (state is CartScreenInitial) {
              isLoading = true;
            } else if (state is CartScreenSuccess) {
              isLoading = false;
              cartViewModel = state.model;
            } else if (state is RemoveCartItemSuccess) {
              baseModel = state.data;
              appStoragePref.setCartCount(baseModel?.cartCount);
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showSuccess(
                    state.data.message != ''
                        ? state.data.message ?? ''
                        : Utils.getStringValue(
                            context, AppStringConstant.deleteItemFromCart),
                    context);
                // currentState.baseModel?.message != '' ? currentState.baseModel?.message??'' : Utils.getStringValue(context, AppStringConstant.logOutMessage), context);
              });
              cartScreenBloc?.add(const CartScreenDataFetchEvent());
            } else if (state is CartToWishlistState) {
              isLoading = false;
              baseModel = state.data;
              appStoragePref.setCartCount(baseModel?.cartCount);
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showSuccess(state.data.message ?? '', context);
              });
              cartScreenBloc?.add(const CartScreenDataFetchEvent());
            } else if (state is SetCartEmptyState) {
              isLoading = false;
              baseModel = state.data;
              appStoragePref.setCartCount(baseModel?.cartCount);
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showSuccess(
                    state.data.message != ''
                        ? state.data.message ?? ''
                        : Utils.getStringValue(
                            context, AppStringConstant.emptyCartText),
                    context);
              });
              cartScreenBloc?.add(const CartScreenDataFetchEvent());
            } else if (state is SetCartItemQtyState) {
              isLoading = false;
              baseModel = state.data;
              cartScreenBloc?.add(const CartScreenDataFetchEvent());
              cartScreenBloc?.emit(CartScreenInitial());
              appStoragePref.setCartCount(baseModel?.cartCount);
            } else if (state is RemoveCartItemSuccess) {
              baseModel = state.data;
              appStoragePref.setCartCount(baseModel?.cartCount);
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showSuccess(
                    state.data.message != ''
                        ? state.data.message ?? ''
                        : Utils.getStringValue(
                            context, AppStringConstant.deleteItemFromCart),
                    context);
                // currentState.baseModel?.message != '' ? currentState.baseModel?.message??'' : Utils.getStringValue(context, AppStringConstant.logOutMessage), context);
              });
              cartScreenBloc?.add(const CartScreenDataFetchEvent());
            } else if (state is ApplyCouponState) {
              baseModel = state.data;
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showSuccess(
                    state.data.message != ''
                        ? state.data.message ?? ''
                        : Utils.getStringValue(
                            context, AppStringConstant.deleteItemFromCart),
                    context);
                // currentState.baseModel?.message != '' ? currentState.baseModel?.message??'' : Utils.getStringValue(context, AppStringConstant.logOutMessage), context);
              });
              cartScreenBloc?.add(const CartScreenDataFetchEvent());
            } else if (state is CartScreenError) {
              isLoading = false;
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showError(state.message ?? '', context);
              });
            }
            return _buildUI();
          },
        ),
      ),
    );
  }

  Widget _buildUI() {
    return Stack(
      children: <Widget>[
        Visibility(
          visible: (cartViewModel != null),
          child: cartViewModel?.items?.length == 0 ||
                  (cartViewModel?.items ?? []).isEmpty
              ? LottieAnimation(
                  lottiePath: AppImages.emptyCartLottie,
                  title:
                      _localizations?.translate(AppStringConstant.emptyCart) ??
                          "",
                  subtitle: _localizations
                          ?.translate(AppStringConstant.noItemsInCart) ??
                      "",
                  buttonTitle: _localizations
                          ?.translate(AppStringConstant.continueShopping) ??
                      "",
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutes.bottomTabBar, (route) => false);
                  })
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        physics: const BouncingScrollPhysics(),
                        child: CartMainView(
                            cartViewModel, _localizations, cartScreenBloc),
                      ),
                    ),
                    commonOrderButton(context, _localizations,
                        cartViewModel?.cartTotal ?? "0.00", () {
                      if (cartViewModel?.isCheckoutAllowed ?? false) {
                        if (appStoragePref.isLoggedIn()) {
                          if (cartViewModel?.isVirtual ?? false) {
                            Navigator.pushNamed(context, AppRoutes.paymentInfo,
                                arguments: getCheckoutMap("", null));
                          } else {
                            Navigator.of(context).pushNamed(
                                AppRoutes.shippingIfo,
                                arguments: cartViewModel?.cartTotal ?? "0.00");
                          }
                        } else {
                          if (cartViewModel?.isAllowedGuestCheckout ?? false) {
                            if (cartViewModel?.isVirtual ?? false) {
                              Navigator.pushNamed(
                                  context, AppRoutes.paymentInfo,
                                  arguments: getCheckoutMap("", null,
                                      isVirtual: true));
                            } else {
                              guestCheckoutBottomSheet(
                                  context,
                                  cartViewModel?.cartTotal ?? "0.00",
                                  cartViewModel?.isVirtual ?? false);
                             /* Navigator.of(context).pushNamed(
                                  AppRoutes.shippingIfo,
                                  arguments:
                                      cartViewModel?.cartTotal ?? "0.00");*/
                            }
                          } else {
                            WidgetsBinding.instance?.addPostFrameCallback((_) {
                              AlertMessage.showWarning(
                                  Utils.getStringValue(
                                      context, AppStringConstant.loginRequired),
                                  context);
                            });
                          }
                        }
                      } else {
                        WidgetsBinding.instance?.addPostFrameCallback((_) {
                          AlertMessage.showWarning(
                              Utils.getStringValue(
                                  context,
                                  cartViewModel?.descriptionMessage ??
                                      Utils.getStringValue(
                                          context,
                                          AppStringConstant
                                              .somethingWentWrong)),
                              context);
                        });
                      }
                    })
                  ],
                ),
        ),
        Visibility(
          visible: isLoading,
          child: const Loader(),
        ),
      ],
    );
  }
}
