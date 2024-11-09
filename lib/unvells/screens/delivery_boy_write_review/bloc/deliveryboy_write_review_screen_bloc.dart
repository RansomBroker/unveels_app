/*
 *


 *
 * /
 */

import 'package:flutter_bloc/flutter_bloc.dart';

import 'deliveryboy_write_review_screen_event.dart';
import 'deliveryboy_write_review_screen_repository.dart';
import 'deliveryboy_write_review_screen_state.dart';

class DeliveryboyReviewReviewScreenBloc extends Bloc<DeliveryboyWriteReviewEvent, DeliveryboyWriteReviewScreenState>{
  DeliveryboyWriteReviewRepositoryImp? repository;

  DeliveryboyReviewReviewScreenBloc({this.repository}) : super(DeliveryboyWriteEmptyState()) {
    on<DeliveryboyWriteReviewEvent>(mapEventToState);
  }

  void mapEventToState(
      DeliveryboyWriteReviewEvent event, Emitter<DeliveryboyWriteReviewScreenState> emit) async {
        if (event is AddReviewSaveEvent) {
          emit(DeliveryboyWriteLoadingState());
          try {
            var model = await repository?.getAddReview(event.rating, event.customerId, event.title, event.comment, event.deliveryboyId, event.orderId, event.nickName);
            if (model != null) {
              emit(GetAddReviewSuccessState(model));
            } else {
              emit(DeliveryboyWriteErrorState(model?.message??''));
            }
          } catch (error, _) {
            print(error.toString());
            emit(DeliveryboyWriteErrorState(error.toString()));
          }
        }
  }
}