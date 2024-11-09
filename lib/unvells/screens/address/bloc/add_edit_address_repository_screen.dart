/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/models/address/address_form_data.dart';
import 'package:test_new/unvells/network_manager/api_client.dart';

import '../../../models/address/add_address_request.dart';
import '../../../models/base_model.dart';

abstract class AddEditAddressScreenRepository{
  Future<CheckoutAddressFormDataModel?> checkoutAddressFormData(String? addressId);
  Future<BaseModel> saveAddress(String addressId, AddAddressRequest request);

}

class AddEditAddressScreenRepositoryImp extends AddEditAddressScreenRepository{
  @override
  Future<CheckoutAddressFormDataModel?> checkoutAddressFormData(String? addressId) async {
    CheckoutAddressFormDataModel? addressFormData;
    try{
      addressFormData = await ApiClient().checkoutAddressFormData(addressId??"");
    } catch(error, stacktrace) {
      print("Error --> " + error.toString());
      print("Stacktrace --> " + stacktrace.toString());
    }
    return addressFormData!;
  }


  @override
  Future<BaseModel> saveAddress(String addressId, AddAddressRequest addAddressRequest) async {
    BaseModel? saveAddress;

    try {
      saveAddress = await ApiClient().saveAddress(
          addressId,
          addAddressRequest
      );
    } catch(e, stacktrace){
      print("Error --> $e");
      print("StackTrace --> $stacktrace");
    }
    return saveAddress!;
  }


}