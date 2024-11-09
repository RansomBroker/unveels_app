
/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';

abstract class CategoryListingEvent extends Equatable {
  const CategoryListingEvent();

  @override
  List<Object> get props => [];
}

class CategoryListingDataFetchEvent extends CategoryListingEvent {
   int categoryId;
   CategoryListingDataFetchEvent(this.categoryId);
  @override
  List<Object> get props => [];
}