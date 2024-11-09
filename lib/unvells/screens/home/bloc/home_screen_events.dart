
/*
 *
  

 *
 * /
 */

import 'package:equatable/equatable.dart';

abstract class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();

  @override
  List<Object> get props => [];
}

class HomeScreenDataFetchEvent extends HomeScreenEvent {

  final bool isRefresh;
  const HomeScreenDataFetchEvent(this.isRefresh);


  @override
  List<Object> get props => [];
}
class CartCountFetchEvent extends HomeScreenEvent {
  const CartCountFetchEvent();


  @override
  List<Object> get props => [];
}
