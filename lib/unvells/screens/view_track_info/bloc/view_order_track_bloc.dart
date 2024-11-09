
/*
 *
  

 *
 * /
 */

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/screens/view_order_shipment/bloc/view_order_shipment_event.dart';
import 'package:test_new/unvells/screens/view_order_shipment/bloc/view_order_shipment_repository.dart';
import 'package:test_new/unvells/screens/view_order_shipment/bloc/view_order_shipment_state.dart';
import 'package:test_new/unvells/screens/view_track_info/bloc/view_order_tack_repository.dart';
import 'package:test_new/unvells/screens/view_track_info/bloc/view_order_track_event.dart';
import 'package:test_new/unvells/screens/view_track_info/bloc/view_order_track_state.dart';

class ViewOrderTrackBloc extends Bloc<ViewOrderTrackEvent, ViewOrderTrackState> {
  ViewOrderTrackRepositoryImp? repository;

  ViewOrderTrackBloc({this.repository}) : super(ViewOrderTrackInitial()) {
    on<ViewOrderTrackEvent>(mapEventToState);
  }

  void mapEventToState(
      ViewOrderTrackEvent event, Emitter<ViewOrderTrackState> emit) async {
    if (event is ViewOrderTrackFetchEvent) {
      emit(ViewOrderTrackInitial());
      try {
        var model = await repository?.getShipmentView(event.viewOrderShipmentItemsId);
        if (model != null) {
          emit(ViewOrderTrackSuccess(model));
        } else {
          emit(const ViewOrderTrackError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(ViewOrderTrackError(error.toString()));
      }
    }
  }
}
