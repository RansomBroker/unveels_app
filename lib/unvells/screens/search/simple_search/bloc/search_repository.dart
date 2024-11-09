/*
 *


 *
 * /
 */

import 'package:test_new/unvells/models/search/search_screen_model.dart';

import '../../../../network_manager/api_client.dart';

abstract class SearchRepository{
Future<SearchScreenModel> getSearchSuggestion(String searchQuery);
}

class SearchRepositoryImp implements SearchRepository{
  @override
  Future<SearchScreenModel> getSearchSuggestion(String searchQuery) async{

    SearchScreenModel? responseData;
    try{
      responseData = await ApiClient().getSearchSuggestionData(searchQuery);
    }
    catch(error,stacktrace){
      print("Error --> " + error.toString());
      print("StackTrace --> " + stacktrace.toString());
    }
    return responseData!;
  }

}