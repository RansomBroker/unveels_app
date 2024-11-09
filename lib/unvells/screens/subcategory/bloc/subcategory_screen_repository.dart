
/*
 *


 *
 * /
 */

import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../models/categoryPage/category_page_response.dart';
import '../../../network_manager/api_client.dart';

abstract class SubCategoryScreenRepository{
  Future<CategoryPageResponse> getCategoryData(int categoryId);
}

class SubCategoryScreenRepositoryImp extends SubCategoryScreenRepository{
  @override
  Future<CategoryPageResponse> getCategoryData(int categoryId) async {
    CategoryPageResponse? responseData;
    try {
      responseData = await ApiClient().getCategoryPageData(categoryId);
    }
    catch (error, stacktrace) {
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
    return responseData!;
  }

}