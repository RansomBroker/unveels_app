/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';

abstract class RefundScreenEvent extends Equatable{
  const RefundScreenEvent();

  @override
  List<Object> get props => [];
}

class RefundScreenDataFetchEvent extends RefundScreenEvent{
  final String page;
  const RefundScreenDataFetchEvent(this.page);
}

class RefundDetailsFetchEvent extends RefundScreenEvent{
  final String invoiceId;
  const RefundDetailsFetchEvent(this.invoiceId);
}
