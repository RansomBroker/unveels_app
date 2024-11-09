/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';

import '../../../models/shipment_view/shipment_view_model.dart';

abstract class ViewOrderTrackState extends Equatable{
  const ViewOrderTrackState();

  @override
  List<Object> get props => [];
}


class ViewOrderTrackInitial extends ViewOrderTrackState{}

class ViewOrderTrackSuccess extends ViewOrderTrackState{
  final ShipmentViewModel shipmentViewModel;
  const ViewOrderTrackSuccess(this.shipmentViewModel);
}

class ViewOrderTrackError extends ViewOrderTrackState{
  final String message;
  const ViewOrderTrackError(this.message);
}

