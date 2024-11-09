
/*
 *


 *
 * /
 */

import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/models/base_model.dart';
import 'package:test_new/unvells/network_manager/api_client_retrofit.dart';
import '../../../models/DeliveryboyLocationDetails/deliveryboy_location_details_model.dart';
import '../../../models/google_place_model.dart';
import '../../../network_manager/api_client.dart';

abstract class DeliveryboyTrackRepository{
  Future<GooglePlaceModel> getPlace(String text);
  Future<DeliveryBoyLocationDetailsModel> getDeliveryboyLocationDetails(int? deliveryboyId);
}

class DeliveryboyTrackRepositoryImp implements DeliveryboyTrackRepository{
  @override
  Future<GooglePlaceModel> getPlace(String text)async{
    GooglePlaceModel? model;
    String endPoint = "$text&key=${AppConstant.googleKey}";
    model = await ApiClientRetrofit(baseUrl: "https://maps.googleapis.com/maps/api/").getGooglePlace(endPoint);
    return model!;
  }

  @override
  Future<DeliveryBoyLocationDetailsModel> getDeliveryboyLocationDetails(int? deliveryboyId) async {
    DeliveryBoyLocationDetailsModel? response;
    try {
      response = await ApiClient().getDeliveryBoyLocationDetails(deliveryboyId);
    } catch (error, stacktrace) {
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
    return response!;
  }
}
