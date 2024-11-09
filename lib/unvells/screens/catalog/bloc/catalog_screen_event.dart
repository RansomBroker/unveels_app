/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';

import '../../../models/catalog/request/catalog_product_request.dart';

abstract class CatalogScreenEvent extends Equatable {}

class ChangeViewEvent extends CatalogScreenEvent {
  final bool isGrid;

  ChangeViewEvent(this.isGrid);

  @override
  List<Object> get props => [];
}

class LoadingEvent extends CatalogScreenEvent {
  LoadingEvent();

  @override
  List<Object?> get props => [];
}

class FetchCatalogEvent extends CatalogScreenEvent {
  FetchCatalogEvent(this.request);

  final CatalogProductRequest request;

  @override
  List<Object> get props => [request];
}

