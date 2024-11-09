/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';

import '../../../models/base_model.dart';
import '../../../models/reviews/rating_form_data_model.dart';

abstract class AddReviewScreenState {
  const AddReviewScreenState();

  @override
  List<Object> get props => [];
}


class AddReviewLoadingState extends AddReviewScreenState{}

class AddReviewSuccessState extends AddReviewScreenState{
  final BaseModel data;
  const AddReviewSuccessState(this.data);
}

class GetRatingFormDataSuccessState extends AddReviewScreenState{
  final RatingFormDataModel data;
  const GetRatingFormDataSuccessState(this.data);
}

class AddReviewErrorState extends AddReviewScreenState{
  final String message;
  const AddReviewErrorState(this.message);
}


