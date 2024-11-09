/*
 *
  

 *
 * /
 */

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/screens/settings/bloc/settings_screen_event.dart';
import 'package:test_new/unvells/screens/settings/bloc/settings_screen_repository.dart';
import 'package:test_new/unvells/screens/settings/bloc/settings_screen_state.dart';
import 'package:test_new/unvells/screens/wishlist/bloc/wishlist_screen_event.dart';
import 'package:test_new/unvells/screens/wishlist/bloc/wishlist_screen_repository.dart';
import 'package:test_new/unvells/screens/wishlist/bloc/wishlist_screen_state.dart';

class SettingsScreenBloc extends Bloc<SettingsScreenEvent,SettingsScreenState>{
  SettingsScreenRepository? repository;

  SettingsScreenBloc({this.repository}) : super(SettingsScreenInitialState()){
    on<SettingsScreenEvent>(mapEventToState);
  }


  void mapEventToState(
      SettingsScreenEvent event,
      Emitter<SettingsScreenState> emit,
      ) async {

  }
}