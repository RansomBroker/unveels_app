

/*
 *


 *
 * /
 */

import 'package:flutter_bloc/flutter_bloc.dart';

import 'wishlist_comment_screen_event.dart';
import 'wishlist_comment_screen_repository.dart';
import 'wishlist_comment_screen_state.dart';


class WishlistCommentScreenBloc extends Bloc<WishlistCommentScreenEvent, WishlistCommentScreenState> {
  WishlistCommentScreenRepository? repository;

  WishlistCommentScreenBloc({this.repository}) : super(WishlistCommentScreenInitialState()) {
    on<WishlistCommentScreenEvent>(mapEventToState);
  }

  void mapEventToState(
      WishlistCommentScreenEvent event,
      Emitter<WishlistCommentScreenState> emit,
      ) async {

  }
}