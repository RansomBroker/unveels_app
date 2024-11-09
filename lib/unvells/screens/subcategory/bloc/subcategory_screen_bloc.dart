

/*
 *


 *
 * /
 */

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/screens/subcategory/bloc/subcategory_screen_events.dart';
import 'package:test_new/unvells/screens/subcategory/bloc/subcategory_screen_repository.dart';
import 'package:test_new/unvells/screens/subcategory/bloc/subcategory_screen_state.dart';

class SubCategoryScreenBloc extends Bloc<SubCategoryScreenEvent, SubCategoryScreenState> {
  SubCategoryScreenRepository? repository;

  SubCategoryScreenBloc({this.repository}) : super(SubCategoryScreenInitial()) {
    on<SubCategoryScreenEvent>(mapEventToState);
  }

  void mapEventToState(SubCategoryScreenEvent event, Emitter<SubCategoryScreenState> emit) async {
    if (event is SubCategoryScreenDataFetchEvent) {
      emit(SubCategoryScreenInitial());
      try {
        var model = await repository?.getCategoryData(event.categoryId);
        if (model != null) {
          emit( SubCategoryScreenSuccess(model));
        } else {
          emit(SubCategoryScreenError(''));
        }
      } catch (error, stack) {
        print(stack.toString());
        emit(SubCategoryScreenError(error.toString()));
      }
    }
  }
}