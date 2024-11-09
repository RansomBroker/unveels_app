/*
 *


 *
 * /
 */

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/lookBook/look_book_model.dart';
import 'lookbook_screen_event.dart';
import 'lookbook_screen_repository.dart';
import 'lookbook_screen_state.dart';

class LookbookScreenBloc extends Bloc<LookbookScreenEvent, LookBookState> {
  LookBookRepository? repository;

  LookbookScreenBloc({this.repository}) : super(LookBookInitialState()) {
    on<LookbookScreenEvent>(mapEventToState);
  }

  List<LookBookCategories>? model;
  void mapEventToState(
      LookbookScreenEvent event, Emitter<LookBookState> emit) async {
    if (event is FetchLookBookEvent) {
      emit(LookBookInitialState());
      var model = await repository?.getLookBookProducts();
      try {
        if (model != null) {

          this.model = model;

          emit(LookBookFetchState(model));
          log("message=>${model.first.title}");

        } else {
          emit(LookBookErrorState(''));
        }
      } catch (error, _) {
        emit(LookBookErrorState(error.toString()));
      }
    }  else if (event is LoadingEvent) {
      emit(LookBookInitialState());
    }
  }

}
