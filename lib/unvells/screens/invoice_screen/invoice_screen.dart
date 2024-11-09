/*
 *
  

 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/constants/arguments_map.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/models/order_details/order_detail_model.dart';
import 'package:test_new/unvells/screens/downloadable_products/views/download_product_item.dart';
import 'package:test_new/unvells/screens/invoice_screen/views/invoice_item.dart';

import '../../app_widgets/app_alert_message.dart';
import '../../app_widgets/app_bar.dart';
import '../../app_widgets/app_dialog_helper.dart';
import '../../app_widgets/badge_icon.dart';
import '../../app_widgets/loader.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_routes.dart';
import '../../helper/app_localizations.dart';
import '../../helper/app_storage_pref.dart';
import '../../models/printInvoiceView/print_invoice_model.dart';
import '../order_details/views/order_id_date_view.dart';
import '../product_detail/widgets/file_download.dart';
import 'bloc/invoice_screen_bloc.dart';
import 'bloc/invoice_screen_events.dart';
import 'bloc/invoice_screen_state.dart';

class InvoiceScreen extends StatefulWidget {
  InvoiceScreen(this.arguments, {Key? key}) : super(key: key);

  final OrderDetailModel arguments;

  @override
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  final ScrollController _scrollController = ScrollController();
  InvoiceScreenBloc? _invoiceScreenBloc;
  bool isLoading = false;
  bool isFromPagination = false;
  bool downloadInvoice = false;
  OrderDetailModel? orderDetailModel;
  InvoiceListData? invoiceListDataModel;
  List<InvoiceListData> invoiceListData = [];
  int page = 1;
  int? cartCount = 0;
  PrintInvoiceModel? printInvoiceModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _invoiceScreenBloc = context.read<InvoiceScreenBloc>();
    orderDetailModel = widget.arguments;
    invoiceListData.addAll(orderDetailModel?.invoiceList ?? []);

    _scrollController.addListener(() {
      // if (!widget.isFromDashboard) paginationFunction();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
          Utils.getStringValue(context, AppStringConstant.invoices).localized(),
          context),
      body: BlocBuilder<InvoiceScreenBloc, InvoiceScreenState>(
          builder: (context, currentState) {
            if (currentState is InvoiceScreenInitial) {
              if (downloadInvoice) {
                isLoading = true;
              }
            } else if (currentState is InvoiceScreenSuccess) {
              isLoading = false;
              invoiceListDataModel = currentState.invoiceListData;
              // if (page == 1) {
              //   invoiceListDatastModel = _orderModel?.invoiceList ?? [];
              // } else {
              //   invoiceListData.addAll(orderDetailModel?.invoiceList ?? []);
              // }
            } else if (currentState is PrintInvoiceSuccess) {
              isLoading = false;
              printInvoiceModel = currentState.printInvoiceModel;

              if (currentState?.printInvoiceModel?.success ?? false) {
                if ((currentState?.printInvoiceModel?.url ?? '').isNotEmpty) {

                  DownloadFile().downloadPersonalData(
                      currentState.printInvoiceModel?.url ?? "",
                      "Invoice-${orderDetailModel?.incrementId}-${DateTime.now().microsecond}",
                      "pdf",
                      context);

                  print("Downloadable invoice link ${currentState.printInvoiceModel?.url ?? ""}" );
                } else {
                  WidgetsBinding.instance?.addPostFrameCallback((_) {
                    AlertMessage.showError(
                        Utils.getStringValue(context, AppStringConstant.linkError),
                        context);
                  });
                }
              } else {
                WidgetsBinding.instance?.addPostFrameCallback((_) {
                  AppDialogHelper.informationDialog(
                    currentState?.printInvoiceModel?.message ??
                        Utils.getStringValue(context, AppStringConstant.linkError),
                    context,
                    AppLocalizations.of(context),
                    title: AppStringConstant.error,
                  );
                });
              }
              _invoiceScreenBloc?.emit(InvoiceScreenEmptyState());
            } else if (currentState is InvoiceScreenError) {
              isLoading = false;
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showError(currentState.message, context);
              });
            }
            return _buildUI();
          }),
    );
  }

  Widget _buildUI() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              orderIdContainer(
                  context, orderDetailModel, AppLocalizations.of(context)),
              orderPlaceDateContainer(
                  context, orderDetailModel, AppLocalizations.of(context)),
              // const SizedBox(
              //   height: AppSizes.paddingNormal,
              // ),
              if (orderDetailModel?.error != 1 &&
                  (orderDetailModel?.invoiceList?.length ?? 0) > 0) ...[
                ListView.builder(
                    controller: _scrollController,
                    itemCount: invoiceListData.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return invoiceItem(
                          context,
                          invoiceListData[index],
                          // _invoiceScreenBloc,
                              (){
                            downloadInvoice = true;
                            isLoading  = true;
                            _invoiceScreenBloc!.add(PrintInvoiceDataEvent(invoiceListData[index].id??"", orderDetailModel?.incrementId??""));
                          },
                          orderDetailModel?.incrementId ?? "");
                    }),
              ] else ...[
                Center(
                  child: Text((orderDetailModel?.message?.isNotEmpty == true)
                      ? (orderDetailModel?.message ?? "")
                      : Utils.getStringValue(
                      context, AppStringConstant.noInvoice)),
                )
              ],
            ],
          ),
        ),
        Visibility(
          visible: isLoading,
          child: const Loader(),
        ),
      ],
    );
  }
}
