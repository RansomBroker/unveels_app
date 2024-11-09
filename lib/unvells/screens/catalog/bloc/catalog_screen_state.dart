/*
 *
  

 *
 * /
 */

import 'package:equatable/equatable.dart';

import '../../../models/catalog/catalog_model.dart';

abstract class CatalogScreenState extends Equatable {}

enum CatalogStatus { success, fail }

class OnClickLoaderCatalogState extends CatalogScreenState {
  final bool? isReqToShowLoader;

  OnClickLoaderCatalogState({this.isReqToShowLoader});

  @override
  List<Object> get props => [isReqToShowLoader!];
}

class ChangeViewState extends CatalogScreenState {
  final bool isGrid;

  ChangeViewState(this.isGrid);

  @override
  List<Object> get props => [isGrid];
}

class CatalogFetchState extends CatalogScreenState {
  final CatalogModel model;

  CatalogFetchState(this.model);

  @override
  List<Object?> get props => [model];
}

class CatalogErrorState extends CatalogScreenState {
  CatalogErrorState(this._message);

  String? _message;

  // ignore: unnecessary_getters_setters
  String? get message => _message;

  // ignore: unnecessary_getters_setters
  set message(String? message) {
    _message = message;
  }

  @override
  List<Object> get props => [];
}

class CatalogInitialState extends CatalogScreenState {
  @override
  List<Object> get props => [];
}
