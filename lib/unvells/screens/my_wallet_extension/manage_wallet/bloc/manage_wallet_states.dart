
import '../../../../models/base_model.dart';
import '../../../../models/wallet_extension_models/transaction_history_model.dart';
import '../../../../models/wallet_extension_models/view_transaction_model.dart';
import '../../../../models/wallet_extension_models/wallet_dashboard_model.dart';

abstract class ManageWalletStates{

}

class ManageWalletInitialState extends ManageWalletStates {

}
class AddMoneyToWalletSuccessState extends ManageWalletStates {
  BaseModel? model;
  AddMoneyToWalletSuccessState({this.model});
}

class GetWalletDashboardDataState extends ManageWalletStates {
  WalletDashboardModel? model;
  GetWalletDashboardDataState({this.model});
}

class ManageWalletScreenErrorState extends ManageWalletStates {
  String message;
  ManageWalletScreenErrorState(this.message);
}

class ManageWalletScreenLoadingState extends ManageWalletStates {
  ManageWalletScreenLoadingState();
}

class ViewTransactionSuccessState extends ManageWalletStates {
  ViewTransactionModel? model;
  ViewTransactionSuccessState({this.model});
}