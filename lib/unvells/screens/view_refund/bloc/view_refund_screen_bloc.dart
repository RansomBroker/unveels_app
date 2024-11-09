
/*
 *


 *
 * /
 */

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/screens/view_refund/bloc/view_refund_event.dart';
import 'package:test_new/unvells/screens/view_refund/bloc/view_refund_screen_repository.dart';
import 'package:test_new/unvells/screens/view_refund/bloc/view_refund_screen_state.dart';



class ViewRefundBloc extends Bloc<ViewRefundEvent, ViewRefundState> {
  ViewRefundScreenRepositoryImp? repository;

  ViewRefundBloc({this.repository}) : super(ViewRefundInitial()) {
    on<ViewRefundDetailFetchEvent>(mapEventToState);
  }

  void mapEventToState(
      ViewRefundDetailFetchEvent event, Emitter<ViewRefundState> emit) async {
    if (event is ViewRefundDetailFetchEvent) {
      emit(ViewRefundInitial());
      try {
        var model = await repository?.getInvoiceView(event.viewRefundItemsId);
        if (model != null) {
          emit(ViewRefundSuccess(model));
        } else {
          emit(const ViewRefundError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(ViewRefundError(error.toString()));
      }
    }
  }
}
