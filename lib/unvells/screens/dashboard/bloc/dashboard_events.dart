/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable{
  const DashboardEvent();
  @override
  List<Object> get props => [];
}

class DashboardAddressFetchEvent extends DashboardEvent{}

class AddImageEvent extends DashboardEvent{
  final String image;
  final String type;
  const AddImageEvent(this.image,this.type);
}






