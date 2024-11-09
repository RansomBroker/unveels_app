import 'package:flutter_bloc/flutter_bloc.dart';

import 'manage_wallet_events.dart';
import 'manage_wallet_repo.dart';
import 'manage_wallet_states.dart';

class ManageWalletBloc extends Bloc<ManageWalletEvents, ManageWalletStates>{
  ManageWalletRepoMain? repoMain;
  ManageWalletBloc({this.repoMain}):super(ManageWalletInitialState()){
    on<ManageWalletEvents>(mapManageWalletEvents);
  }
  void mapManageWalletEvents (ManageWalletEvents event, Emitter<ManageWalletStates> emit)async {
    if (event is GetWalletDetailsEvent) {
      emit(ManageWalletScreenLoadingState());
      try{
        var model = await repoMain?.getWalletDashboard();
        if(model!= null) {
          emit(GetWalletDashboardDataState(model: model));
        }else{
          emit(ManageWalletScreenErrorState(""));
        }
      }catch(e){
        emit(ManageWalletScreenErrorState(e.toString()));
      }
    }

    else if(event is AddAmountToCartEvent) {
      emit(ManageWalletScreenLoadingState());
      try{
        var model = await repoMain?.addMoneyToWallet(event.amount, event.productId);
        if(model!= null) {
          emit(AddMoneyToWalletSuccessState(model: model));
        }else{
          emit(ManageWalletScreenErrorState(""));
        }
      }catch(e){
        emit(ManageWalletScreenErrorState(e.toString()));
      }
    }

    else if(event is GetTransactionDetails) {
      emit(ManageWalletScreenLoadingState());
      try{
        var model = await repoMain?.viewTransaction(event.transactionId ?? 0);
        if(model!= null) {
          emit(ViewTransactionSuccessState(model: model));
        }else{
          emit(ManageWalletScreenErrorState(""));
        }
      }catch(e){
        emit(ManageWalletScreenErrorState(e.toString()));
      }
    }
    else if(event is TransferAmountToBankEvent) {
      emit(ManageWalletScreenLoadingState());
      try {
        var model = await repoMain?.transferMoney(
            event.amount, event.id, event.note);
        if (model != null) {
          emit(AddMoneyToWalletSuccessState(model: model));
        } else {
          emit(ManageWalletScreenErrorState(""));
        }
      } catch (e) {
        emit(ManageWalletScreenErrorState(e.toString()));
      }
    }

  }
}