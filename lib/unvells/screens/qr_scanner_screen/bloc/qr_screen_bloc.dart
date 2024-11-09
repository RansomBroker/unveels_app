

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/screens/qr_scanner_screen/bloc/qr_screen_events.dart';
import 'package:test_new/unvells/screens/qr_scanner_screen/bloc/qr_screen_repository.dart';
import 'package:test_new/unvells/screens/qr_scanner_screen/bloc/qr_screen_state.dart';

class QrScreenBloc extends Bloc<QrScreenEvent, QrScreenState> {
  QrScreenRepositoryImp? repository;

  QrScreenBloc({this.repository}) : super(QrScreenInitial()) {
    on<QrScreenEvent>(mapEventToState);
  }

  void mapEventToState(
      QrScreenEvent event, Emitter<QrScreenState> emit) async {
    if (event is QrScreenSuccess) {
      emit(QrScreenSuccess());
    }else if(event is QrScanSuccessEvent) {
      try {
        emit(QrScreenInitial());
        var model = await repository?.qrScan(event.barCodeData);
        if (model != null) {
          if (model.success == true) {
            emit(QrScanScreen(model));
          } else {
            emit(QrScreenError(model.message ?? ""));
          }
        }
      } catch (error, _) {
        print(error.toString());
        emit(QrScreenError(error.toString()));
      }
    }
  }
}
