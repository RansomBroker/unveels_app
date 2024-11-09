import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/screens/my_wallet_extension/transfer_waller_amount/bloc/transfer_wallet_amount_event.dart';
import 'package:test_new/unvells/screens/my_wallet_extension/transfer_waller_amount/bloc/transfer_wallet_amount_repo.dart';
import 'package:test_new/unvells/screens/my_wallet_extension/transfer_waller_amount/bloc/transfer_wallet_amount_state.dart';



class TrasnferWalletAmountBloc extends Bloc<TrasnferWalletAmountEvents, TrasnferWalletAmountStates>{
  TrasnferWalletAmountRepoMain? repoMain;
  TrasnferWalletAmountBloc({this.repoMain}):super(TrasnferWalletAmountInitialState()){
    on<TrasnferWalletAmountEvents>(mapTrasnferWalletAmountEvents);
  }
  void mapTrasnferWalletAmountEvents (TrasnferWalletAmountEvents event, Emitter<TrasnferWalletAmountStates> emit)async {
    if(event is GetTransferDetails) {
      emit(TrasnferWalletAmountLoadingState());
      try{
        var model = await repoMain?.getTransferWalletDetails();
        if(model!= null) {
          emit(TransferWallerDetailsSuccess(model: model));
        }else{
          emit(TrasnferWalletAmountErrorState(""));
        }
      }catch(e){
        emit(TrasnferWalletAmountErrorState(e.toString()));
      }
    }
    else if(event is AddPayeeEvent){
      emit(TrasnferWalletAmountLoadingState());
      try{
        var model = await repoMain?.addPayee(event.email, event.name);
        if(model != null) {
          emit(AddPayeeSuccessState(model: model));
        }else{
          emit(TrasnferWalletAmountErrorState(""));
        }
      }catch(e){
        emit(TrasnferWalletAmountErrorState(e.toString()));
      }
    }
    else if(event is UpdatePayee){
      emit(TrasnferWalletAmountLoadingState());
      try{
        var model = await repoMain?.updatePayee(event.id??0, event.name ?? "");
        if(model != null) {
          emit(UpdatePayeeSuccessState(model: model));
        }else{
          emit(TrasnferWalletAmountErrorState(""));
        }
      }catch(e){
        emit(TrasnferWalletAmountErrorState(e.toString()));
      }
    }
    else if(event is DeletePayee){
      emit(TrasnferWalletAmountLoadingState());
      try{
        var model = await repoMain?.deletePayee(event.id??0,);
        if(model != null) {
          emit(UpdatePayeeSuccessState(model: model));
        }else{
          emit(TrasnferWalletAmountErrorState(""));
        }
      }catch(e){
        emit(TrasnferWalletAmountErrorState(e.toString()));
      }
    }
    else if(event is SendCodeEvent) {
      emit(TrasnferWalletAmountLoadingState());
      try{
        var model = await repoMain?.sendCode(event.id, event.amount, event.note,);
        if(model != null) {
          emit(SendCodeSuccessState(model: model, note: event.note, amount: event.amount, id: event.id));
        }else{
          emit(TrasnferWalletAmountErrorState(""));
        }
      }catch(e){
        emit(TrasnferWalletAmountErrorState(e.toString()));
      }
    }

    else if(event is SendMoneyEvent) {
      emit(TrasnferWalletAmountLoadingState());
      try{
        var model = await repoMain?.sendMoney(event.id, event.amount, event.note,event.otp);
        if(model != null) {
          emit(UpdatePayeeSuccessState(model: model));
        }else{
          emit(TrasnferWalletAmountErrorState(""));
        }
      }catch(e){
        emit(TrasnferWalletAmountErrorState(e.toString()));
      }
    }
  }
}