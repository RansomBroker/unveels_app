/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';
import 'package:test_new/unvells/models/base_model.dart';
import '../../../models/order_details/order_detail_model.dart';
import '../../../models/order_list/order_list_model.dart';

abstract class OrderScreenState extends Equatable {
  const OrderScreenState();

  @override
  List<Object> get props => [];
}

class OrderScreenInitial extends OrderScreenState{}

class OrderScreenSuccess extends OrderScreenState{
  final OrderListModel orders;
  const OrderScreenSuccess(this.orders);
}
class ReorderSuccess extends OrderScreenState{
  final BaseModel response;
  const ReorderSuccess(this.response);
}

class OrderScreenError extends OrderScreenState{
  final String message;
  const OrderScreenError(this.message);
}

class ReviewProduct extends OrderScreenState{
  OrderDetailModel? model;
  ReviewProduct(this.model);
  @override
  List<Object> get props => [];
}

class OrderScreenEmptyState extends OrderScreenState{

}


