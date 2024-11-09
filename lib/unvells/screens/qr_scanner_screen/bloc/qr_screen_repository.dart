

import '../../../models/base_model.dart';
import '../../../network_manager/api_client.dart';

abstract class QrScreenRepository {
  Future<BaseModel> qrScan(String barCodeData);


}

class QrScreenRepositoryImp implements QrScreenRepository {
  @override
  Future<BaseModel> qrScan(String barCodeData) async {
    var responseData = await ApiClient().qrScan(barCodeData);
    return responseData!;
  }


}
