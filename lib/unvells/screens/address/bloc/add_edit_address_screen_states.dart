
/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';
import 'package:test_new/unvells/models/address/address_form_data.dart';
import 'package:test_new/unvells/models/base_model.dart';

abstract class AddEditAddressState {
  const AddEditAddressState();

  @override
  List<Object?> get props => [];

}

class AddEditAddressInitial extends AddEditAddressState {}

class AddressDetailFetchSuccess extends AddEditAddressState {
  CheckoutAddressFormDataModel model;
   AddressDetailFetchSuccess(this.model);
  @override
  List<Object> get props => [];
}

class UpdateAddressSuccess extends AddEditAddressState {
  final BaseModel model;

  const UpdateAddressSuccess(this.model);

  @override
  List<Object> get props => [];
}

class AddAddressSuccess extends AddEditAddressState {
  final BaseModel model;

  const AddAddressSuccess(this.model);

  @override
  List<Object> get props => [];
}

class AddEditAddressError extends AddEditAddressState {
  AddEditAddressError(this._message);

  String? _message;

  // ignore: unnecessary_getters_setters
  String? get message => _message;

  // ignore: unnecessary_getters_setters
  set message(String? message) {
    _message = message;
  }

  @override
  List<Object> get props => [];
}

class CompleteState extends AddEditAddressState{}
