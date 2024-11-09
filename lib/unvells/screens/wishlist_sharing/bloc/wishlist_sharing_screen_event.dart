

/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';

abstract class WishlistSharingEvent extends Equatable {
  const WishlistSharingEvent();

  @override
  List<Object> get props => [];
}

class WishListSharingSubmitEvent extends WishlistSharingEvent {
  const WishListSharingSubmitEvent(this.email, this.message);

  final String email;
  final String message;

  @override
  List<Object> get props => [email, message];
}

class WishListAddAllCartEvent extends WishlistSharingEvent {
  const WishListAddAllCartEvent(this.itemData);

  final String itemData;

  @override
  List<Object> get props => [itemData];
}