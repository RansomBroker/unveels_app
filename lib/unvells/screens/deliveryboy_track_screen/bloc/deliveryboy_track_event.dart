/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';

abstract class DeliveryboyTrackEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class DeliveryboyPlaceSearchFetchEvent extends DeliveryboyTrackEvent {
  final String query;
  DeliveryboyPlaceSearchFetchEvent(this.query);
}

class DeliveryBoyLocationDetailsFetchEvent extends DeliveryboyTrackEvent{
  int deliveryboyId;
  DeliveryBoyLocationDetailsFetchEvent(this.deliveryboyId);
}

class SearchPlaceInitialEvent extends DeliveryboyTrackEvent{}

class SearchPlaceEvent extends DeliveryboyTrackEvent{
  final String query;
  SearchPlaceEvent(this.query);
}

