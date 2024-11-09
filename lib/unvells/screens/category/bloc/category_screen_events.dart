
/*
 *
  

 *
 * /
 */

import 'package:equatable/equatable.dart';

abstract class CategoryScreenEvent extends Equatable {
  const CategoryScreenEvent();

  @override
  List<Object> get props => [];
}

class CategoryScreenDataFetchEvent extends CategoryScreenEvent {
   int categoryId;
   CategoryScreenDataFetchEvent(this.categoryId);
  @override
  List<Object> get props => [];
}