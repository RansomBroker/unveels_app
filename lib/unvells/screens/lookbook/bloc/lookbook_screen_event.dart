/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';

import '../../../models/catalog/request/catalog_product_request.dart';
import '../../../models/lookBook/look_book_model.dart';

abstract class LookbookScreenEvent extends Equatable {}



class LoadingEvent extends LookbookScreenEvent {
  LoadingEvent();

  @override
  List<Object?> get props => [];
}

class FetchLookBookEvent extends LookbookScreenEvent {
  FetchLookBookEvent();


  @override
  List<Object> get props => [];
}

