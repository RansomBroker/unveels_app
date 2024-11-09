/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';


abstract class LanguageScreenState extends Equatable {
  const LanguageScreenState();

  @override
  List<Object> get props => [];
}

class LanguageInitialState extends LanguageScreenState{}

class LanguageLoadingState extends LanguageScreenState{}

class LanguageSuccessState extends LanguageScreenState{
}

class LanguageErrorState extends LanguageScreenState{
  final String message;
  const LanguageErrorState(this.message);

  @override
  List<Object> get props => [];
}


