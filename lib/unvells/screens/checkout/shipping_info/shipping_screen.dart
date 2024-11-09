/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/app_widgets/app_alert_message.dart';
import 'package:test_new/unvells/app_widgets/app_bar.dart';
import 'package:test_new/unvells/app_widgets/app_order_button.dart';
import 'package:test_new/unvells/app_widgets/loader.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/constants/app_routes.dart';
import 'package:test_new/unvells/helper/app_storage_pref.dart';
import 'package:test_new/unvells/helper/bottom_sheet_helper.dart';
import 'package:test_new/unvells/models/checkout/shipping_info/shipping_address_model.dart';
import 'package:test_new/unvells/models/checkout/shipping_info/shipping_methods_model.dart';
import 'package:test_new/unvells/screens/checkout/shipping_info/bloc/shipping_screen_bloc.dart';
import 'package:test_new/unvells/screens/checkout/shipping_info/bloc/shipping_screen_event.dart';
import 'package:test_new/unvells/screens/checkout/shipping_info/bloc/shipping_screen_state.dart';
import 'package:test_new/unvells/screens/checkout/shipping_info/widget/address_item_card.dart';
import 'package:test_new/unvells/screens/checkout/shipping_info/widget/change_address_view.dart';
import 'package:test_new/unvells/screens/checkout/shipping_info/widget/checkout_progress_line.dart';
import 'package:test_new/unvells/screens/checkout/shipping_info/widget/new_address_container.dart';
import 'package:test_new/unvells/screens/checkout/shipping_info/widget/shipping_methods_view.dart';

import '../../../constants/app_string_constant.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/app_localizations.dart';
import '../../../helper/utils.dart';
import '../../../models/address/add_address_request.dart';
import '../../../models/address/address_form_data.dart';
import '../../../models/dashboard/UserDataModel.dart';

class ShippingScreen extends StatefulWidget {
  ShippingScreen(this.amount, {Key? key}) : super(key: key);
  String? amount;

  @override
  State<ShippingScreen> createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingScreen> {
  AppLocalizations? _localizations;
  bool isLoading = false;
  bool isHasDefaultShipping = false;
  ShippingAddressModel? _addressListModel;
  ShippingMethodsModel? _shippingMethodModel;
  ShippingScreenBloc? _shippingScreenBloc;
  String selectedShippingMethod = 'freeshipping_freeshipping';

  @override
  void initState() {
    super.initState();
    _shippingScreenBloc = context.read<ShippingScreenBloc>();
    _shippingScreenBloc?.add(const ShippingAddressFetchEvent());
    // if(appStoragePref.isLoggedIn()) {
    //   _shippingScreenBloc?.add(const ShippingAddressFetchEvent());
    // } else {
    //   Navigator.of(context).pushNamed(
    //       AppRoutes.addEditAddress,
    //       arguments: {"addressId": '0'}
    //   );
    // }
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
            Utils.getStringValue(context, AppStringConstant.shipping), context,
            isLeadingEnable: false),
        body: BlocBuilder<ShippingScreenBloc, ShippingScreenState>(
          builder: (context, state) {
            if (state is ShippingScreenInitial) {
              isLoading = true;
            } else if (state is ShippingAddressSuccess) {
              isLoading = false;
              _addressListModel = state.model;

              if (_addressListModel?.success ?? false) {
                if (_addressListModel?.address != null) {
                  isHasDefaultShipping = true;
                  _addressListModel?.selectedAddressData =
                      _addressListModel?.address?[0];
                } else {
                  isHasDefaultShipping = false;
                }
              } else {
                isHasDefaultShipping = false;
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
                isHasDefaultShipping = true;
              }

              if ((_addressListModel?.address?[0].id ?? '').isNotEmpty ||
                  (appStoragePref.getUserAddressData()?.firstname ?? "")
                      .toString()
                      .isNotEmpty) {
                _shippingScreenBloc?.add(ShippingMethodsFetchEvent(
                    _addressListModel?.address?[0].id ?? '',
                    appStoragePref.getUserAddressData() ?? AddressDataModel()));
              }

              // else if (appStoragePref.isLoggedIn()) {
              //   if (_addressListModel?.success ?? false) {
              //     if (_addressListModel?.address != null) {
              //       isHasDefaultShipping = true;
              //       _addressListModel?.selectedAddressData = _addressListModel?.address?[0];
              //       _shippingScreenBloc?.add(ShippingMethodsFetchEvent(_addressListModel?.address?[0].id??'', appStoragePref.getUserAddressData()??AddressDataModel()));
              //     } else {
              //       isHasDefaultShipping = false;
              //     }
              //   } else {
              //     isHasDefaultShipping = false;
              //   }
              // }

              // if (appStoragePref.isLoggedIn()) {
              //   if (_addressListModel?.success ?? false) {
              //     if (_addressListModel?.address != null) {
              //       isHasDefaultShipping = true;
              //       _addressListModel?.selectedAddressData = _addressListModel?.address?[0];
              //       _shippingScreenBloc?.add(ShippingMethodsFetchEvent(_addressListModel?.address?[0].id??'', appStoragePref.getUserAddressData()??AddressDataModel()));
              //     } else {
              //       isHasDefaultShipping = false;
              //     }
              //   } else {
              //     isHasDefaultShipping = false;
              //   }
              // } else {
              //   if (appStoragePref.getUserAddressData()?.email?.isNotEmpty??false) {
              //     Address addressData = Address(
              //       value: _addressListModel?.getFormattedAddress(appStoragePref.getUserAddressData()!),
              //       id: "",
              //       isNew: true
              //     );
              //     List<Address>? address = [];
              //     address.add(addressData);
              //     _addressListModel?.address = address;
              //     _addressListModel?.selectedAddressData = addressData;
              //     _addressListModel?.hasNewAddress = true;
              //     isHasDefaultShipping = true;
              //     _shippingScreenBloc?.add(ShippingMethodsFetchEvent(_addressListModel?.address?[0].id??'', appStoragePref.getUserAddressData()??AddressDataModel()));
              //   }
              // }
            } else if (state is ShippingMethodSuccess) {
              isLoading = false;
              if (state.model.success ?? false) {
                _shippingMethodModel = state.model;
              } else {
                _shippingMethodModel = null;
                WidgetsBinding.instance?.addPostFrameCallback((_) {
                  AlertMessage.showError(state.model.message ?? '', context);
                });
              }
              _shippingScreenBloc?.emit(ShippingScreenEmptyState());
            } else if (state is ShippingError) {
              isLoading = false;
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showError(state.message ?? '', context);
              });
              _shippingScreenBloc?.emit(ShippingScreenEmptyState());
            } else if (state is ChangeShippingAddressState) {
              _shippingScreenBloc?.add(ShippingMethodsFetchEvent(
                  _addressListModel?.selectedAddressData?.id ?? '',
                  appStoragePref.getUserAddressData() ?? AddressDataModel()));
            }
            return isLoading ? const Loader() : _buildUI();
          },
        ));
  }

  Widget _buildUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            children: [
              checkoutProgressLine(true, context),
              SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  children: [
                    ShowAddressList(
                      (defaultShippingAddressId) {
                        _shippingScreenBloc?.add(const ChangeAddressEvent());
                      },
                      _addressListModel,
                    ),
                    // addAddressContainer(context),

                    // addressItemWithHeading(
                    //     context,
                    //     _localizations
                    //             ?.translate(AppStringConstant.shippingMethod) ??
                    //         '',
                    //     '',
                    //     addressList: ShippingMethodsView(
                    //       shippingMethodList:
                    //           _shippingMethodModel?.shippingMethods ?? [],
                    //       callBack: (selectedIndex) {
                    //         selectedShippingMethod = selectedIndex;
                    //       },
                    //     ),
                    //     showDivider: true)
                    // (isHasDefaultShipping)
                    //     ? Column(
                    //         children: [
                    //           addressItemWithHeading(
                    //               context,
                    //               _localizations?.translate(AppStringConstant.shippingAddress) ??
                    //                   '',
                    //               '${_addressListModel?.selectedAddressData?.value}',
                    //               actions: actionContainer(context, () {
                    //                 shippingAddressModelBottomSheet(context,
                    //                     (defaultShippingAddressId) {
                    //                   _shippingScreenBloc
                    //                       ?.add(const ChangeAddressEvent());
                    //                 }, _addressListModel);
                    //               }, () {
                    //                 Navigator.of(context).pushNamed(
                    //                     AppRoutes.addEditAddress,
                    //                     arguments: {
                    //                       addressId: "",
                    //                       address:
                    //                           appStoragePref.getUserAddressData(),
                    //                       isCheckout: true
                    //                     }).then((value) {
                    //                   print("TEST_LOG ==> address ==> ${value}");
                    //                   _shippingScreenBloc
                    //                       ?.emit(ShippingScreenInitial());
                    //                   _shippingScreenBloc
                    //                       ?.add(const ShippingAddressFetchEvent());
                    //                 });
                    //               },
                    //                   titleLeft: _localizations?.translate(
                    //                           AppStringConstant.changeAddress) ??
                    //                       '',
                    //                   titleRight: (_addressListModel?.hasNewAddress ??
                    //                           false)
                    //                       ? _localizations?.translate(
                    //                               AppStringConstant.editAddress) ??
                    //                           ''
                    //                       : _localizations?.translate(
                    //                               AppStringConstant.newAddress) ??
                    //                           '',
                    //                   iconLeft: Icons.compare_arrows,
                    //                   iconRight:
                    //                       (_addressListModel?.hasNewAddress ?? false)
                    //                           ? Icons.edit
                    //                           : Icons.add,
                    //                   isNewAddress:
                    //                       ((_addressListModel?.hasNewAddress ?? false)
                    //                           ? (_addressListModel
                    //                                   ?.selectedAddressData?.isNew ??
                    //                               false)
                    //                           : true)),
                    //               showDivider: true),
                    //           const SizedBox(
                    //             height: AppSizes.size16,
                    //           ),
                    //           addressItemWithHeading(
                    //               context,
                    //               _localizations?.translate(
                    //                       AppStringConstant.shippingMethod) ??
                    //                   '',
                    //               '',
                    //               addressList: ShippingMethodsView(
                    //                 shippingMethodList:
                    //                     _shippingMethodModel?.shippingMethods ?? [],
                    //                 callBack: (selectedIndex) {
                    //                   selectedShippingMethod = selectedIndex;
                    //                 },
                    //               ),
                    //               showDivider: true)
                    //         ],
                    //       )
                    //     :
                    SizedBox(
                      height: 12,
                    ),
                    addNewAddress(
                      context,
                      _localizations
                              ?.translate(AppStringConstant.addNewAddress) ??
                          '',
                      () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.addEditAddress, arguments: {
                          addressId: "",
                          isCheckout: true
                        }).then((value) {
                          if (value != null) {
                            // print(
                            //     "TEST_LOG ==> address ==> ${value as AddAddressRequest}");
                            _shippingScreenBloc?.emit(ShippingScreenInitial());
                            _shippingScreenBloc
                                ?.add(const ShippingAddressFetchEvent());
                          }
                        });
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        )),
        commonOrderButton(context, _localizations, widget.amount ?? '', () {
          if (isHasDefaultShipping) {
            if (selectedShippingMethod != '') {
              Navigator.pushNamed(context, AppRoutes.paymentInfo,
                  arguments: getCheckoutMap(
                      selectedShippingMethod, _addressListModel!));
            } else {
              AlertMessage.showError(
                  _localizations
                          ?.translate(AppStringConstant.selectShippingMethod) ??
                      "",
                  context);
            }
          } else {
            AlertMessage.showError(
                _localizations
                        ?.translate(AppStringConstant.addShippingAddress) ??
                    "",
                context);
          }
        })
      ],
    );
  }
}
