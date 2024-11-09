import 'package:test_new/unvells/models/wallet_extension_models/transaction_history_model.dart';
import 'package:test_new/unvells/models/wallet_extension_models/view_transaction_model.dart';

import '../../../../models/base_model.dart';
import '../../../../models/wallet_extension_models/wallet_dashboard_model.dart';
import '../../../../network_manager/api_client.dart';

abstract class ManageWalletRepo {
  Future <WalletDashboardModel?> getWalletDashboard();
  Future <BaseModel?> addMoneyToWallet(String amount, int productId);
  Future <ViewTransactionModel?> viewTransaction(int id);
  Future <BaseModel?> transferMoney(int amount, String id, String note);
}
class ManageWalletRepoMain extends ManageWalletRepo {

  @override
  Future<WalletDashboardModel?> getWalletDashboard() async{
    var model =  await ApiClient().getWalletDashboard();
    return model;
  }

  @override
  Future<BaseModel?> addMoneyToWallet(String amount, int productId) async{
    var model =  await ApiClient().addMoneyToWallet(amount, productId);
    return model;
  }

  @override
  Future<ViewTransactionModel?> viewTransaction(int id) async{
    var model =  await ApiClient().viewTransaction(id);
    return model;
  }

  @override
  Future<BaseModel?> transferMoney(int amount, String id, String note) async{
   var model = await ApiClient().transferAmountToBank(amount, id, note);
   return model;
  }


}