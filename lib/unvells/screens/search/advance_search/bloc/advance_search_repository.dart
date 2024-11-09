/*
 *


 *
 * /
 */

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:test_new/unvells/models/search/advance_search_model.dart';

import '../../../../network_manager/api_client.dart';

abstract class AdvanceSearchRepository{
  Future<AdvanceSearchModel> getAdvanceSearchSuggestion(String text);
}

class AdvanceSearchRepositoryImp implements AdvanceSearchRepository{
  @override
  Future<AdvanceSearchModel> getAdvanceSearchSuggestion(String text) async{

    AdvanceSearchModel? responseData;
    try{
      responseData = await ApiClient().getAdvancedSearchFormData();
    }
    catch(error,stacktrace){
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
    return responseData!;
  }

}