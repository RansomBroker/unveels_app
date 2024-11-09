/*
 *


 *
 * /
 */

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../order_details/bloc/order_detail_screen_bloc.dart';
import 'orders_and_returns_screen_events.dart';
import 'orders_and_returns_screen_repository.dart';
import 'orders_and_returns_screen_state.dart';


class OrdersAndReturnsBloc extends Bloc<OrdersAndReturnsEvent, OrdersAndReturnsState> {
  OrdersAndReturnsRepository? repository;

  OrdersAndReturnsBloc({this.repository}) : super(OrdersAndReturnsInitialState()) {
    on<OrdersAndReturnsEvent>(mapEventToState);
  }
  // String incrementId, String email, String lastName, String zipCode,String type
  void mapEventToState(
      OrdersAndReturnsEvent event, Emitter<OrdersAndReturnsState> emit) async {
    if(event is OrdersAndReturnsDetailsEvent){
      emit(OrdersAndReturnsLoadingState());
      try {
        var model = await repository?.getOrdersAndReturnsData(event.incrementId, event.email, event.lastName, event.zipCode, event.type);
        if ( model != null) {
          if (model.success??false){
            emit(OrdersAndReturnsSuccessState(model, event.incrementId, model.message ?? ""));
          }else{
            emit(OrdersAndReturnsErrorState(model.message??""));
          }
        } else {
          emit(const OrdersAndReturnsErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(OrdersAndReturnsErrorState(error.toString()));
      }
    }
  }
}