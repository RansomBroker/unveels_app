
/*
 *


 *
 * /
 */

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/screens/address_book/bloc/address_book_screen_events.dart';
import 'package:test_new/unvells/screens/address_book/bloc/address_book_screen_repository.dart';
import 'package:test_new/unvells/screens/address_book/bloc/address_book_screen_state.dart';

import '../../../models/address/cities_model.dart';

class AddressBookScreenBloc extends Bloc<AddressBookScreenEvent, AddressBookScreenState> {
  AddressBookRepositoryScreen? repository;
  static const String Tag ="AddressBookScreenBloc:- ";

  AddressBookScreenBloc({this.repository}) : super(AddressBookScreenInitial()) {
    on<AddressBookScreenEvent>(mapEventToState);

  }


  bool loadingState = false;
  List<GetCitiesByRegion>citiesList=[];
  void mapEventToState(AddressBookScreenEvent event, Emitter<AddressBookScreenState> emit) async {
    if (event is AddressBookScreenDataFetchEvent) {
      emit(AddressBookScreenInitial());
      try {
        var model = await repository?.getAddressData(event.forDashboard);
        if (model != null) {
          print("$Tag success ");
          emit(AddressBookScreenSuccess(model));
        } else {
          print("$Tag api getAddress api Fail ");
          emit(AddressBookScreenError(''));
        }
      } catch (error, stack) {
        print("$Tag Exception $stack");
        emit(AddressBookScreenError(error.toString()));
      }
    } else if (event is CitiesFetchEvent) {
      emit(AddressBookScreenInitial());
      try {
        loadingState=true;
        var model = await repository?.getCitiesData(regionId:event.regionId);
        citiesList=model??[];
        loadingState=false;
        if (model != null) {
          print("$Tag getCities success ");
          emit(GetCitiesSuccess(model));
        } else {
          print("$Tag api getCities api Fail ");
          emit(AddressBookScreenError(''));
        }
      } catch (error, stack) {
        print("$Tag Exception $stack");
        emit(AddressBookScreenError(error.toString()));
      }
    } else if(event is DeleteAddressEvent) {
      try {
        var model = await repository
            ?.deleteAddress((event).addressId);
        if (model != null) {
          print("$Tag success ");
          emit(DeleteAddressSuccess(model));
        } else {
          print("$Tag api getAddress api Fail ");
          emit(AddressBookScreenError(''));
        }
      } catch (error, stack) {
        print("$Tag Exception $stack");
        emit(AddressBookScreenError(error.toString()));
      }
    } /*else if(event is AddAddressEvent) {
      try {
        var model = await repository
            ?.saveAddress((event).addressId, (event).addAddressRequest);
        if (model != null) {
          print(Tag+ " success ");
          emit(AddAddressSuccess(model));
        } else {
          print(Tag+ " api getAddress api Fail ");
          emit(AddressBookScreenError(''));
        }
      } catch (error, stack) {
        print(Tag+ " Exception " +stack.toString());
        emit(AddressBookScreenError(error.toString()));
      }
    }*/
  }
}