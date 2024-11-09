/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';

import '../../../models/invoice_view/invoice_view_model.dart';
import '../../../models/printInvoiceView/print_invoice_model.dart';

abstract class ViewInvoiceState extends Equatable{
  const ViewInvoiceState();

  @override
  List<Object> get props => [];
}


class ViewInvoiceInitial extends ViewInvoiceState{}

class ViewInvoiceSuccess extends ViewInvoiceState{
  final InvoiceViewModel invoiceViewModel;
  const ViewInvoiceSuccess(this.invoiceViewModel);
}

class PrintInvoiceSuccess extends ViewInvoiceState{
  final PrintInvoiceModel printInvoiceModel;
  const PrintInvoiceSuccess(this.printInvoiceModel);
}


class ViewInvoiceError extends ViewInvoiceState{
  final String message;
  const ViewInvoiceError(this.message);
}

