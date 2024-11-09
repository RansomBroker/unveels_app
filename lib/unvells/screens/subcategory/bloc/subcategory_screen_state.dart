
/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';

import '../../../models/categoryPage/category_page_response.dart';

abstract class SubCategoryScreenState extends Equatable {
  const SubCategoryScreenState();

  @override
  List<Object> get props => [];
}

class SubCategoryScreenInitial extends SubCategoryScreenState {

}

class SubCategoryScreenSuccess extends SubCategoryScreenState {

  CategoryPageResponse categoryPageResponse;
  SubCategoryScreenSuccess(this.categoryPageResponse);
  @override
  List<Object> get props => [];
}

class SubCategoryScreenError extends SubCategoryScreenState {
  SubCategoryScreenError(this.message);
  String? message;

  @override
  List<Object> get props => [];
}