/*
 *
  

 *
 * /
 */

import 'package:equatable/equatable.dart';

abstract class ViewOrderTrackEvent extends Equatable{
  const ViewOrderTrackEvent();

  @override
  List<Object> get props => [];
}

class ViewOrderTrackDataEvent extends ViewOrderTrackEvent{
  const ViewOrderTrackDataEvent();
}

class ViewOrderTrackFetchEvent extends ViewOrderTrackEvent{
  final String viewOrderShipmentItemsId;
  const ViewOrderTrackFetchEvent(this.viewOrderShipmentItemsId);
}

