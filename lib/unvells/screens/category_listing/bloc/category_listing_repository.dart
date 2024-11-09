

/*
 *


 *
 * /
 */

import '../../../models/categoryPage/category_page_response.dart';
import '../../../network_manager/api_client.dart';

abstract class CategoryListingRepository{
   Future<CategoryPageResponse> getCategoryData(int categoryId);
}

class CategoryListingRepositoryImp extends CategoryListingRepository{
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

