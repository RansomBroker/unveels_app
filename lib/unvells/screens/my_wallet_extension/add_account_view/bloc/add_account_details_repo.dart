import '../../../../models/base_model.dart';
import '../../../../models/wallet_extension_models/account_details_model.dart';
import '../../../../models/wallet_extension_models/add_account_form_model.dart';
import '../../../../network_manager/api_client.dart';

abstract class AddAccountDetailsRepo {
  Future<AccountDetailsModel?>? getAccountDetails();
  Future<BaseModel?>? addAccountDetails(AddAccountFormModel formData);
  Future <BaseModel?> deleteAccountDetails(int id);

}
class AddAccountDetailsRepoMain extends AddAccountDetailsRepo{
  @override
  Future<AccountDetailsModel?>? getAccountDetails() async{
    var model = await ApiClient().getAccountDetails();
    return model;
  }

  @override
  Future<BaseModel?>? addAccountDetails(AddAccountFormModel formData) async {
    var model = await ApiClient().addAccountDetails(formData);
    return model;
  }

  @override
  Future<BaseModel?> deleteAccountDetails(int id) async{
    var model = await ApiClient().deleteBankAccount(id);
    return model;
  }

}