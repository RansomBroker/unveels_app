
/*
 *


 *
 * /
 */

import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../constants/app_constants.dart';
import '../../../helper/encryption.dart';
import '../../../models/categoryPage/category_page_response.dart';
import '../../../models/homePage/home_screen_model.dart';
import '../../../network_manager/api_client.dart';

abstract class CategoryScreenRepository{
   Future<CategoryPageResponse> getCategoryData(int categoryId);
}

class CategoryScreenRepositoryImp extends CategoryScreenRepository{
  @override
  Future<CategoryPageResponse> getCategoryData(int categoryId) async {

    CategoryPageResponse? responseData;
    try{
      responseData = await ApiClient().getCategoryPageData(categoryId);
    }
    catch(error,stacktrace){
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
    return responseData!;
  }

}

