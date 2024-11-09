/*
 *
  

 *
 * /
 */

import 'package:equatable/equatable.dart';

import '../../../models/lookBook/look_book_model.dart';

abstract class LookBookState extends Equatable {}

enum LookBookStatus { success, fail }

class OnClickLoaderLookBookState extends LookBookState {
  final bool? isReqToShowLoader;

  OnClickLoaderLookBookState({this.isReqToShowLoader});

  @override
  List<Object> get props => [isReqToShowLoader!];
}



class LookBookFetchState extends LookBookState {
  final List<LookBookCategories>? model;

  LookBookFetchState(this.model);

  @override
  List<Object?> get props => [model];
}

class LookBookErrorState extends LookBookState {
  LookBookErrorState(this._message);

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

class LookBookInitialState extends LookBookState {
  @override
  List<Object> get props => [];
}
