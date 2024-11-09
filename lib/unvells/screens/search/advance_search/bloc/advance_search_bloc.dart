/*
 *


 *
 * /
 */

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/screens/search/advance_search/bloc/advance_search_events.dart';
import 'package:test_new/unvells/screens/search/advance_search/bloc/advance_search_repository.dart';
import 'package:test_new/unvells/screens/search/advance_search/bloc/advance_search_states.dart';

class AdvanceSearchScreenBloc extends Bloc<AdvanceSearchEvent,AdvanceSearchState>{
  AdvanceSearchRepository? repository;

  AdvanceSearchScreenBloc({this.repository}) : super(AdvanceSearchLoadingState()){
    on<AdvanceSearchEvent>(mapEventToState);
  }

  @override
  void mapEventToState(
      AdvanceSearchEvent event, Emitter<AdvanceSearchState> emit) async {
    if(event is InitialAdvanceSearchEvent){
      emit(AdvanceSearchLoadingState());
      try {
        var model = await repository?.getAdvanceSearchSuggestion('');
        if (model != null) {
          emit( AdvanceSearchScreenSuccess(model));
        } else {
          emit(const AdvanceSearchScreenError(''));
        }
      } catch (error, sT) {
        print(sT.toString());
        emit(AdvanceSearchScreenError(error.toString()));
      }
    }
  }
}