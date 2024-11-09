/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';
import 'package:test_new/unvells/models/order_details/order_detail_model.dart';

abstract class RefundScreenState extends Equatable {
  const RefundScreenState();

  @override
  List<Object> get props => [];
}

class RefundScreenInitial extends RefundScreenState{}

class RefundScreenSuccess extends RefundScreenState{
  final Creditmemo creditmemoListData;
  const RefundScreenSuccess(this.creditmemoListData);
}

class RefundScreenError extends RefundScreenState{
  final String message;
  const RefundScreenError(this.message);
}



