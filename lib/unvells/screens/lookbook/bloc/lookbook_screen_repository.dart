

/*
 *


 *
 * /
 */

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';

import '../../../models/catalog/catalog_model.dart';
import '../../../models/catalog/request/catalog_product_request.dart';
import '../../../models/lookBook/look_book_model.dart';
import '../../../network_manager/api_client.dart';

abstract class LookBookRepository {
  Future<List<LookBookCategories>?> getLookBookProducts();
}

class LookBookRepositoryImpl extends LookBookRepository {
  @override
  Future<List<LookBookCategories>?> getLookBookProducts() async {


    List<LookBookCategories>? responseData;
    try{
      responseData = await ApiClient().lookBookCategories();
      // log("sleeeem=>${responseData?.data}");
    }
    catch(error,stacktrace){
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
    return responseData!;
  }
}
