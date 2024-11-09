

/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/screens/splash/bloc/splash_screen_repository.dart';

import '../../../constants/app_string_constant.dart';
import '../../../models/homePage/home_screen_model.dart';
import '../../../models/walk_through/walk_through_model.dart';



part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent,SplashScreenState>{
  SplashScreenRepository? splashScreenRepository;

  SplashScreenBloc({this.splashScreenRepository}) : super(SplashScreenInitial()){
    on<SplashScreenEvent>(mapEventToState);
  }

  @override
  void mapEventToState(
      SplashScreenEvent event, Emitter<SplashScreenState> emit) async {
    if (event is SplashScreenDataFetchEvent) {
      try {
        var model = await splashScreenRepository?.getSplashData();
        if (model != null) {
          if (model.success == true) {
            emit( SplashScreenSuccess(model));
          } else {
            emit(SplashScreenError(''));
          }
        } else {
          emit(SplashScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(SplashScreenError(error.toString()));
      }
    } else if (event is WalkThroughDataFetchEvent) {
      emit(SplashScreenInitial());
      try {
        var model = await splashScreenRepository?.getWalkThroughData();
        if (model != null) {
          if (model.success??false) {
            emit(WalkThroughDataSuccess(model));
          } else {
            emit(WalkThroughDataError(AppStringConstant.somethingWentWrong));
          }
        } else {
          emit(WalkThroughDataError(AppStringConstant.somethingWentWrong));
        }
      } catch (error, _) {
        print(error.toString());
        emit(WalkThroughDataError(error.toString()));
      }
    }
  }



}