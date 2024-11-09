import 'package:test_new/unvells/network_manager/api_client.dart';

import '../../../../models/base_model.dart';
import '../../../../models/wallet_extension_models/wallet_dashboard_model.dart';

abstract class TrasnferWalletAmountRepo {
  Future <WalletDashboardModel?> getTransferWalletDetails();
  Future <BaseModel?> addPayee(String email, String name);
  Future <BaseModel?> updatePayee(int id, String name);
  Future <BaseModel?> deletePayee(int id);
  Future<BaseModel?> sendCode(int id, int amount, String note);
  Future<BaseModel?> sendMoney(int id, int amount, String note, String otp);
}
class TrasnferWalletAmountRepoMain extends TrasnferWalletAmountRepo {
  @override
  Future<WalletDashboardModel?> getTransferWalletDetails() async{
    var model = await ApiClient().getWalletTransfer();
    return model;
  }

  @override
  Future<BaseModel?> addPayee(String email, String name) async{
    var model = await ApiClient().addPayee(email, name);
    return model;
  }

  @override
  Future<BaseModel?> updatePayee(int id, String name) async{
    var model = await ApiClient().updatePayee(id, name);
    return model;
  }

  @override
  Future<BaseModel?> deletePayee(int id) async{
    var model = await ApiClient().deletePayee(id);
    return model;
  }

  @override
  Future<BaseModel?> sendCode(int id, int amount, String note) async{
    var model = await ApiClient().sendCodeForTransferMoney(id, amount, note);
    return model;
  }

  @override
  Future<BaseModel?> sendMoney(int id, int amount, String note, String otp) async{
    var model = await ApiClient().sendMoney(id, amount, note, otp);
    return model;
  }

}

