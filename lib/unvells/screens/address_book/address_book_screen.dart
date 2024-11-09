/*
 *


 *
 * /
 */

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/app_widgets/app_bar.dart';
import 'package:test_new/unvells/app_widgets/custom_button.dart';
import 'package:test_new/unvells/constants/app_routes.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/app_localizations.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/screens/address_book/bloc/address_book_screen_state.dart';
import 'package:test_new/unvells/screens/address_book/widget/action_container.dart';
import 'package:test_new/unvells/screens/address_book/widget/address_item_card.dart';
import 'package:test_new/unvells/screens/address_book/widget/address_heading_view.dart';

import '../../app_widgets/app_alert_message.dart';
import '../../app_widgets/app_dialog_helper.dart';
import '../../app_widgets/loader.dart';
import '../../app_widgets/lottie_animation.dart';
import '../../configuration/unvells_theme.dart';
import '../../constants/app_constants.dart';
import '../../constants/arguments_map.dart';
import '../../constants/global_data.dart';
import '../../helper/app_storage_pref.dart';
import '../../helper/bottom_sheet_helper.dart';
import '../../models/address/get_address.dart';
import 'bloc/address_book_screen_bloc.dart';
import 'bloc/address_book_screen_events.dart';

class AddressBookScreen extends StatefulWidget {
  bool isFromDashboard;

  AddressBookScreen({Key? key, this.isFromDashboard = false}) : super(key: key);

  @override
  State<AddressBookScreen> createState() => _AddressBookScreenState();
}

class _AddressBookScreenState extends State<AddressBookScreen> {
  AddressBookScreenBloc? _addressBookScreenBloc;
  bool isLoading = true;
  AppLocalizations? _localizations;
  GetAddress? _addressModel;
  late int forDashboard;
  bool? isDefault = false;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    forDashboard = 0;
    _addressBookScreenBloc = context.read<AddressBookScreenBloc>();
    _addressBookScreenBloc?.add(AddressBookScreenDataFetchEvent(forDashboard));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        appBar: widget.isFromDashboard
            ? null
            : commonAppBar(
                Utils.getStringValue(context, AppStringConstant.addressBook)
                    .localized(),
                context,
                bgColor: Colors.white),
        body: _buildMainUi());
  }

  Widget _buildMainUi() {
    return BlocBuilder<AddressBookScreenBloc, AddressBookScreenState>(
      builder: (context, currentState) {
        if (currentState is AddressBookScreenInitial) {
          isLoading = true;
        } else if (currentState is AddressBookScreenSuccess) {
          isLoading = false;
          // GlobalData.getAddressData = currentState.getAddress;
          _addressModel = currentState.getAddress;
          print("---->${_addressModel?.toJson()}");
          if (_addressModel?.addressCount == 0) {
            print("isDefault Data==--->${isDefault}");
            isDefault = true;
          } else {
            isDefault = false;
            print("isDefault Data==Else--->${isDefault}");
          }

          print("RESPONSE------$_addressModel");
        } else if (currentState is AddAddressSuccess) {
          isLoading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showSuccess(
                currentState.model?.message ?? '', context);
            _addressBookScreenBloc
                ?.add(const AddressBookScreenDataFetchEvent(0));
          });
        } else if (currentState is DeleteAddressSuccess) {
          isLoading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showSuccess(
                currentState.baseModel?.message ?? '', context);
          });
          _addressBookScreenBloc?.add(const AddressBookScreenDataFetchEvent(0));
        } else if (currentState is AddressBookScreenError) {
          isLoading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showError(currentState.message ?? '', context);
          });
        }
        return _buildUI(context);
      },
    );
  }

  Widget _buildUI(BuildContext context) {
    return (isLoading == true)
        ? const Loader()
        : SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            // physics: const BouncingScrollPhysics(),
            child: Column(
              // Stack(
              children: <Widget>[
                Visibility(
                  visible: true,
                  // child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // const Divider(height: 0),
                      // _addressModel?.billingAddress?.id == "0" ?  AddressHeadingView(
                      //   address: _addressModel?.billingAddress?.value ?? "",
                      //   title:
                      //   AppStringConstant.defaultBillingAddress.localized(),
                      //
                      // ) :
                      // AddressHeadingView(
                      //   address: _addressModel?.billingAddress?.value ?? "",
                      //   title:
                      //       AppStringConstant.defaultBillingAddress.localized(),
                      //   // (Utils.getStringValue(
                      //   //     context,
                      //   //     AppStringConstant.defaultBillingAddress
                      //   //         .localized())),
                      //   onTap: () {
                      //     Navigator.of(context)
                      //         .pushNamed(AppRoutes.addEditAddress, arguments: {
                      //       addressId: _addressModel?.billingAddress?.id,
                      //       isDefaultAddress: isDefault
                      //     }).then((value) {
                      //       if (value == true) {
                      //         _addressBookScreenBloc?.add(
                      //             AddressBookScreenDataFetchEvent(forDashboard!));
                      //       }
                      //     });
                      //   },
                      // ),
                      // // const Divider(height: 0),
                      // (_addressModel?.shippingAddress?.id == "0") ?
                      // AddressHeadingView(
                      //   address: _addressModel?.shippingAddress?.value ?? "",
                      //   title: (Utils.getStringValue(
                      //       context,
                      //       AppStringConstant.defaultShippingAddress
                      //           .localized())),
                      // ) :
                      // AddressHeadingView(
                      //   address: _addressModel?.shippingAddress?.value ?? "",
                      //   title: (Utils.getStringValue(
                      //       context,
                      //       AppStringConstant.defaultShippingAddress
                      //           .localized())),
                      //   onTap: () {
                      //     // Navigator.of(context).pushNamed(
                      //     //     AppRoutes.addEditAddress,
                      //     //     arguments: {addressId: _addressModel?.shippingAddress?.id}
                      //     // );
                      //     // var addressId = "";
                      //     // addressId = (_addressModel?.shippingAddress?.id)!;
                      //
                      //     Navigator.of(context)
                      //         .pushNamed(AppRoutes.addEditAddress, arguments: {
                      //       addressId: _addressModel?.shippingAddress?.id,
                      //       isDefaultAddress: isDefault
                      //     }).then((value) {
                      //       if (value == true) {
                      //         _addressBookScreenBloc?.add(
                      //             AddressBookScreenDataFetchEvent(forDashboard!));
                      //       }
                      //     });
                      //   },
                      // ),
                      // if ((_addressModel?.additionalAddress ?? []).isNotEmpty)
                      addressList(),

                      const SizedBox(
                        height: AppSizes.size16,
                      ),
                      addAddressContainer(context),
                    ],
                  ),
                  // ),
                ),
                Visibility(
                    visible: false,
                    child: LottieAnimation(
                      lottiePath: AppImages.emptyAddressLottie,
                      title: _localizations
                              ?.translate(AppStringConstant.noAddress) ??
                          "",
                      subtitle: _localizations
                              ?.translate(AppStringConstant.noAddressMessage) ??
                          "",
                      buttonTitle: _localizations
                              ?.translate(AppStringConstant.addNewAddress) ??
                          "",
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.addEditAddress, arguments: {
                          addressId: _addressModel?.billingAddress?.id
                        }).then((value) {});
                      },
                    ) /*(_addressModel == null || _addressModel?.addressData?.isEmpty == true) && !_isLoading,*/),
                const Visibility(
                  visible: false,
                  child: Loader(),
                ),
              ],
              // );
            ));
  }

  Widget addAddressContainer(BuildContext context) {
    print("==--->${isDefault}");
    var isDarkMode =
        SchedulerBinding.instance.window.platformBrightness == Brightness.dark;
    return CustomButton(
      onPressed: () {
        print("==->${isDefault}");
        Navigator.of(context).pushNamed(AppRoutes.addEditAddress,
            arguments: {isDefaultAddress: isDefault}).then((value) {
          if (value == true) {
            _addressBookScreenBloc
                ?.add(const AddressBookScreenDataFetchEvent(0));
          }
        });
      },
      kFillColor: const Color(0xffEEE8DB),
      textColor: AppColors.gold,
      title: AppStringConstant.addNewAddress.localized(),

      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: <Widget>[
      //     const Icon(
      //       Icons.add,
      //       color: AppColors.white,
      //     ),
      //     const SizedBox(width: AppSizes.size8),
      //     Text(
      //       AppStringConstant.addNewAddress.localized().toUpperCase(),
      //       style: Theme.of(context)
      //           .textTheme
      //           .headlineSmall
      //           ?.copyWith(color: Colors.white),
      //     )
      //   ],
      // ),
    );
  }

  Widget shippingAddress() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Divider(height: 0),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.size8, vertical: AppSizes.size16),
          child: Text(
            (Utils.getStringValue(
                context, AppStringConstant.defaultShippingAddress.localized())),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const Divider(height: 0),
        AddressItemCard(
          address: _addressModel?.shippingAddress?.value ?? "",
          onTap: () {
            var addressId = "";
            addressId = (_addressModel?.shippingAddress?.id)!;

            Navigator.of(context).pushNamed(AppRoutes.addEditAddress,
                arguments: {addressId: addressId}).then((value) {
              // var success = value["success"];
              // if (value == true) {
              //   widget.onAddAddressSuccess(true);
              // } else {
              //   widget.onAddAddressSuccess(false);
              // }
            });
          },
        )
      ],
    );
  }

  Widget billingAddress() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.size8, vertical: AppSizes.size16),
          child: Text(
            (Utils.getStringValue(
                context, AppStringConstant.defaultBillingAddress.localized())),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const Divider(height: 0),
        AddressItemCard(
          address: _addressModel?.billingAddress?.value ?? "",
          onTap: () {
            var addressId = "";
            addressId = (_addressModel?.billingAddress?.id)!;

            Navigator.of(context).pushNamed(AppRoutes.addEditAddress,
                arguments: {addressId: addressId}).then((value) {
              // var success = value["success"];
              // if (value == true) {
              //   widget.onAddAddressSuccess(true);
              // } else {
              //   widget.onAddAddressSuccess(false);
              // }
            });
          },
        )
      ],
    );
  }

  Widget addressList() {
    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _addressModel?.additionalAddress?.length ?? 0,
          itemBuilder: (context, index) {
            var addressData = _addressModel?.additionalAddress?[index];
            return AddressItemCard(
              address: addressData?.value ?? "",
              onTap: () {
                showAddressActions(
                  context,
                  onDelete: () {
                    if ((_addressModel?.additionalAddress?.length ?? 0) > 1) {
                      AppDialogHelper.confirmationDialog(
                        Utils.getStringValue(
                          context,
                          AppStringConstant.deleteFromAddress,
                        ),
                        context,
                        _localizations,
                        onConfirm: () async {
                          _addressBookScreenBloc?.add(
                            DeleteAddressEvent(
                                addressData?.id?.toString() ?? ""),
                          );
                          _addressBookScreenBloc
                              ?.emit(AddressBookScreenInitial());
                          // AnalyticsEventsFirebase().removeFromCart(product?.lineId.toString() ?? "0", product?.name ?? "0",);
                        },
                      );
                    } else {
                      AlertMessage.showWarning(
                          Utils.getStringValue(
                              context,
                              AppStringConstant.minimumOneAddressIsRequired
                                  .localized()),
                          context);
                    }
                  },
                  onEdit: () {
                    Navigator.of(context)
                        .pushNamed(AppRoutes.addEditAddress, arguments: {
                      addressId: addressData?.id,
                    }).then((value) {
                      if (value == true) {
                        _addressBookScreenBloc?.add(
                            AddressBookScreenDataFetchEvent(forDashboard));
                      }
                    });
                  },
                );
              },
              // actions: ActionContainer(
              //   titleLeft: AppStringConstant.edit.localized(),
              //   titleRight: AppStringConstant.delete.localized(),
              //   rightCallback: () {
              //     if ((_addressModel?.additionalAddress?.length ?? 0) > 1) {
              //       AppDialogHelper.confirmationDialog(
              //           Utils.getStringValue(
              //               context, AppStringConstant.deleteFromAddress),
              //           context,
              //           _localizations, onConfirm: () async {
              //         _addressBookScreenBloc?.add(
              //             DeleteAddressEvent(addressData?.id?.toString() ?? ""));
              //         _addressBookScreenBloc?.emit(AddressBookScreenInitial());
              //         // AnalyticsEventsFirebase().removeFromCart(product?.lineId.toString() ?? "0", product?.name ?? "0",);
              //       });
              //     } else {
              //       AlertMessage.showWarning(
              //           Utils.getStringValue(
              //               context,
              //               AppStringConstant.minimumOneAddressIsRequired
              //                   .localized()),
              //           context);
              //     }
              //   },
              //   leftCallback: () {
              //     Navigator.of(context)
              //         .pushNamed(AppRoutes.addEditAddress, arguments: {
              //       addressId: addressData?.id,
              //     }).then((value) {
              //       if (value == true) {
              //         _addressBookScreenBloc
              //             ?.add(AddressBookScreenDataFetchEvent(forDashboard!));
              //       }
              //     });
              //   },
              //   iconRight: Icons.delete,
              // ),
            );
          },
          padding: EdgeInsets.zero,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 8,
            );
          },
        ),
        const SizedBox(
          height: 8,
        ),
        AddressItemCard(
          defaultAddress: true,
          address: _addressModel?.shippingAddress?.value ?? "",
          onTap: () {
            showAddressActions(
              context,
              onDelete: null,
              onEdit: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes.addEditAddress, arguments: {
                  addressId: _addressModel?.shippingAddress?.id,
                }).then((value) {
                  if (value == true) {
                    _addressBookScreenBloc
                        ?.add(AddressBookScreenDataFetchEvent(forDashboard));
                  }
                });
              },
            );
          },
        )
      ],
    );
  }

  Widget space() {
    return Container(
      height: AppSizes.size12,
    );
  }
}
