/*
 *
  

 *
 * /
 */

import 'package:equatable/equatable.dart';

abstract class ViewRefundEvent extends Equatable{
  const ViewRefundEvent();

  @override
  List<Object> get props => [];
}

class ViewRefundFetchEvent extends ViewRefundEvent{
  const ViewRefundFetchEvent();
}

class ViewRefundDetailFetchEvent extends ViewRefundEvent{
  final String viewRefundItemsId;
  const ViewRefundDetailFetchEvent(this.viewRefundItemsId);
}

