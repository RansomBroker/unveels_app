/*
 *
  

 *
 * /
 */

part of 'splash_screen_bloc.dart';

abstract class SplashScreenEvent extends Equatable{
  const SplashScreenEvent();

  @override
  List<Object> get props => [];
}

class SplashScreenDataFetchEvent extends SplashScreenEvent{

  const SplashScreenDataFetchEvent();

  @override
  List<Object> get props => [];

}

class WalkThroughDataFetchEvent extends SplashScreenEvent{
  const WalkThroughDataFetchEvent();
}