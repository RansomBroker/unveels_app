/*
 *
  

 *
 * /
 */

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/screens/order_shipment/bloc/order_shipment_screen_events.dart';
import 'package:test_new/unvells/screens/order_shipment/bloc/order_shipment_screen_repository.dart';
import 'package:test_new/unvells/screens/order_shipment/bloc/order_shipment_screen_state.dart';




class OrderShipmentScreenBloc extends Bloc<OrderShipmentScreenEvent, OrderShipmentScreenState> {
  OrderShipmentScreenRepositoryImp? repository;

  OrderShipmentScreenBloc({this.repository}) : super(OrderShipmentScreenInitial()) {
    on<OrderShipmentScreenEvent>(mapEventToState);
  }

  void mapEventToState(
      OrderShipmentScreenEvent event, Emitter<OrderShipmentScreenState> emit) async {
    if (event is OrderShipmentTrackFetchEvent) {
      emit(OrderShipmentScreenInitial());
      try {
        var model = await repository?.getShipmentView(event.viewOrderShipmentItemsId);
        if (model != null) {
          emit(OrderShipmentTrackSuccess(model));
        } else {
          emit(const OrderShipmentScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(OrderShipmentScreenError(error.toString()));
      }
    }
  }
}
