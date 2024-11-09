


//unvells  pre-cache
import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:test_new/unvells/constants/app_constants.dart';

import '../models/catalog/request/catalog_product_request.dart';
import '../network_manager/api_client.dart';

//unvells  pre-cache for category and subcategory
late final Box<Map<dynamic, dynamic>?> mainBox;
 precCacheCategoryPage(int categoryId)  {

  if (AppConstant.enablePrecache) {
    try{
        if (mainBox.containsKey("CategoryPageData:$categoryId")) {

        } else if (mainBox.containsKey("Categories:$categoryId")) {

        } else if (mainBox.containsKey("ChildCategories:$categoryId")) {

        } else {

          ApiClient().getCategoryPageData(categoryId);
        }

    }
    catch(error,stacktrace){
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
  }
}

//unvells  pre-cache for catalog products

 preCacheGetCatalogProducts(CatalogProductRequest request)  {

  if (AppConstant.enablePrecache) {
    try{

        if (mainBox.containsKey("CategoryPageData:${request.id}")) {

        } else if (mainBox.containsKey("Categories:${request.id}")) {

        } else if (mainBox.containsKey("ChildCategories:${request.id}")) {

        } else {

          ApiClient().getProductCollectionData(request.type??"", request.id??"", request.page??1, request.filterData??[], request.sortData);
        }


    }
    catch(error,stacktrace){
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
  }

}

//unvells  pre-cache for product page data
 precCacheProductPage(String id)  {
  if (AppConstant.enablePrecache) {
    try{
        if (mainBox.containsKey("ProductPageData:$id")) {
           print("haa data hai");
        } else {
         print("nhi hai");
          ApiClient().productPageDataPrecache(id);
        }
      //});


    }
    catch(error,stacktrace){
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
  }
}

//unvells  pre-cache for product page data new
 precCacheProductPageNew(String sku)  {
  if (AppConstant.enablePrecache) {
    try{
        if (mainBox.containsKey("ProductPageData:$sku")) {
           print("haa data hai");
        } else {
         print("nhi hai");
          ApiClient().productPageDataForNewPrecache(sku);
        }
      //});


    }
    catch(error,stacktrace){
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
  }
}

//unvells  pre-cache homepage data
 precCacheHomePage(bool isRefresh)  {

  if (AppConstant.enablePrecache) {
    try{
      ApiClient().getHomePageData(isRefresh);
    }
    catch(error,stacktrace){
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
  }

}

//unvells  pre-cache banner data
 preCacheBannerData(String type, String id)  {

  if (AppConstant.enablePrecache) {
    if ((type) == "category") {
      Map<String,String>? sort =  Map<String,String>();
      var req = CatalogProductRequest(page: 1, id: id, type: "category",sortData: sort,filterData: []);
      preCacheGetCatalogProducts(req);
    } else if ((type) == "product") {
      precCacheProductPage(id);
    }
  }
}
