/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';

import '../../../models/address/add_address_request.dart';

abstract class AddEditAddressScreenEvent extends Equatable {
  const AddEditAddressScreenEvent();

  @override
  List<Object> get props => [];
}

class AddEditAddressScreenDataFetchEvent extends AddEditAddressScreenEvent {
  const AddEditAddressScreenDataFetchEvent(this.addressId);

  final String addressId;

  @override
  List<Object> get props => [addressId];
}

class LoadingAddressEvent extends AddEditAddressScreenEvent{}

class UpdateAddressEvent extends AddEditAddressScreenEvent {
  final String endPoint, name, phone, street, city, zip, countryId, stateId;

  const UpdateAddressEvent(this.endPoint, this.name, this.phone, this.street,
      this.city, this.zip, this.countryId, this.stateId);

  @override
  List<Object> get props => [];
}

class AddAddressEvent extends AddEditAddressScreenEvent {
  final AddAddressRequest addAddressRequest;
  final String addressId;

  const AddAddressEvent(this.addressId, this.addAddressRequest);

  @override
  List<Object> get props => [];
}

class LoadingAddAddressEvent extends AddEditAddressScreenEvent {}
