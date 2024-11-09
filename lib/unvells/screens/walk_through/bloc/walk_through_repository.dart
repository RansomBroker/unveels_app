/*
 *


 *
 * /
 */

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:test_new/unvells/models/shipment_view/shipment_view_model.dart';

import '../../../models/order_details/order_detail_model.dart';
import '../../../models/walk_through/walk_through_model.dart';
import '../../../network_manager/api_client.dart';

abstract class WalkThroughRepository {
  Future<WalkThroughModel> getWalkThroughData();
}
class WalkThroughRepositoryImp implements WalkThroughRepository {
  @override
  Future<WalkThroughModel> getWalkThroughData() async {
    WalkThroughModel? data;
    try {
      data = await ApiClient().getWalkThrough();
    } catch (e) {
      print(e);
      throw Exception(e);
    }
    return data!;

  }


}
