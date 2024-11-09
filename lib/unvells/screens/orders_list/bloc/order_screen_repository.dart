
/*
 *


 *
 * /
 */

import 'package:test_new/unvells/models/base_model.dart';
import 'package:test_new/unvells/models/productDetail/add_to_cart_response.dart';

import '../../../models/order_details/order_detail_model.dart';
import '../../../models/order_list/order_list_model.dart';
import '../../../network_manager/api_client.dart';

abstract class OrderScreenRepository {
  Future<OrderListModel> getOrderList(int page, bool isFromDashboard);
  Future<BaseModel> reorder(String incrementId);
  Future<OrderDetailModel> getOrderDetails(String orderId);

}

class OrderScreenRepositoryImp implements OrderScreenRepository {
  @override
  Future<OrderListModel> getOrderList(int page, bool isFromDashboard) async {

    OrderListModel? responseData;
    try{
      responseData = await ApiClient().getOrderList(page, isFromDashboard? 1 : 0);
    }
    catch(error,stacktrace){
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
    return responseData!;
  }

  @override
  Future<BaseModel> reorder(String incrementId) async {

    var responseData = await ApiClient().reorder(incrementId);
    return responseData!;
  }

  @override
  Future<OrderDetailModel> getOrderDetails(String orderId) async {
    OrderDetailModel? orderDetailModel;
    try{
      orderDetailModel = await ApiClient().getOrderDetails(orderId);
    } catch (error,stacktrace) {
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
    return orderDetailModel!;
    /* try {
      final String response = await rootBundle.loadString('assets/responses/order_details.json');
      Map<String, dynamic> userMap = jsonDecode(response);
      var responseData = OrderDetailModel.fromJson(userMap);
      return responseData;
    } catch (e, err) {
      print(e);
      print(err);
      throw Exception(e);
    }*/
  }
}
