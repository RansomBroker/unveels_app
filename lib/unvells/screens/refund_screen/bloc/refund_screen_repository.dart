/*
 *


 *
 * /
 */

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:test_new/unvells/models/order_details/order_detail_model.dart';

abstract class RefundScreenRepository {
  Future<Creditmemo> getInvoiceList(String page);
}

class RefundScreenRepositoryImp implements RefundScreenRepository {
  @override
  Future<Creditmemo> getInvoiceList(String page) async {
    return Creditmemo();
  }
}
