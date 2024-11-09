
/*
 *
  

 *
 * /
 */

part of 'order_detail_screen_bloc.dart';

abstract class OrderDetailEvent extends Equatable{
  const OrderDetailEvent();

  @override
  List<Object> get props => [];
}

class OrderDetailFetchEvent extends OrderDetailEvent{
  String orderId;
OrderDetailFetchEvent(this.orderId);
}

class DeliveryBoyDetailsFetchEvent extends OrderDetailEvent{
  String orderId;
  DeliveryBoyDetailsFetchEvent(this.orderId);
}

class ReorderEvent extends OrderDetailEvent{
  final String incrementId;
  const ReorderEvent(this.incrementId);
}
