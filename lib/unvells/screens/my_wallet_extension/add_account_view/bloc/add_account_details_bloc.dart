import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/screens/my_wallet_extension/add_account_view/bloc/add_account_details_events.dart';

import 'add_account_details_repo.dart';
import 'add_account_details_states.dart';

class AddAccountDetailsBloc extends Bloc<AddAccountDetailsEvents,AddAccountDetailsStates> {
  AddAccountDetailsRepoMain? repoMain;
  AddAccountDetailsBloc(this.repoMain):super(AddAccountDetailsInitialState()){
    on<AddAccountDetailsEvents>(mapAddAccountDetailsEvents);
  }
  void mapAddAccountDetailsEvents (AddAccountDetailsEvents event, Emitter<AddAccountDetailsStates> emit) async{
    if(event is FetchSavedAccountDetailsEvents) {
      emit(AddAccountDetailsLoadingState());
      try {
        var response = await repoMain?.getAccountDetails();
        print("response?.accountDetails?[0].bankName => ${response?.accountDetails?[0].bankName}");
        if (response!= null) {
          emit(AddAccountDetailsSuccessState(model: response));
        }else{
          emit(AddAccountDetailsFailureState(""));
        }
      } catch (e) {
        emit(AddAccountDetailsFailureState(e.toString()));
      }
    }else if(event is DeleteAccount){
      emit(AddAccountDetailsLoadingState());
      try{
        var model = await repoMain?.deleteAccountDetails(event.id??0,);
        if(model != null) {
          emit(DeleteAccountSuccessState(model: model));
        }else{
          emit(AddAccountDetailsFailureState(""));
        }
      }catch(e){
        emit(AddAccountDetailsFailureState(e.toString()));
      }
    }
    else if(event is AddAccountDetailsFormEvents) {
      emit(AddAccountDetailsLoadingState());
      try {
        var response = await repoMain?.addAccountDetails(event.formData);
        if (response!= null) {
          emit(AddAccountFormDetailsSuccessState(model: response));
        }else{
          emit(AddAccountDetailsFailureState(""));
        }
      } catch (e) {
        emit(AddAccountDetailsFailureState(e.toString()));
      }
    }
  }
}