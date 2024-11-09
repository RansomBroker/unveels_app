
/*
 *


 *
 * /
 */

import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/network_manager/api_client_retrofit.dart';
import '../../../models/google_place_model.dart';

abstract class LocationRepository{
  Future<GooglePlaceModel> getPlace(String text);
}

class LocationRepositoryImp implements LocationRepository{
  @override
  Future<GooglePlaceModel> getPlace(String text)async{
    GooglePlaceModel? model;
    String endPoint = "$text&key=${AppConstant.googleKey}";
    model = await ApiClientRetrofit(baseUrl: "https://maps.googleapis.com/maps/api/").getGooglePlace(endPoint);
    return model!;
  }
}
