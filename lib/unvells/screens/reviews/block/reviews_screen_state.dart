/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';
import '../../../models/order_list/order_list_model.dart';
import '../../../models/reviews/reviews_list_model.dart';

abstract class ReviewsScreenState extends Equatable {
  const ReviewsScreenState();

  @override
  List<Object> get props => [];
}

class ReviewsScreenInitial extends ReviewsScreenState{}

class ReviewsScreenSuccess extends ReviewsScreenState{
  final ReviewsListModel reviews;
  const ReviewsScreenSuccess(this.reviews);
}

class ReviewsScreenError extends ReviewsScreenState{
  final String message;
  const ReviewsScreenError(this.message);
}



