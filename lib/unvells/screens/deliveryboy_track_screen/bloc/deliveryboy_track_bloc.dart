/*
 *


 *
 * /
 */

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/screens/deliveryboy_track_screen/bloc/deliveryboy_track_state.dart';
import 'package:test_new/unvells/screens/location_screen/bloc/location_state.dart';

import '../views/deliveryboy_place_search.dart';
import 'deliveryboy_track_event.dart';
import 'deliveryboy_track_repository.dart';

class DeliveryboyTrackBloc extends Bloc<DeliveryboyTrackEvent, DeliveryboyTrackState>{
  DeliveryboyTrackRepositoryImp? repository;
  DeliveryboyTrackBloc({this.repository}):super(DeliveryboyTrackInitialState()){
    on<DeliveryboyTrackEvent>(mapEventToState);
  }

  @override
  void mapEventToState(
      DeliveryboyTrackEvent event, Emitter<DeliveryboyTrackState> emit) async {
    if(event is DeliveryboyPlaceSearchFetchEvent){
      emit(DeliveryboyTrackLoadingState());
      try {
        var model = await repository?.getPlace(event.query);
        if (model != null) {
          emit(DeliveryboySearchPlaceSuccessState(model));
        } else {
          emit(DeliveryboyErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(DeliveryboyErrorState(error.toString()));
      }
    } else if(event is DeliveryBoyLocationDetailsFetchEvent){
      emit(DeliveryboyTrackLoadingState());
      try {
        var model = await repository?.getDeliveryboyLocationDetails(event.deliveryboyId);
        if (model != null) {
          emit(DeliveryboyLocationSuccessState(model));
        } else {
          emit(DeliveryboyErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(DeliveryboyErrorState(error.toString()));
      }
    }
    else if(event is SearchPlaceInitialEvent){
      emit(DeliveryboyTrackInitialState());
    }
  }
}