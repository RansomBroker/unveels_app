/*
 *


 *
 * /
 */

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/screens/refund_screen/bloc/refund_screen_events.dart';
import 'package:test_new/unvells/screens/refund_screen/bloc/refund_screen_repository.dart';
import 'package:test_new/unvells/screens/refund_screen/bloc/refund_screen_state.dart';




class RefundScreenBloc extends Bloc<RefundScreenEvent, RefundScreenState> {
  RefundScreenRepositoryImp? repository;

  RefundScreenBloc({this.repository}) : super(RefundScreenInitial()) {
    on<RefundScreenEvent>(mapEventToState);
  }

  void mapEventToState(
      RefundScreenEvent event, Emitter<RefundScreenState> emit) async {
    if (event is RefundScreenDataFetchEvent) {
      emit(RefundScreenInitial());
      try {
        var model = await repository?.getInvoiceList(event.page);
        if (model != null) {
          emit(RefundScreenSuccess(model));
        } else {
          emit(const RefundScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(RefundScreenError(error.toString()));
      }
    }
  }
}
