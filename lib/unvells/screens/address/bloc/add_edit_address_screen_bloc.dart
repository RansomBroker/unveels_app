
/*
 *


 *
 * /
 */

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/screens/address/bloc/add_edit_address_repository_screen.dart';
import 'package:test_new/unvells/screens/address/bloc/add_edit_address_screen_events.dart';
import 'package:test_new/unvells/screens/address/bloc/add_edit_address_screen_states.dart';

class AddEditAddressScreenBloc extends Bloc<AddEditAddressScreenEvent, AddEditAddressState> {
  AddEditAddressScreenRepository? repository;
  static const String Tag ="AddEditAddressScreenBloc:- ";

  AddEditAddressScreenBloc({this.repository}) : super(AddEditAddressInitial()) {
    on<AddEditAddressScreenEvent>(mapEventToState);
  }

  void mapEventToState(
      AddEditAddressScreenEvent event, Emitter<AddEditAddressState> emit) async {
    if (event is AddEditAddressScreenDataFetchEvent) {
      emit(AddEditAddressInitial());
      try {
        var model = await repository?.checkoutAddressFormData(event.addressId);
        if (model != null) {
          emit(AddressDetailFetchSuccess(model));
        } else {
          emit(AddEditAddressError(''));
        }
      } catch (error, stack) {
        print("$Tag Exception$stack");
        emit(AddEditAddressError(error.toString()));
      }
    } else if (event is AddAddressEvent) {
      try {
        emit(AddEditAddressInitial());
        var model = await repository?.saveAddress((event).addressId, (event).addAddressRequest);
        if (model != null) {
          emit(AddAddressSuccess(model));
        } else {
          emit(AddEditAddressError(''));
        }
      } catch (error, stack) {
        print(Tag+ " Exception " +stack.toString());
        emit(AddEditAddressError(error.toString()));
      }
    }
  }
}