
/*
 *
  

 *
 * /
 */

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:test_new/unvells/models/address/get_address.dart';
import 'package:test_new/unvells/network_manager/api_client.dart';

import '../../../models/address/add_address_request.dart';
import '../../../models/address/cities_model.dart';
import '../../../models/base_model.dart';

abstract class AddressBookRepositoryScreen{
  Future<GetAddress> getAddressData(int forDashboard);
  Future<List<GetCitiesByRegion> > getCitiesData({required int regionId});
  Future<BaseModel> deleteAddress(String addressId);
  // Future<BaseModel> saveAddress(String addressId, AddAddressRequest request);

}

class AddressBookRepositoryScreenImp extends AddressBookRepositoryScreen{
  @override
  Future<GetAddress> getAddressData(int forDashboard) async {
    GetAddress? addressdata;
    try{
      addressdata = await ApiClient().getAddressData(forDashboard);
    } catch(error, stacktrace) {
      print("Error --> $error");
      print("Stacktrace --> $stacktrace");
    }
    return addressdata!;
  }@override
  Future<List<GetCitiesByRegion> > getCitiesData({required int regionId}) async {
    List<GetCitiesByRegion> ? addressdata;
    try{
      addressdata = await ApiClient().getCitiesByRegion(regionId: regionId);
    } catch(error, stacktrace) {
      print("Error --> $error");
      print("Stacktrace --> $stacktrace");
    }
    return addressdata!;
  }

  @override
  Future<BaseModel> deleteAddress(String addressId) async {
    var deleteAddress = await ApiClient().deleteAddress(addressId);
    return deleteAddress!;
  }

  /*@override
  Future<BaseModel> saveAddress(String addressId, AddAddressRequest addAddressRequest) async {
    var saveAddress = await ApiClient().saveAddress(addressId, addAddressRequest);
    return saveAddress!;
  }*/
}
