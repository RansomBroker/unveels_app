/*
 *


 *
 * /
 */

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:test_new/unvells/app_widgets/app_alert_message.dart';
import 'package:test_new/unvells/app_widgets/app_bar.dart';
import 'package:test_new/unvells/app_widgets/app_order_button.dart';
import 'package:test_new/unvells/app_widgets/app_switch_button.dart';
import 'package:test_new/unvells/app_widgets/loader.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/constants/app_routes.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/app_localizations.dart';
import 'package:test_new/unvells/helper/request_overlay.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/models/cart/price_details.dart';
import 'package:test_new/unvells/models/checkout/payment_info/payment_info_model.dart';
import 'package:test_new/unvells/models/checkout/payment_info/payment_info_model.dart';
import 'package:test_new/unvells/models/checkout/place_order/place_order_model.dart';
import 'package:test_new/unvells/screens/cart/widgets/discount_view.dart';
import 'package:test_new/unvells/screens/cart/widgets/price_detail_view.dart';
import 'package:test_new/unvells/screens/checkout/payment_info/bloc/Payment_info_bloc.dart';
import 'package:test_new/unvells/screens/checkout/payment_info/bloc/Payment_info_bloc.dart';
import 'package:test_new/unvells/screens/checkout/payment_info/bloc/payment_info_events.dart';
import 'package:test_new/unvells/screens/checkout/payment_info/bloc/payment_info_state.dart';
import 'package:test_new/unvells/screens/checkout/payment_info/widgets/apply_reward.dart';
import 'package:test_new/unvells/screens/checkout/payment_info/widgets/order_summary.dart';
import 'package:test_new/unvells/screens/checkout/payment_info/widgets/payment_methods.dart';
import 'package:test_new/unvells/screens/checkout/payment_info/widgets/place_order_screen.dart';
import 'package:test_new/unvells/screens/checkout/payment_info/widgets/reward_container.dart';
import 'package:test_new/unvells/screens/checkout/payment_info/widgets/wallet_view.dart';
import 'package:test_new/unvells/screens/checkout/shipping_info/widget/address_item_card.dart';
import 'package:test_new/unvells/screens/checkout/shipping_info/widget/checkout_progress_line.dart';
import 'package:test_new/unvells/screens/login_signup/bloc/signin_signup_screen_bloc.dart';
import 'package:test_new/unvells/screens/login_signup/signin_signup_screen.dart';

import '../../../configuration/unvells_theme.dart';
import '../../../configuration/text_theme.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/app_storage_pref.dart';
import '../../../helper/bottom_sheet_helper.dart';
import '../../../models/checkout/place_order/billing_data_request.dart';
import '../../../models/checkout/shipping_info/shipping_address_model.dart';
import '../../../models/wallet_extension_models/wallet_dashboard_model.dart';

class PaymentInfoScreen extends StatefulWidget {
  final Map<String, dynamic> args;

  PaymentInfoScreen(this.args, {Key? key}) : super(key: key);

  @override
  State<PaymentInfoScreen> createState() => _PaymentInfoScreenState();
}

class _PaymentInfoScreenState extends State<PaymentInfoScreen> {
  AppLocalizations? _localizations;
  bool isAddressSame = true;
  bool isLoading = true;
  PaymentInfoModel? paymentInfoModel;
  PaymentInfoScreenBloc? paymentInfoScreenBloc;
  AuthBloc? signinSignupScreenBloc;
  PlaceOrderModel? placeOrderModel;
  String selectedPaymentMethodCode = '';
  BillingDataRequest? billingDataRequest;
  ShippingAddressModel? _addressListModel;
  WalletData? walletData;
  bool isSufficientBalance = true;
  bool walletSelected = false;

  @override
  void initState() {
    signinSignupScreenBloc = context.read<AuthBloc>();
    signinSignupScreenBloc?.add(const GetCustomerCartEvent());
    paymentInfoScreenBloc = context.read<PaymentInfoScreenBloc>();
    paymentInfoScreenBloc
        ?.add(GetPaymentInfoEvent(widget.args[shippingMethodKey]));
    _addressListModel = widget.args[addressKey];
    if (widget.args[isVirtualKey] ?? false) {
      isAddressSame = false;
    }
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
            _localizations?.translate(AppStringConstant.reviewPayments) ?? "",
            context),
        body: BlocBuilder<PaymentInfoScreenBloc, PaymentInfoScreenState>(
            builder: (context, currentState) {
          if (currentState is PaymentInfoScreenInitial) {
            isLoading = true;
          } else if (currentState is GetPaymentMethodSuccess) {
            isLoading = false;
            paymentInfoModel = currentState.paymentModel;
            if (paymentInfoModel?.spendAmount != null &&  paymentInfoModel?.spendAmount != '0.0000') {
              // paymentInfoModel?.orderReviewData?.totals?.clear();
              paymentInfoModel?.orderReviewData?.totals?.insert(
                  3,
                  PriceDetails(
                      title: "Rewards Discount", value: "${appStoragePref.getCurrencyCode()} ${paymentInfoModel?.spendAmount}"));
            }
            if (_addressListModel == null) {
              paymentInfoScreenBloc?.add(const CheckoutAddressFetchEvent());
            }
          } else if (currentState is CheckoutAddressSuccess) {
            isLoading = false;
            if (currentState.model.success ?? false) {
              _addressListModel = currentState.model;
              if (_addressListModel?.address != null) {
                _addressListModel?.selectedAddressData =
                    _addressListModel?.address?[0];
              }
            }

            if (appStoragePref.getUserAddressData()?.firstname?.isNotEmpty ??
                false) {
              Address addressData = Address(
                  value: _addressListModel?.getFormattedAddress(
                      appStoragePref.getUserAddressData()!),
                  id: "",
                  isNew: true);
              List<Address>? address = [];
              address.add(addressData);
              if (_addressListModel?.address != null) {
                _addressListModel?.address?.add(addressData);
              } else {
                _addressListModel?.address = address;
              }
              _addressListModel?.selectedAddressData = addressData;

              _addressListModel?.hasNewAddress = true;
            }
          } else if (currentState is PlaceOrderSuccess) {
            isLoading = false;
            appStoragePref.setQuoteId(0);
            appStoragePref.setCartCount(0);
            placeOrderModel = currentState.placeOrderModel;
            context.read<AuthBloc>().add(const GetCustomerCartEvent());

            WidgetsBinding.instance?.addPostFrameCallback((_) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PlaceOrderScreen(placeOrderModel)));
            });
            paymentInfoScreenBloc?.emit(PaymentInfoScreenEmptyState());
          } else if (currentState is ApplyCouponState) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showSuccess(
                  currentState.data.message != ''
                      ? currentState.data.message ?? ''
                      : Utils.getStringValue(
                          context, AppStringConstant.deleteItemFromCart),
                  context);
            });
            paymentInfoScreenBloc
                ?.add(GetPaymentInfoEvent(widget.args[shippingMethodKey]));
          } else if (currentState is ApplyRewardPointState) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showSuccess(
                  currentState.data.message != ''
                      ? currentState.data.message ?? ''
                      : Utils.getStringValue(
                          context, AppStringConstant.deleteItemFromCart),
                  context);
            });
            context.read<AuthBloc>().add(const GetCustomerCartEvent());
            paymentInfoScreenBloc
                ?.add(GetPaymentInfoEvent(widget.args[shippingMethodKey]));
          } else if (currentState is ApplyGiftCouponState) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showSuccess(
                  currentState.data.message != ''
                      ? currentState.data.message ?? ''
                      : Utils.getStringValue(
                          context, AppStringConstant.deleteItemFromCart),
                  context);
            });
            paymentInfoScreenBloc
                ?.add(GetPaymentInfoEvent(widget.args[shippingMethodKey]));
          } else if (currentState is PaymentInfoScreenError) {
            isLoading = false;
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(
                  currentState.message ??
                      Utils.getStringValue(
                          context, AppStringConstant.somethingWentWrong),
                  context);
            });
            paymentInfoScreenBloc?.emit(PaymentInfoScreenEmptyState());
          } else if (currentState is ChangeBillingAddressState) {
            paymentInfoScreenBloc
                ?.add(GetPaymentInfoEvent(widget.args[shippingMethodKey]));
          } else if (currentState is ApplyWalletPaymentSuccessState) {
            isLoading = false;
            walletData = currentState.model?.walletData;
            if ((walletData?.unformattedLeftAmountToPay ?? 0) > 0) {
              isSufficientBalance = false;
            }
          }
          return _buildUI();
        }));
  }

  Widget _buildUI() {
    return Stack(
      children: [
        Visibility(
            visible: paymentInfoModel != null,
            child: paymentInfoModel?.success ?? false
                ? Column(
                    children: [
                      checkoutProgressLine(false, context),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(
                              vertical: 24, horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // showBillingAddress(
                              //     context, AppStringConstant.billingAddress),
                              const RewardContainer(),

                              const SizedBox(
                                height: 24,
                              ),
                              orderSummary(
                                  context,
                                  _localizations,
                                  paymentInfoModel?.orderReviewData?.items ??
                                      []),
                              const SizedBox(
                                height: 24,
                              ),
                              if (widget.args[shippingMethodKey] != "")
                                shippinginfo(AppStringConstant.shippingInfo),
                              const SizedBox(
                                height: 24,
                              ),
                              paymentMethod(),
                              const SizedBox(
                                height: 24,
                              ),
                              if(paymentInfoModel?.giftCode?.isEmpty==true&&paymentInfoModel?.spendAmount=="0.0000")
                              DiscountView(
                                expanded: paymentInfoModel?.couponCode?.isNotEmpty??false,
                                discountApplied:
                                    paymentInfoModel?.couponCode?.isNotEmpty ??
                                        false,
                                discountCode:
                                    paymentInfoModel?.couponCode ?? "",
                                onClickApply: (discountCode) {
                                  paymentInfoScreenBloc?.add(ApplyCouponEvent(
                                      discountCode.toString() ?? "", 0));
                                },
                                onClickRemove: (discountCode) {
                                  paymentInfoScreenBloc?.add(ApplyCouponEvent(
                                      paymentInfoModel?.couponCode.toString() ??
                                          "",
                                      1));
                                },
                                title: AppStringConstant.discountCode,
                                hint: AppStringConstant.enterCode,
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              if(paymentInfoModel?.couponCode?.isEmpty==true&&paymentInfoModel?.spendAmount=="0.0000")

                              DiscountView(
                                expanded: paymentInfoModel?.giftCode?.isNotEmpty ??
                                    false,
                                discountApplied:
                                    paymentInfoModel?.giftCode?.isNotEmpty ??
                                        false,
                                discountCode:
                                    paymentInfoModel?.giftCode ?? "",
                                onClickApply: (discountCode) {
                                  paymentInfoScreenBloc?.add(
                                      ApplyGiftCouponEvent(
                                          discountCode.toString() ?? "", 0));
                                },
                                onClickRemove: (discountCode) {
                                  paymentInfoScreenBloc?.add(
                                      ApplyGiftCouponEvent(
                                          paymentInfoModel?.giftCodeId
                                                  .toString() ??
                                              "",
                                          1));
                                },
                                title: AppStringConstant.giftCode,
                                hint: AppStringConstant.enter_gift_code,
                              ),
                              const SizedBox(
                                height: 24,
                              ),

                              if(paymentInfoModel?.couponCode?.isEmpty==true&&paymentInfoModel?.giftCode?.isEmpty==true)

                              const ApplyReward(),
                              const SizedBox(
                                height: 24,
                              ),
                              Text(
                                  _localizations?.translate(
                                          AppStringConstant.orderSummary) ??
                                      "",
                                  style: KTextStyle.of(context).boldSixteen),
                              // const Divider(
                              //   thickness: 1,
                              //   height: 1,
                              // ),
                              const SizedBox(
                                height: 16,
                              ),
                              BlocBuilder<AuthBloc, SigninSignupScreenState>(
                                builder: (context, state) {
                                  return PriceDetailView(
                                    fromCheckout: true,
                                    paymentInfoModel?.orderReviewData?.totals ??
                                        [],
                                    _localizations,
                                    // rewardDiscount: paymentInfoModel?.spendAmount,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      commonOrderButton(context, _localizations,
                          paymentInfoModel?.total ?? "", () async {
                        print(
                            "isSufficientBalance $isSufficientBalance and selectedPaymentMethodCode is $selectedPaymentMethodCode");

                        billingDataRequest = BillingDataRequest(
                            sameAsShipping: isAddressSame ? 1 : 0,
                            addressId:
                                _addressListModel?.selectedAddressData?.id);

                        if ((!isAddressSame &&
                            (appStoragePref.getUserAddressData()?.firstname ??
                                    "")
                                .isEmpty)) {
                          AlertMessage.showError(
                              _localizations?.translate(AppStringConstant
                                      .paymentAddressSelectError) ??
                                  "",
                              context);
                        } else if (selectedPaymentMethodCode.isEmpty) {
                          AlertMessage.showError(
                              _localizations?.translate(
                                      AppStringConstant.selectPaymentMethod) ??
                                  "",
                              context);
                        } else {
                          if ((isSufficientBalance && walletSelected) ||
                              (!isSufficientBalance &&
                                  walletSelected &&
                                  selectedPaymentMethodCode !=
                                      AppConstant.m2Wallet) ||
                              !walletSelected) {
                            paymentInfoScreenBloc?.add(PlaceOrderEvent(
                                selectedPaymentMethodCode,
                                widget.args[shippingMethodKey],
                                billingDataRequest ?? BillingDataRequest(),
                                walletSelected ? "set" : "0"));
                            paymentInfoScreenBloc
                                ?.emit(PaymentInfoScreenInitial());
                            var mHiveBox =
                                await HiveStore.openBox("graphqlClientStore");
                            mHiveBox.clear();
                          } else {
                            AlertMessage.showError(
                                _localizations?.translate(AppStringConstant
                                        .insufficientBalance) ??
                                    "",
                                context);
                          }
                        }
                      }, title: AppStringConstant.placeOrder)
                    ],
                  )
                : Container()),
        Visibility(
          visible: isLoading,
          child: const Loader(),
        ),
      ],
    );
  }

  Widget showBillingAddress(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSizes.size8),
      child: Container(
        color: Theme.of(context).cardColor,
        margin: const EdgeInsets.only(top: AppSizes.size8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: AppSizes.size8, horizontal: AppSizes.size8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_localizations?.translate(title) ?? '',
                      style: Theme.of(context).textTheme.displaySmall),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              height: 1,
            ),
            if (widget.args[shippingMethodKey] != "")
              AppSwitchButton(
                _localizations
                        ?.translate(AppStringConstant.sameAsShippingAddress) ??
                    '',
                billingAddress,
                isAddressSame,
                isFromPaymentInfo: true,
              ),
            Visibility(
              visible: !isAddressSame || (widget.args[shippingMethodKey] == ""),
              child: addressItemCard(
                  _addressListModel?.selectedAddressData?.value ?? "", context,
                  isElevated: false,
                  actions: actionContainer(context, () {
                    shippingAddressModelBottomSheet(context, (value) {
                      paymentInfoScreenBloc?.add(const ChangeAddressEvent());
                    }, _addressListModel);
                  }, () {
                    Navigator.of(context).pushNamed(AppRoutes.addEditAddress,
                        arguments: {
                          addressId: "",
                          address: appStoragePref.getUserAddressData(),
                          isCheckout: true
                        }).then((value) {
                      print("TEST_LOG ==> address ==> ${value}");
                      paymentInfoScreenBloc?.emit(PaymentInfoScreenInitial());
                      paymentInfoScreenBloc
                          ?.add(const CheckoutAddressFetchEvent());
                    });
                  },
                      titleLeft: _localizations
                              ?.translate(AppStringConstant.changeAddress) ??
                          '',
                      titleRight: (_addressListModel?.hasNewAddress ?? false)
                          ? _localizations
                                  ?.translate(AppStringConstant.editAddress) ??
                              ''
                          : _localizations
                                  ?.translate(AppStringConstant.newAddress) ??
                              '',
                      iconLeft: Icons.edit,
                      iconRight: (_addressListModel?.hasNewAddress ?? false)
                          ? Icons.edit
                          : Icons.add,
                      isNewAddress: ((_addressListModel?.hasNewAddress ?? false)
                          ? (_addressListModel?.selectedAddressData?.isNew ??
                              false)
                          : true),
                      hasAddress:
                          ((_addressListModel?.selectedAddressData?.value ?? "")
                                  .isNotEmpty
                              ? true
                              : false))),
            )
          ],
        ),
      ),
    );
  }

  Widget shippinginfo(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _localizations
                  ?.translate(AppStringConstant.shippingAddress)
                  .toUpperCase() ??
              "",
          style: KTextStyle.of(context).boldSixteen,
        ),
        const SizedBox(
          height: 16,
        ),
        addressItemCard(paymentInfoModel?.shippingAddress ?? '', context,
            isElevated: false, showSelector: false),
        // Padding(
        //   padding: const EdgeInsets.only(
        //       top: AppSizes.size8, left: AppSizes.size8, right: AppSizes.size8),
        //   child: Text(
        //       _localizations
        //               ?.translate(AppStringConstant.shippingMethod)
        //               .toUpperCase() ??
        //           "",
        //       style: Theme.of(context).textTheme.displaySmall),
        // ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(
        //       vertical: AppSizes.linePadding, horizontal: AppSizes.size8),
        //   child: Text(
        //     paymentInfoModel?.shippingMethod ?? '',
        //     style: Theme.of(context)
        //         .textTheme
        //         .bodyMedium
        //         ?.copyWith(fontWeight: FontWeight.normal),
        //   ),
        // ),
      ],
    );
  }

  Widget paymentMethod() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _localizations?.translate(AppStringConstant.paymentMethods) ?? "",
          style: KTextStyle.of(context).boldSixteen,
        ),
        const SizedBox(
          height: 16,
        ),
        PaymentMethodsView(
          selectedPaymentCode: selectedPaymentMethodCode,
          walletData: walletData,
          paymentMethods:
              getActivePaymentMethod(paymentInfoModel?.paymentMethods ?? []),
          callBack: (index) {
            if (walletSelected) {
              if (isSufficientBalance) {
                selectedPaymentMethodCode = index;
                walletSelected = false;
                walletData = null;
              } else {
                selectedPaymentMethodCode = index;
                walletSelected = true;
              }
            } else {
              selectedPaymentMethodCode = index;
              walletSelected = false;
            }

            paymentInfoScreenBloc?.emit(PaymentInfoScreenEmptyState());
          },
          paymentCallback: () {},
        ),
        showWalletView(context, paymentInfoModel?.paymentMethods ?? [],
            walletData, walletSelected, (value, isSelected) {
          // setState(() {
          //
          // });
          if (isSelected) {
            selectedPaymentMethodCode = value;
            walletSelected = true;
            paymentInfoScreenBloc?.add(const GetWalletDetails("set"));
          } else {
            walletData = null;
            walletSelected = false;
            selectedPaymentMethodCode = "";
            paymentInfoScreenBloc?.emit(PaymentInfoScreenEmptyState());
          }
          print("selectedPaymentMethodCode $selectedPaymentMethodCode");
        },selectedPaymentMethodCode)
      ],
    );
  }

  void billingAddress(bool isOn) {
    setState(() {
      isAddressSame = isOn;
      // isAddressSame = !isAddressSame;
    });
  }

  List<PaymentMethods> getActivePaymentMethod(
      List<PaymentMethods> allPaymentMethods) {
    List<PaymentMethods> activePaymentMEthods = [];

    allPaymentMethods.forEach((element) {
      if (AppConstant.allowedPaymentMethods.contains(element.code)) {
        activePaymentMEthods.add(element);
      }
    });

    return activePaymentMEthods;
  }
}
