/*
 *
  

 *
 * /
 */

import 'package:equatable/equatable.dart';

abstract class ViewOrderShipmentEvent extends Equatable{
  const ViewOrderShipmentEvent();

  @override
  List<Object> get props => [];
}

class ViewOrderShipmentFetchEvent extends ViewOrderShipmentEvent{
  const ViewOrderShipmentFetchEvent();
}

class ViewOrderShipmentDetailFetchEvent extends ViewOrderShipmentEvent{
  final String viewOrderShipmentItemsId;
  const ViewOrderShipmentDetailFetchEvent(this.viewOrderShipmentItemsId);
}

