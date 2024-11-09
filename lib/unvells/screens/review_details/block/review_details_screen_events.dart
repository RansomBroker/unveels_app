/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';

abstract class ReviewDetailsScreenEvent extends Equatable{
  const ReviewDetailsScreenEvent();

  @override
  List<Object> get props => [];
}

class ReviewDetailsScreenDataFetchEvent extends ReviewDetailsScreenEvent{
  final String id;
  const ReviewDetailsScreenDataFetchEvent(this.id);
}
