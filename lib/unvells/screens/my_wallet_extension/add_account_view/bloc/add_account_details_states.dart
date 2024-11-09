import 'package:test_new/unvells/models/base_model.dart';

import '../../../../models/wallet_extension_models/account_details_model.dart';

abstract class AddAccountDetailsStates{

}
class AddAccountDetailsInitialState extends AddAccountDetailsStates{

}
class AddAccountDetailsLoadingState extends AddAccountDetailsStates{

}
class AddAccountDetailsSuccessState extends AddAccountDetailsStates{
  AccountDetailsModel? model;
  AddAccountDetailsSuccessState({this.model});
}
class AddAccountDetailsFailureState extends AddAccountDetailsStates {
  String message;
  AddAccountDetailsFailureState(this.message);
}

class AddAccountFormDetailsSuccessState extends AddAccountDetailsStates {
  BaseModel ? model;
  AddAccountFormDetailsSuccessState({this.model});
}

class DeleteAccountSuccessState extends AddAccountDetailsStates {
  BaseModel ? model;
  DeleteAccountSuccessState({this.model});
}