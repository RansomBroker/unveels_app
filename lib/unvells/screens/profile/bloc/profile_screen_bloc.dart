/*
 *


 *
 * /
 */

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/screens/profile/bloc/profile_screen_events.dart';
import 'package:test_new/unvells/screens/profile/bloc/profile_screen_repository.dart';
import 'package:test_new/unvells/screens/profile/bloc/profile_screen_state.dart';

class ProfileScreenBloc extends Bloc<ProfileScreenEvent,ProfileScreenState>{
  ProfileScreenRepository? repository;

  ProfileScreenBloc({this.repository}) : super(ProfileScreenInitial()){
    on<ProfileScreenEvent>(mapEventToState);
  }

  @override
  void mapEventToState(ProfileScreenEvent event, Emitter<ProfileScreenState> emit ) async{
    if (event is LogOutDataFetchEvent) {
      emit(LoadingState());
      try {
        var model = await repository?.logOut();
        if (model != null) {
          emit( LogOutSuccess(model));
        } else {
          emit(ProfileScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(ProfileScreenError(error.toString()));
      }
    }else if(event is AddImageEvent){
      emit(LoadingState());
      try {
        var model = await repository?.setImage(event.image, event.type);
        if (model != null) {
          emit( AddImageState(model));
        } else {
          emit(ProfileScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(ProfileScreenError(error.toString()));
      }
    }
  }
}