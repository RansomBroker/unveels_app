/*
 *


 *
 * /
 */

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:test_new/unvells/models/reviews/reviews_list_model.dart';

import '../../../network_manager/api_client.dart';

abstract class ReviewsScreenRepository {
  Future<ReviewsListModel> getReviewsList(int page, bool isFromDashboard);
}

class ReviewsScreenRepositoryImp implements ReviewsScreenRepository {
  @override
  Future<ReviewsListModel> getReviewsList(int page, bool isFromDashboard) async {

    ReviewsListModel? responseData;
    try{
      responseData = await ApiClient().getReviewList(page, isFromDashboard? 1 : 0);
    }
    catch(error,stacktrace){
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
    return responseData!;
  }
}
