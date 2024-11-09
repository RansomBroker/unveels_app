/*
 *
  

 *
 * /
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'order_screen_events.dart';
import 'order_screen_repository.dart';
import 'order_screen_state.dart';

class OrderScreenBloc extends Bloc<OrderScreenEvent, OrderScreenState> {
  OrderScreenRepositoryImp? repository;

  OrderScreenBloc({this.repository}) : super(OrderScreenInitial()) {
    on<OrderScreenEvent>(mapEventToState);
  }

  void mapEventToState(
      OrderScreenEvent event, Emitter<OrderScreenState> emit) async {
    if (event is OrderScreenDataFetchEvent) {
      emit(OrderScreenInitial());
      try {
        var model = await repository?.getOrderList(event.page, event.isFromDashboard);
        if (model != null) {
          emit(OrderScreenSuccess(model));
        } else {
          emit(OrderScreenError(model?.message.toString()??''));
        }
      } catch (error, _) {

        print(error.toString());
        emit(OrderScreenError(error.toString()));
      }
    }else if(event is ReorderEvent) {
      try {
        emit(OrderScreenInitial());
        var model = await repository?.reorder(event.incrementId);
        if (model != null) {
          if (model.success == true) {
            emit(ReorderSuccess(model));
          } else {

            emit(OrderScreenError(model.message.toString()));
          }
        }
      } catch (error, _) {
        print(error.toString());
        emit(OrderScreenError(error.toString()));
      }
    }else if (event is ReviewProductEvent) {
      try {
        var model = await repository?.getOrderDetails(event.orderId);
        if (model != null) {
          emit(ReviewProduct(model));
        } else {
          emit(OrderScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(OrderScreenError(error.toString()));
      }
    }
  }
}
