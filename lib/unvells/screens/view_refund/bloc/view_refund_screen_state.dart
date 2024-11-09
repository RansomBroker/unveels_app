/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';

import '../../../models/refund_view/refund_view_model.dart';

abstract class ViewRefundState extends Equatable{
  const ViewRefundState();

  @override
  List<Object> get props => [];
}


class ViewRefundInitial extends ViewRefundState{}

class ViewRefundSuccess extends ViewRefundState{
  final RefundViewModel refundViewModel;
  const ViewRefundSuccess(this.refundViewModel);
}

class ViewRefundError extends ViewRefundState{
  final String message;
  const ViewRefundError(this.message);
}

