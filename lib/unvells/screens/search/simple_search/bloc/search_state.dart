/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';
import 'package:test_new/unvells/models/search/search_screen_model.dart';

abstract class SearchState extends Equatable{
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitialState extends SearchState{}

class SearchScreenSuccess extends SearchState{
  final SearchScreenModel? searchSuggestionModel;

  const SearchScreenSuccess(this.searchSuggestionModel);
}


class SearchActionState extends SearchState{
}

class SearchEmptyState extends SearchState{
}

class SearchScreenError extends SearchState {
  const SearchScreenError(this.message);

 final String message;
}