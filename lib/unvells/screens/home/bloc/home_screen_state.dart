
/*
 *
  

 *
 * /
 */

import 'package:equatable/equatable.dart';

import '../../../models/homePage/add_to_wishlist_response.dart';
import '../../../models/homePage/home_screen_model.dart';

abstract class HomeScreenState {
  const HomeScreenState();

  @override
  List<Object> get props => [];
}

class HomeScreenInitial extends HomeScreenState {}

class HomeScreenDataLoading extends HomeScreenState {}

class HomeScreenSuccess extends HomeScreenState {
  HomePageData homePageData;
  bool isRefresh;

   HomeScreenSuccess(this.homePageData, this.isRefresh);
  @override
  List<Object> get props => [];
}

class HomeScreenError extends HomeScreenState {
  HomeScreenError(this.message);
  String? message;

  @override
  List<Object> get props => [];
}

class ItemCardInitial extends HomeScreenState {}

//Error State
class ItemCardErrorState extends HomeScreenState {
  ItemCardErrorState(this._message);

  String? _message;

  String? get message => _message;

  set message(String? message) {
    _message = message;
  }

  @override
  List<Object> get props => [];
}

class CartCountSuccess extends HomeScreenState {
  HomePageData homePageData;

  CartCountSuccess(this.homePageData);
  @override
  List<Object> get props => [];
}

class OtherError extends HomeScreenState {
  OtherError(this.message);
  String? message;

  @override
  List<Object> get props => [];
}

class HomeScreenEmptyState extends HomeScreenState {}