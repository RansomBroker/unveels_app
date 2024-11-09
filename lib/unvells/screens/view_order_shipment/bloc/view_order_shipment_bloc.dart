
/*
 *


 *
 * /
 */

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/screens/view_order_shipment/bloc/view_order_shipment_event.dart';
import 'package:test_new/unvells/screens/view_order_shipment/bloc/view_order_shipment_repository.dart';
import 'package:test_new/unvells/screens/view_order_shipment/bloc/view_order_shipment_state.dart';

class ViewOrderShipmentBloc extends Bloc<ViewOrderShipmentEvent, ViewOrderShipmentState> {
  ViewOrderShipmentScreenRepositoryImp? repository;

  ViewOrderShipmentBloc({this.repository}) : super(ViewOrderShipmentInitial()) {
    on<ViewOrderShipmentEvent>(mapEventToState);
  }

  void mapEventToState(
      ViewOrderShipmentEvent event, Emitter<ViewOrderShipmentState> emit) async {
    if (event is ViewOrderShipmentDetailFetchEvent) {
      emit(ViewOrderShipmentInitial());
      try {
        var model = await repository?.getShipmentView(event.viewOrderShipmentItemsId);
        if (model != null) {
          emit(ViewOrderShipmentSuccess(model));
        } else {
          emit(const ViewOrderShipmentError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(ViewOrderShipmentError(error.toString()));
      }
    }
  }
}
