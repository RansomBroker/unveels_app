/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';

import '../../../models/account_info/account_info_model.dart';
import '../../../models/base_model.dart';


abstract class AccountInfoState  {
  const AccountInfoState();

  @override
  List<Object> get props => [];
}

class AccountInfoInitialState extends AccountInfoState {}

class AccountInfoLoadingState extends AccountInfoState {}

class AccountInfoSuccessState extends AccountInfoState {
  final BaseModel data;

  const AccountInfoSuccessState(this.data);
}

class AccountDetailSuccessState extends AccountInfoState {
  final AccountInfoModel data;

  const AccountDetailSuccessState(this.data);
}

class AccountInfoDeactivateState extends AccountInfoState {
  // final AccountInfoModel data;
  const AccountInfoDeactivateState();
}

class AccountInfoErrorState extends AccountInfoState {
  final String message;

  const AccountInfoErrorState(this.message);
}

class AccountInfoDownloadSuccessState extends AccountInfoState {
  // final AccountInfoModel data;
  const AccountInfoDownloadSuccessState();
}


class SaveAccountSuccessState extends AccountInfoState {
  final BaseModel data;

  const SaveAccountSuccessState(this.data);
}


class DeleteAccountState extends AccountInfoState {
  DeleteAccountState(this.data);

  BaseModel data;

  @override
  List<Object> get props => [data];
}

class CompleteState extends AccountInfoState {}
