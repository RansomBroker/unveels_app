

import 'package:equatable/equatable.dart';

abstract class QrScreenEvent extends Equatable{
  const QrScreenEvent();

  @override
  List<Object> get props => [];
}

class QrScreenDataFetchEvent extends QrScreenEvent{
  const QrScreenDataFetchEvent();
}

class QrScanSuccessEvent extends QrScreenEvent{
  String barCodeData;
  QrScanSuccessEvent(this.barCodeData);
}

