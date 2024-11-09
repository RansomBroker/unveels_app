/*
 *


 *
 * /
 */

import 'package:test_new/unvells/network_manager/api_client.dart';

import '../../../models/cms_page/cms_page_model.dart';

abstract class CmsPageRepository {
  Future<CmsPageModel> getCmsData(String id);
}

class CmsPageRepositoryImp implements CmsPageRepository {
  @override
  Future<CmsPageModel> getCmsData(String id) async{
    var model = await ApiClient().cmsPage(id);
    return model!;
  }
}