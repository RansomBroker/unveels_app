/*
 *
  

 *
 * /
 */

import 'package:equatable/equatable.dart';

abstract class ReviewsScreenEvent extends Equatable{
  const ReviewsScreenEvent();

  @override
  List<Object> get props => [];
}

class ReviewsScreenDataFetchEvent extends ReviewsScreenEvent{
  final int page;
  final bool isFromDashboard;
  const ReviewsScreenDataFetchEvent(this.page, this.isFromDashboard);
}
