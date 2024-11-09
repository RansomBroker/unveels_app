/*
 *
  

 *
 * /
 */

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:test_new/unvells/network_manager/api_client.dart';
import '../../../models/base_model.dart';
import '../../../models/deliveryBoyDetails/delivery_boy_details_model.dart';
import '../../../models/order_details/order_detail_model.dart';

abstract class OrderDetailRepository {
  Future<OrderDetailModel> getOrderDetails(String orderEndpoint);

  Future<BaseModel> reorder(String incrementId);

  Future<DeliveryBoyDetailsModel> getDeliveryBoyDetails(String incrementId);
}

class OrderDetailRepositoryImp implements OrderDetailRepository {
  @override
  Future<OrderDetailModel> getOrderDetails(String orderId) async {
    OrderDetailModel? orderDetailModel;
    try {
      orderDetailModel = await ApiClient().getOrderDetails(orderId);
    } catch (error, stacktrace) {
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
    return orderDetailModel!;
  }

  @override
  Future<DeliveryBoyDetailsModel> getDeliveryBoyDetails(String orderId) async {
    DeliveryBoyDetailsModel? deliveryBoys;
    try {
      deliveryBoys = await ApiClient().getDeliveryBoyDetails(orderId);
    } catch (error, stacktrace) {
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
    return deliveryBoys!;
  }

  @override
  Future<BaseModel> reorder(String incrementId) async {
    var responseData = await ApiClient().reorder(incrementId);
    return responseData!;
  }
}
