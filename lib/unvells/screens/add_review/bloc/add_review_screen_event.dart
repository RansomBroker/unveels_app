/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';
abstract class AddReviewEvent extends Equatable{
  const AddReviewEvent();
  @override
  List<Object> get props => [];
}


class GetRatingFormDataEvent extends AddReviewEvent{
  GetRatingFormDataEvent();
}

class AddReviewSaveEvent extends AddReviewEvent{
  final int rating;
  final String nickName;
  final String summary;
  final String review;
  final String productId;
  List<Map<String, String>> ratingData;

  AddReviewSaveEvent(this.rating,this.nickName,this.summary,this.review,this.productId, this.ratingData);
}