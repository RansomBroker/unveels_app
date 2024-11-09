/*
 *


 *
 * /
 */

import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_review_screen_event.dart';
import 'add_review_screen_repository.dart';
import 'add_review_screen_state.dart';

class AddReviewScreenBloc extends Bloc<AddReviewEvent, AddReviewScreenState>{
  AddReviewRepositoryImp? repository;

  AddReviewScreenBloc({this.repository}) : super(AddReviewLoadingState()) {
    on<AddReviewEvent>(mapEventToState);
  }

  void mapEventToState(
      AddReviewEvent event, Emitter<AddReviewScreenState> emit) async {
    if (event is GetRatingFormDataEvent) {
      emit(AddReviewLoadingState());
      try {
        var model = await repository?.getRatingFormData();
        if (model != null) {
          emit(GetRatingFormDataSuccessState(model));
        } else {
          emit(AddReviewErrorState(model?.message??''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(AddReviewErrorState(error.toString()));
      }
    } else if (event is AddReviewSaveEvent) {
      emit(AddReviewLoadingState());
      try {
        var model = await repository?.addReview(event.rating, event.nickName, event.summary, event.review, event.productId, event.ratingData );
        if (model != null) {
          emit(AddReviewSuccessState(model));
        } else {
          emit(const AddReviewErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(AddReviewErrorState(error.toString()));
      }
    }
  }
}