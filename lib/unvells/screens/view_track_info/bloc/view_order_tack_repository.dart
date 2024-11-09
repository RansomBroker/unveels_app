/*
 *


 *
 * /
 */

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:test_new/unvells/models/shipment_view/shipment_view_model.dart';

import '../../../models/order_details/order_detail_model.dart';
import '../../../network_manager/api_client.dart';

abstract class ViewOrderTrackRepository {
  Future<ShipmentViewModel> getShipmentView(String shipmentId);
}
class ViewOrderTrackRepositoryImp implements ViewOrderTrackRepository {
  @override
  Future<ShipmentViewModel> getShipmentView(String shipmentId) async {
    ShipmentViewModel? shipmentListData;
    try {
      shipmentListData = await ApiClient().getShipmentView(shipmentId);
    } catch (e) {
      print(e);
      throw Exception(e);
    }
    return shipmentListData!;

  }


}
