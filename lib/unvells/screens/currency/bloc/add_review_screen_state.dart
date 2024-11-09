/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';

import '../../../models/base_model.dart';

abstract class AddReviewScreenState extends Equatable {
  const AddReviewScreenState();

  @override
  List<Object> get props => [];
}

class AddReviewInitialState extends AddReviewScreenState{}

class AddReviewLoadingState extends AddReviewScreenState{}

class AddReviewSuccessState extends AddReviewScreenState{
  final BaseModel data;
  const AddReviewSuccessState(this.data);
}

class AddReviewErrorState extends AddReviewScreenState{
  final String message;
  const AddReviewErrorState(this.message);
}


