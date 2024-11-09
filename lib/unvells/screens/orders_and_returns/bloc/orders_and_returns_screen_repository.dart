/*
 *


 *
 * /
 */

import 'package:test_new/unvells/models/guestView/guestView.dart';
import 'package:test_new/unvells/network_manager/api_client.dart';

import '../../../models/orders_and_returns/orders_and_returns_model.dart';

abstract class OrdersAndReturnsRepository {
  Future<GuestView> getOrdersAndReturnsData(String incrementId, String email, String lastName, String zipCode,String type);
}

class OrdersAndReturnsRepositoryImp implements OrdersAndReturnsRepository {
  @override
  Future<GuestView> getOrdersAndReturnsData(String incrementId, String email, String lastName, String zipCode,String type) async{
    GuestView? response;
    try {
      response = await ApiClient().ordersAndReturnsData(incrementId, email, lastName, zipCode, type);
    } catch (e) {
      print(e);
      throw Exception(e);
    }
    return response!;
  }
}