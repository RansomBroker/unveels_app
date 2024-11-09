
/*
 *


 *
 * /
 */

import 'package:test_new/unvells/models/reviews/review_details_model.dart';

import '../../../network_manager/api_client.dart';

abstract class ReviewDetailsScreenRepository {
  Future<ReviewDetailsModel> getReviewDetails(String id);
}

class ReviewDetailsScreenRepositoryImp implements ReviewDetailsScreenRepository {
  @override
  Future<ReviewDetailsModel> getReviewDetails(String id) async {

    ReviewDetailsModel? responseData;
    try{
      responseData = await ApiClient().getReviewDetails(id);
    }
    catch(error,stacktrace){
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
    return responseData!;
  }
}
