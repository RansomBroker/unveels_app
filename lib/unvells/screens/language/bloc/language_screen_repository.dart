/*
 *


 *
 * /
 */

import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../models/base_model.dart';

abstract class LanguageRepository {
  // Future<BaseModel> getLanguageList();
}

class LanguageRepositoryImp implements LanguageRepository {
  /*@override
  Future<BaseModel> getLanguageList() async {
    try {
      final String response = await rootBundle.loadString('assets/responses/base_model_response.json');
      Map<String, dynamic> userMap = jsonDecode(response);
      var responseData = BaseModel.fromJson(userMap);
      return responseData;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }*/
}
