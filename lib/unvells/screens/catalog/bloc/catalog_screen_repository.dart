

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
import '../../../network_manager/api_client.dart';

abstract class CatalogRepository {
  Future<CatalogModel> getCatalogProducts(CatalogProductRequest request);
}

class CatalogRepositoryImpl extends CatalogRepository {
  @override
  Future<CatalogModel> getCatalogProducts(CatalogProductRequest request) async {


    CatalogModel? responseData;
    try{
      log("request.category_id${request.category_id}");
      responseData = await ApiClient().getProductCollectionData(request.category_id!="null"? "category":request.type??'',(request.category_id!="null"? request.category_id:request.id)??"", request.page??1, request.filterData??[], request.sortData);
    }
    catch(error,stacktrace){
      // rethrow;
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
    return responseData!;
  }
}
