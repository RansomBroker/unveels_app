/*
 *


 *
 * /
 */

import 'package:flutter_bloc/flutter_bloc.dart';

import 'downloadable_products_screen_events.dart';
import 'downloadable_products_screen_repository.dart';
import 'downloadable_products_screen_state.dart';

class DownloadableProductsScreenBloc extends Bloc<DownloadableProductsScreenEvent, DownloadableProductsScreenState> {
  DownloadableProductsScreenRepositoryImp? repository;

  DownloadableProductsScreenBloc({this.repository}) : super(DownloadableProductsScreenInitial()) {
    on<DownloadableProductsScreenEvent>(mapEventToState);
  }

  void mapEventToState(
      DownloadableProductsScreenEvent event, Emitter<DownloadableProductsScreenState> emit) async {
    if (event is DownloadableProductsScreenDataFetchEvent) {
      // emit(DownloadableProductsScreenInitial());
      try {
        var model = await repository?.getDownloadableProductsList(event.page);
        if (model != null) {
          emit(DownloadableProductsScreenSuccess(model));
        } else {
          emit(const DownloadableProductsScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(DownloadableProductsScreenError(error.toString()));
      }
    } else if (event is DownloadProductEvent) {
      emit(DownloadableProductsScreenInitial());
      try {
        var model = await repository?.downloadProduct(event.itemHash);
        if (model != null) {
          emit(DownloadProductSuccess(model));
        } else {
          emit(const DownloadableProductsScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(DownloadableProductsScreenError(error.toString()));
      }
    }
  }
}
