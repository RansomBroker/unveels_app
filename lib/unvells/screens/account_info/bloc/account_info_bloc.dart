/*
 *


 *
 * /
 */

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'account_info_events.dart';
import 'account_info_repository.dart';
import 'account_info_state.dart';

class AccountInfoBloc extends Bloc<AccountInfoEvent, AccountInfoState> {
  AccountInfoRepositoryImp? repository;

  AccountInfoBloc({this.repository}) : super(AccountInfoInitialState()) {
    on<AccountInfoEvent>(mapEventToState);
  }

  void mapEventToState(
      AccountInfoEvent event, Emitter<AccountInfoState> emit) async {
    if (event is AccountDetailEvent) {
      try {
        var addressList = await repository?.getAccountInfoData();
        if (addressList != null) {
          emit(AccountDetailSuccessState(addressList));
        } else {
          emit(const AccountInfoErrorState(''));
        }
      } catch (error, _) {
        if (kDebugMode) {
          print(error.toString());
        }
        emit(AccountInfoErrorState(error.toString()));
      }
    }

    if (event is SaveAccountInfoEvent) {
      emit(AccountInfoLoadingState());
      try {
        var response = await repository?.saveAccountInfo(
          event.prefix,
          event.firstName,
          event.middleName,
          event.lastName,
          event.suffix,
          event.dob,
          event.taxvat,
          event.gender,
          event.email,
          event.mobile,
          event.newPassword,
          event.currentPassword,
          event.confirmPassword,
          event.doChangeEmail,
          event.doChangePassword,
        );
        if (response != null) {
          if ((response.success ?? false)) {
            emit(SaveAccountSuccessState(response));
          } else {
            emit(AccountInfoErrorState(response.message ?? ""));
          }
        } else {
          emit(const AccountInfoErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(AccountInfoErrorState(error.toString()));
      }
    }
    if (event is DeleteAccountEvent) {
      emit(AccountInfoInitialState());
      try {
        var responseData =
            await repository?.deleteAccount(event.email, event.password);
        if (responseData != null) {
          emit(DeleteAccountState(responseData));
        } else {
          emit(const AccountInfoErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(AccountInfoErrorState(error.toString()));
      }
    }
  }
}
