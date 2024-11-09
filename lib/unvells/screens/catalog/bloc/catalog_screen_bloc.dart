/*
 *


 *
 * /
 */

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'catalog_screen_event.dart';
import 'catalog_screen_repository.dart';
import 'catalog_screen_state.dart';

class CatalogScreenBloc extends Bloc<CatalogScreenEvent, CatalogScreenState> {
  CatalogRepository? repository;

  CatalogScreenBloc({this.repository}) : super(CatalogInitialState()) {
    on<CatalogScreenEvent>(mapEventToState);
  }

  void mapEventToState(
      CatalogScreenEvent event, Emitter<CatalogScreenState> emit) async {
    if (event is FetchCatalogEvent) {
      emit(CatalogInitialState());
      var model = await repository?.getCatalogProducts(event.request);
      try {
        log("CatalogFetchState" );

        if (model != null) {
          emit(CatalogFetchState(model));
        } else {
          emit(CatalogErrorState(''));
        }
      } catch (error, _) {
        log("CatalogErrorState${error.toString()}" );
        emit(CatalogErrorState(error.toString()));
      }
    }  else if (event is LoadingEvent) {
      emit(CatalogInitialState());
    } else if (event is ChangeViewEvent) {
      emit(ChangeViewState(event.isGrid));
    }
  }
}
