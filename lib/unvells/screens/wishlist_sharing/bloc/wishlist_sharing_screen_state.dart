
/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';
import 'package:test_new/unvells/models/base_model.dart';

abstract class WishlistSharingState extends Equatable {
  const WishlistSharingState();

  @override
  List<Object?> get props => [];

}
class WishlistSharingInitialState extends WishlistSharingState{}

class WishlistSharingLoadingState extends WishlistSharingState{}

class WishlistSharingSuccessState extends WishlistSharingState {
  const WishlistSharingSuccessState(this.data);

  final BaseModel data;


  @override
  List<Object> get props => [data];
}


class WishlistSharingErrorState extends WishlistSharingState{
  final String message;
  const WishlistSharingErrorState(this.message);
}

class CompleteState extends WishlistSharingState{}
