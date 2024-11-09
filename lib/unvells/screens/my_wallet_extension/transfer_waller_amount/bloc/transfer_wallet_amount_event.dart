abstract class TrasnferWalletAmountEvents{

}

class AddPayeeEvent extends TrasnferWalletAmountEvents {
  String name;
  String email;
  AddPayeeEvent(this.name, this.email );
}

class GetTransferDetails extends TrasnferWalletAmountEvents {

}
class UpdatePayee extends TrasnferWalletAmountEvents{
  int? id;
  String? name;
  UpdatePayee({this.name, this.id});
}

class DeletePayee extends TrasnferWalletAmountEvents{
  int? id;
  DeletePayee({this.id});
}

class SendCodeEvent extends TrasnferWalletAmountEvents {
  int id;
  int amount;
  String note;
  SendCodeEvent({required this.id, required this.amount, required this.note});
}

class SendMoneyEvent extends TrasnferWalletAmountEvents {
  String otp;
  int id;
  int amount;
  String note;
  SendMoneyEvent({required this.id, required this.amount, required this.note, required this.otp});
}