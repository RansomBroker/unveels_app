/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';
import '../../../models/reviews/review_details_model.dart';
import '../../../models/reviews/reviews_list_model.dart';

abstract class ReviewDetailsScreenState extends Equatable {
  const ReviewDetailsScreenState();

  @override
  List<Object> get props => [];
}

class ReviewDetailsScreenInitial extends ReviewDetailsScreenState{}

class ReviewDetailsScreenSuccess extends ReviewDetailsScreenState{
  final ReviewDetailsModel reviews;
  const ReviewDetailsScreenSuccess(this.reviews);
}

class ReviewDetailsScreenError extends ReviewDetailsScreenState{
  final String message;
  const ReviewDetailsScreenError(this.message);
}



