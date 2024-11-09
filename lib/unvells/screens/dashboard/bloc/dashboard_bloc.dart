/*
 *


 *
 * /
 */

import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'dashboard_events.dart';
import 'dashboard_repository.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState>{
  DashboardRepositoryImp? repository;
  DashboardBloc({this.repository}): super(DashboardLoadingState()){
    on<DashboardEvent>(mapToEvent);
  }
 void mapToEvent(DashboardEvent event, Emitter<DashboardState> emit) async{
   if(event is DashboardAddressFetchEvent){
      // emit(DashboardLoadingState());
      try {
        var addressList = await repository?.getAddressList();
        if ( addressList != null) {
          emit( DashboardAddressSuccessState( addressList));
        } else {
          emit(const DashboardErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(DashboardErrorState(error.toString()));
      }
    } else if(event is AddImageEvent){
      emit(DashboardLoadingState());
      try {
        var model = await repository?.setImage(event.image, event.type);
        if (model != null) {
          emit( AddImageState(model, event.type));
        } else {
          emit(const DashboardErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(DashboardErrorState(error.toString()));
      }
    }
 }
}