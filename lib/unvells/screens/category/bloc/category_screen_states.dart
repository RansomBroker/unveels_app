
/*
 *
  

 *
 * /
 */

import 'package:equatable/equatable.dart';

import '../../../models/categoryPage/category_page_response.dart';

abstract class CategoryScreenState extends Equatable {
  const CategoryScreenState();

  @override
  List<Object> get props => [];
}

class CategoryScreenInitial extends CategoryScreenState {

}

class CategoryScreenSuccess extends CategoryScreenState {

  CategoryPageResponse categoryPageResponse;
  CategoryScreenSuccess(this.categoryPageResponse);
  @override
  List<Object> get props => [];
}

class CategoryScreenError extends CategoryScreenState {
  CategoryScreenError(this.message);
  String? message;

  @override
  List<Object> get props => [];
}