/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';

abstract class InvoiceScreenEvent extends Equatable{
  const InvoiceScreenEvent();

  @override
  List<Object> get props => [];
}

class InvoiceScreenDataFetchEvent extends InvoiceScreenEvent{
  final String page;
  const InvoiceScreenDataFetchEvent(this.page);
}

class InvoiceDetailsFetchEvent extends InvoiceScreenEvent{
  final String invoiceId;
  const InvoiceDetailsFetchEvent(this.invoiceId);
}

class PrintInvoiceDataEvent extends InvoiceScreenEvent{
  final String? invoiceId;
  final String? increementId;
  const PrintInvoiceDataEvent(this.invoiceId, this.increementId);

  @override
  List<Object> get props => [];
}

