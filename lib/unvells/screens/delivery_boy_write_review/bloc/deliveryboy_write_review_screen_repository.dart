/*
 *


 *
 * /
 */

import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../models/base_model.dart';
import '../../../models/reviews/rating_form_data_model.dart';
import '../../../network_manager/api_client.dart';

abstract class DeliveryboyWriteReviewRepository {
  Future<BaseModel> getAddReview(int rating, int customerId, String title, String comment, int deliveryboyId, String? orderId, String? nickName);
}

class DeliveryboyWriteReviewRepositoryImp implements DeliveryboyWriteReviewRepository {
  @override
  Future<BaseModel> getAddReview(int? rating, int? customerId, String? title, String? comment, int? deliveryboyId, String? orderId, String? nickName) async {
    try {
      var model = await ApiClient().deliveryBoySaveReview(rating, customerId, title, comment, deliveryboyId, orderId, nickName);
      return model!;
    } catch (e, str) {
      print(e);
      print(str);
      throw Exception(e);
    }
  }
}
