/*
 *


 *
 * /
 */

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:test_new/unvells/models/order_details/order_detail_model.dart';

import '../../../models/printInvoiceView/print_invoice_model.dart';
import '../../../network_manager/api_client.dart';

abstract class InvoiceScreenRepository {
  Future<InvoiceListData> getInvoiceList(String page);
  Future<PrintInvoiceModel> printInvoice(String invoiceId, String incrementId);

}

class InvoiceScreenRepositoryImp implements InvoiceScreenRepository {
  @override
  Future<InvoiceListData> getInvoiceList(String page) async {
    return InvoiceListData();
  }


  @override
  Future<PrintInvoiceModel> printInvoice(String? invoiceId, String? incrementId) async {

    var responseData = await ApiClient().printInvoice(invoiceId,incrementId);
    return responseData!;
  }
}
