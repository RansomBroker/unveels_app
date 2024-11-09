/*
 *
  

 *
 * /
 */

import 'package:equatable/equatable.dart';
import 'package:test_new/unvells/models/order_details/order_detail_model.dart';

import '../../../models/shipment_view/shipment_view_model.dart';

abstract class OrderShipmentScreenState extends Equatable {
  const OrderShipmentScreenState();

  @override
  List<Object> get props => [];
}

class OrderShipmentScreenInitial extends OrderShipmentScreenState{}

class OrderShipmentScreenSuccess extends OrderShipmentScreenState{
  final ShipmentListData shipmentListData;
  const OrderShipmentScreenSuccess(this.shipmentListData);
}

class OrderShipmentScreenError extends OrderShipmentScreenState{
  final String message;
  const OrderShipmentScreenError(this.message);
}

class OrderShipmentTrackSuccess extends OrderShipmentScreenState{
  final ShipmentViewModel shipmentViewModel;
  const OrderShipmentTrackSuccess(this.shipmentViewModel);
}



