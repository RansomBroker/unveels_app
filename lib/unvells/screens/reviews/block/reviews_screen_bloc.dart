/*
 *


 *
 * /
 */

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/screens/reviews/block/reviews_screen_events.dart';
import 'package:test_new/unvells/screens/reviews/block/reviews_screen_repository.dart';
import 'package:test_new/unvells/screens/reviews/block/reviews_screen_state.dart';

class ReviewsScreenBloc extends Bloc<ReviewsScreenEvent, ReviewsScreenState> {
  ReviewsScreenRepositoryImp? repository;

  ReviewsScreenBloc({this.repository}) : super(ReviewsScreenInitial()) {
    on<ReviewsScreenEvent>(mapEventToState);
  }

  void mapEventToState(
      ReviewsScreenEvent event, Emitter<ReviewsScreenState> emit) async {
    if (event is ReviewsScreenDataFetchEvent) {
      emit(ReviewsScreenInitial());
      try {
        var model = await repository?.getReviewsList(event.page, event.isFromDashboard);
        if (model != null) {
          emit(ReviewsScreenSuccess(model));
        } else {
          emit(const ReviewsScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(ReviewsScreenError(error.toString()));
      }
    }
  }
}
