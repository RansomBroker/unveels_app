abstract class ManageWalletEvents {

}

class GetWalletDetailsEvent extends ManageWalletEvents {
  GetWalletDetailsEvent();
}

class AddAmountToCartEvent extends ManageWalletEvents {
  int productId;
  String amount;
  AddAmountToCartEvent(this.productId, this.amount);
}

class GetTransactionDetails extends ManageWalletEvents {
  int? transactionId;
  GetTransactionDetails(this.transactionId);
}

class TransferAmountToBankEvent extends ManageWalletEvents {
  int amount;
  String id;
  String note;
  TransferAmountToBankEvent(this.amount, this.id, this.note);
}