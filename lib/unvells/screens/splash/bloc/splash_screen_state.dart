/*
 *


 *
 * /
 */

part of 'splash_screen_bloc.dart';


abstract class SplashScreenState extends Equatable{
  const SplashScreenState();

  @override
  List<Object> get props => [];
}

class SplashScreenInitial extends SplashScreenState{

}

class SplashScreenSuccess extends SplashScreenState{
  HomePageData? homePageData;
  SplashScreenSuccess(this.homePageData);

  @override
  List<Object> get props => [];
}

class WalkThroughDataSuccess extends SplashScreenState{
  final WalkThroughModel model;
  const WalkThroughDataSuccess(this.model);
}

class SplashScreenError extends SplashScreenState {
  SplashScreenError(this._message);

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

class WalkThroughDataError extends SplashScreenState{
  final String message;
  const WalkThroughDataError(this.message);
}