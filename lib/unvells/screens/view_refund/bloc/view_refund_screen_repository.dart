/*
 *
  

 *
 * /
 */

import 'dart:convert';

import 'package:test_new/unvells/network_manager/api_client.dart';

import '../../../models/refund_view/refund_view_model.dart';


abstract class ViewRefundScreenRepository {
  Future<RefundViewModel> getInvoiceView(String creditMemoId);
}
class ViewRefundScreenRepositoryImp implements ViewRefundScreenRepository {
  @override
  Future<RefundViewModel> getInvoiceView(String creditMemoId) async {
    RefundViewModel? responseData;
    try {
      responseData = await ApiClient().getCreditView(creditMemoId);
    } catch (e) {
      print(e);
      throw Exception(e);
    }
    return responseData!;
  }


}
