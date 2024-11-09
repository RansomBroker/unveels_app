
/*
 *


 *
 * /
 */

import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../../models/address/address_form_data.dart';
import '../../../../models/checkout/shipping_info/shipping_address_model.dart';
import '../../../../models/checkout/shipping_info/shipping_methods_model.dart';
import '../../../../network_manager/api_client.dart';

abstract class ShippingScreenRepository {
  Future<ShippingAddressModel> getShippingAddress();
  Future<ShippingMethodsModel> getShippingMethods(String addressId, AddressDataModel addressDataModel);
}

class ShippingScreenRepositoryImp extends ShippingScreenRepository {



  @override
  Future<ShippingAddressModel> getShippingAddress() async {
    ShippingAddressModel? responseData;
    try{
      responseData = await ApiClient().checkoutAddress();
    }
    catch(error,stacktrace){
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
    return responseData!;
  }

  @override
  Future<ShippingMethodsModel> getShippingMethods(String addressId, AddressDataModel addressDataModel) async {
    ShippingMethodsModel? responseData;
    try{
      responseData = await ApiClient().shippingMethods(addressId, addressDataModel);
    }
    catch(error,stacktrace){
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
    return responseData!;
  }

}