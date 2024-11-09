/*
 *


 *
 * /
 */

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:test_new/unvells/network_manager/api_client.dart';

import '../../../models/invoice_view/invoice_view_model.dart';
import '../../../models/printInvoiceView/print_invoice_model.dart';

abstract class ViewInvoiceScreenRepository {
  Future<InvoiceViewModel> getInvoiceView(String inviceId);
  Future<PrintInvoiceModel> printInvoice(String invoiceId, String incrementId);
}
class ViewInvoiceScreenRepositoryImp implements ViewInvoiceScreenRepository {
  @override
  Future<InvoiceViewModel> getInvoiceView(String invoiceId) async {
    InvoiceViewModel? responseData;
    try {
      responseData = await ApiClient().getInvoiceView(invoiceId);
    } catch (e) {
      print(e);
      throw Exception(e);
    }
    return responseData!;
  }


  @override
  Future<PrintInvoiceModel> printInvoice(String? invoiceId, String? incrementId) async {

    var responseData = await ApiClient().printInvoice(invoiceId,incrementId);
    return responseData!;
  }

}
