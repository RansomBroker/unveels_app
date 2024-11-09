
/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';

abstract class OrdersAndReturnsEvent extends Equatable {
  const OrdersAndReturnsEvent();

  @override
  List<Object> get props => [];
}

class OrdersAndReturnsDetailsEvent extends OrdersAndReturnsEvent{
  String incrementId;
  String email;
  String lastName;
  String zipCode;
  String type;
  OrdersAndReturnsDetailsEvent(this.incrementId, this.email, this.lastName, this.zipCode, this.type);
}