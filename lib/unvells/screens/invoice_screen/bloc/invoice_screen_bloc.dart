/*
 *


 *
 * /
 */

import 'package:flutter_bloc/flutter_bloc.dart';

import 'invoice_screen_events.dart';
import 'invoice_screen_repository.dart';
import 'invoice_screen_state.dart';



class InvoiceScreenBloc extends Bloc<InvoiceScreenEvent, InvoiceScreenState> {
  InvoiceScreenRepositoryImp? repository;

  InvoiceScreenBloc({this.repository}) : super(InvoiceScreenInitial()) {
    on<InvoiceScreenEvent>(mapEventToState);
  }

  void mapEventToState(
      InvoiceScreenEvent event, Emitter<InvoiceScreenState> emit) async {
    if (event is InvoiceScreenDataFetchEvent) {
      emit(InvoiceScreenInitial());
      try {
        var model = await repository?.getInvoiceList(event.page);
        if (model != null) {
          emit(InvoiceScreenSuccess(model));
        } else {
          emit(const InvoiceScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(InvoiceScreenError(error.toString()));
      }
    }
    if (event is PrintInvoiceDataEvent) {
      emit(InvoiceScreenInitial());
      try {
        var model = await repository?.printInvoice(event.invoiceId, event.increementId);
        if (model != null) {
          emit(PrintInvoiceSuccess(model));
        } else {
          emit(const InvoiceScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(InvoiceScreenError(error.toString()));
      }
    }

  }
}
