import '../../../../models/base_model.dart';
import '../../../../models/wallet_extension_models/wallet_dashboard_model.dart';

abstract class TrasnferWalletAmountStates {

}

class TrasnferWalletAmountInitialState extends TrasnferWalletAmountStates {

}

class TrasnferWalletAmountLoadingState extends TrasnferWalletAmountStates {

}

class TrasnferWalletAmountErrorState extends TrasnferWalletAmountStates {
  String message;
  TrasnferWalletAmountErrorState(this.message);
}

class TransferWallerDetailsSuccess extends TrasnferWalletAmountStates {
  WalletDashboardModel? model;
  TransferWallerDetailsSuccess({this.model});
}

class AddPayeeSuccessState extends TrasnferWalletAmountStates{
  BaseModel? model;
  AddPayeeSuccessState({this.model});
}

class UpdatePayeeSuccessState extends TrasnferWalletAmountStates{
  BaseModel? model;
  UpdatePayeeSuccessState({this.model});
}

class SendCodeSuccessState extends TrasnferWalletAmountStates{
  BaseModel? model;
  int id;
  int amount;
  String note;
  SendCodeSuccessState({this.model, required this.note, required this.amount, required this.id});
}