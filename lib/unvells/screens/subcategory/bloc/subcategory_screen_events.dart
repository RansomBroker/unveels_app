
/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';

abstract class SubCategoryScreenEvent extends Equatable {
  const SubCategoryScreenEvent();

  @override
  List<Object> get props => [];
}

class SubCategoryScreenDataFetchEvent extends SubCategoryScreenEvent {
  int categoryId;
  SubCategoryScreenDataFetchEvent(this.categoryId);


  @override
  List<Object> get props => [];
}