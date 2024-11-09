/*
 *
  

 *
 * /
 */

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:test_new/unvells/network_manager/api_client.dart';
import '../../../models/download_product/download_product.dart';
import '../../../models/downloadable_products/downloadable_products_list_model.dart';

abstract class DownloadableProductsScreenRepository {
  Future<DownloadableProductsListModel> getDownloadableProductsList(String pageNumber);
  Future<DownloadProduct> downloadProduct(String itemHash);
}

class DownloadableProductsScreenRepositoryImp implements DownloadableProductsScreenRepository {
  @override
  Future<DownloadableProductsListModel> getDownloadableProductsList(String pageNumber) async {

      var responseData = await ApiClient().myDownloadsList(pageNumber);
      return responseData!;

  }

  @override
  Future<DownloadProduct> downloadProduct(String itemHash) async {

    var responseData = await ApiClient().downloadProduct(itemHash);
    return responseData!;

  }

}
