/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';
import 'package:test_new/unvells/models/base_model.dart';
import '../../../models/DeliveryboyLocationDetails/deliveryboy_location_details_model.dart';
import '../../../models/google_place_model.dart';

abstract class DeliveryboyTrackState extends Equatable{
  @override
  List<Object> get props => [];
}
class DeliveryboyTrackInitialState extends DeliveryboyTrackState{}
class DeliveryboyTrackLoadingState extends DeliveryboyTrackState{}

class DeliveryboySearchPlaceSuccessState extends DeliveryboyTrackState{
  final GooglePlaceModel data;
  DeliveryboySearchPlaceSuccessState(this.data);
}

class DeliveryboyLocationSuccessState extends DeliveryboyTrackState{
  final DeliveryBoyLocationDetailsModel deliveryBoyLocationDetailsModel;
  DeliveryboyLocationSuccessState(this.deliveryBoyLocationDetailsModel);
}

class DeliveryboyErrorState extends DeliveryboyTrackState{
  final String message;
  DeliveryboyErrorState(this.message);
}

class CompleteState extends DeliveryboyTrackState{}
