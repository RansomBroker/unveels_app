import '../../../../models/wallet_extension_models/add_account_form_model.dart';

abstract class AddAccountDetailsEvents{

}
class FetchSavedAccountDetailsEvents extends AddAccountDetailsEvents {
  FetchSavedAccountDetailsEvents();
}

class AddAccountDetailsFormEvents extends AddAccountDetailsEvents {
  AddAccountFormModel formData;
  AddAccountDetailsFormEvents(this.formData);
}

class DeleteAccount extends AddAccountDetailsEvents{
  int? id;
  DeleteAccount({this.id});
}