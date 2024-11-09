/*
 *


 *
 * /
 */

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/app_widgets/app_bar.dart';
import 'package:test_new/unvells/app_widgets/loader.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/constants/global_data.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/models/address/address_form_data.dart';
import 'package:test_new/unvells/screens/address/bloc/add_edit_address_screen_events.dart';
import 'package:test_new/unvells/screens/address/bloc/add_edit_address_screen_states.dart';
import 'package:test_new/unvells/screens/address/widget/address_form.dart';
import '../../app_widgets/app_alert_message.dart';
import '../../constants/app_routes.dart';
import '../../helper/app_storage_pref.dart';
import '../../models/address/adress_title_model.dart';
import 'bloc/add_edit_address_screen_bloc.dart';

class AddEditAddressScreen extends StatefulWidget {
  AddEditAddressScreen(this.addressId, this.newAddressDataModel,
      this.isCheckout, this.isDefault,
      {Key? key})
      : super(key: key);
  final String? addressId;
  AddressDataModel? newAddressDataModel;
  bool? isCheckout;
  bool? isDefault;

  @override
  State<StatefulWidget> createState() => _AddEditAddressScreen();
}

class _AddEditAddressScreen extends State<AddEditAddressScreen> {
  AddEditAddressScreenBloc? _addEditAddressScreenBloc;
  CheckoutAddressFormDataModel? _addressFormData;
  late bool isLoading;

  @override
  void initState() {
    isLoading = true;
    _addEditAddressScreenBloc = context.read<AddEditAddressScreenBloc>();
    _addEditAddressScreenBloc
        ?.add(AddEditAddressScreenDataFetchEvent(widget.addressId ?? ""));
    print("====----===-->${widget.isDefault}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .background,
        appBar: commonAppBar(
            (widget.addressId?.isEmpty ?? true)
                ? (widget.newAddressDataModel?.firstname?.isEmpty ?? true)
                ? Utils.getStringValue(
                context, AppStringConstant.addNewAddress)
                : Utils.getStringValue(
                context, AppStringConstant.editAddress)
                : Utils.getStringValue(context, AppStringConstant.editAddress),
            context,
            isLeadingEnable: false, onPressed: () {
          Navigator.pop(context);
        }),
        body: _buildMainUi());
  }

  Widget _buildMainUi() {
    return BlocBuilder<AddEditAddressScreenBloc, AddEditAddressState>(
      builder: (context, currentState) {
        if (currentState is AddEditAddressInitial) {
          isLoading = true;
        } else if (currentState is AddressDetailFetchSuccess) {
          isLoading = false;
          _addressFormData = currentState.model;
          print("===--==>${_addressFormData}");
          if (_addressFormData != null) {
            GlobalData.getCheckoutAddressFormDataModel = _addressFormData;
          }
          if (widget.addressId?.isEmpty ?? false) {
            _addressFormData?.addressData = widget.newAddressDataModel;
          }
          // print("TEST_LOG===>test====> ${_addressFormData?.success}");
        } else if (currentState is AddAddressSuccess) {
          isLoading = false;
          if (currentState.model.success == true) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showSuccess(
                  currentState.model.message ?? '', context);
              Navigator.pop(context, true);
            });
          } else {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(currentState.model.message ?? '', context);
            });
          }
        } else if (currentState is AddEditAddressError) {
          isLoading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showError(currentState.message ?? '', context);
          });
        }
        return (_addressFormData != null) ? _buildUI(context) : Loader();
      },
    );
  }

  Widget _buildUI(BuildContext context) {
    return Stack(
      children: <Widget>[
        Visibility(
          visible: _addressFormData != null,
          child: AddressForm(_addressFormData, widget.isCheckout ?? false,
            (widget.addressId?.isEmpty ?? true)
                ? (widget.newAddressDataModel?.firstname?.isEmpty ?? true)
                ? true
                : false
                : false,
                (request) {
              print("teasdytfasdf===> ${widget.isCheckout}");
              // if ((widget.isCheckout ?? false)) {
                log("hereeeeee");
                appStoragePref.setUserAddressData(AddressDataModel(
                  isDefaultBilling: request.default_billing,
                  isDefualtShipping: request.default_shipping,
                  entity_id: "",
                  prifix: request.prefix,
                  firstname: request.firstName,
                  middlename: request.middleName,
                  lastname: request.lastName,
                  suffix: request.suffix,
                  email: request.email,
                  telephone: request.telephone,
                  company: request.company,
                  fax: request.fax,
                  street: request.street,
                  city: request.city,
                  postcode: request.postcode,
                  region_id: request.region_id,
                  region: request.regionName,
                  country_id: request.country_id,
                  countryName: request.countryName,
                  saveAddress: request.save_address,
                  custom_attributes: request.custom_attributes

                ));
                log("hereeeee${request.custom_attributes}");
                // Navigator.of(context).pop(request);
              // }
                // else {
                _addEditAddressScreenBloc
                    ?.add(AddAddressEvent(widget.addressId ?? "", request));
              // }
            }, widget.isDefault ?? false, addrssTitleList: [
              AddressTitleModel(
                  name: Utils.getStringValue(context, AppStringConstant.office),
                  id: '6643'),
              AddressTitleModel(
                  name: Utils.getStringValue(
                      context, AppStringConstant.apartment),
                  id: '6641'),
              AddressTitleModel(
                  name: Utils.getStringValue(context, AppStringConstant.house),
                  id: '6642'),
            ],),
        ),
        Visibility(
          child: const Loader(),
          visible: isLoading,
        ),
      ],
    );
  }
}
