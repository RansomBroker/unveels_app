/*
 *
  

 *
 * /
 */

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/app_widgets/app_tool_bar.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/constants/arguments_map.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/screens/view_invoice/bloc/view_invoice_screen_bloc.dart';
import 'package:test_new/unvells/screens/view_invoice/views/view_invoice_items.dart';
import 'package:test_new/unvells/screens/view_invoice/views/view_invoice_total_items.dart';
import '../../app_widgets/app_alert_message.dart';
import '../../app_widgets/app_bar.dart';
import '../../app_widgets/loader.dart';
import '../../configuration/unvells_theme.dart';
import '../../constants/app_constants.dart';
import '../../helper/app_storage_pref.dart';
import '../../models/invoice_view/invoice_view_model.dart';
import '../../models/printInvoiceView/print_invoice_model.dart';
import '../product_detail/widgets/file_download.dart';
import 'bloc/view_invoice_event.dart';
import 'bloc/view_invoice_screen_state.dart';

class ViewInvoiceScreen extends StatefulWidget {
  ViewInvoiceScreen(this.increementId, this.invoiceId, this.url, {Key? key})
      : super(key: key);
  String? increementId;
  String? invoiceId;
  // final File file;
  final String url;

  @override
  _ViewInvoiceScreenState createState() => _ViewInvoiceScreenState();
}

class _ViewInvoiceScreenState extends State<ViewInvoiceScreen> {
  ViewInvoiceBloc? _viewInvoiceScreenBloc;
  bool isLoading = false;
  InvoiceViewModel? invoiceViewDataModel;
  PrintInvoiceModel? printInvoiceModel;
  List<ItemListData> itemListData = [];
  List<TotalsData> totalItemListData = [];
  TextEditingController textEditingController = TextEditingController();
  int page = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _viewInvoiceScreenBloc = context.read<ViewInvoiceBloc>();

    _viewInvoiceScreenBloc?.add(ViewInvoiceDetailFetchEvent(widget.invoiceId!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
          '${Utils.getStringValue(context, AppStringConstant.invoice)}  -  #${widget.invoiceId}',
          context,
          isLeadingEnable: true, onPressed: () {
        Navigator.pop(context);
      }),
      body: BlocBuilder<ViewInvoiceBloc, ViewInvoiceState>(
          builder: (context, currentState) {
        if (currentState is ViewInvoiceInitial) {
          isLoading = true;
        } else if (currentState is ViewInvoiceSuccess) {
          isLoading = false;
          invoiceViewDataModel = currentState.invoiceViewModel;
          itemListData.addAll(invoiceViewDataModel?.itemList ?? []);
          totalItemListData.addAll(invoiceViewDataModel?.totals ?? []);
        } else if (currentState is PrintInvoiceSuccess) {
          isLoading = false;
          printInvoiceModel = currentState.printInvoiceModel;
          DownloadFile().downloadPersonalData(
              currentState.printInvoiceModel?.url ?? "",
              "Invoice-${widget?.increementId}-${widget?.invoiceId}-${DateTime.now().microsecond}",
              "pdf",
              context);
        }  else if (currentState is ViewInvoiceError) {
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
    IconData? iconLeft;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: <Widget>[
          Visibility(
              visible: invoiceViewDataModel != null,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.transparent.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 9,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(AppSizes.size8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: AppSizes.size16,
                              ),
                              Text(
                                '${invoiceViewDataModel?.itemList?.length}  ${Utils.getStringValue(context, AppStringConstant.itemsTotal)} ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        // color: AppColors.textColorPrimary,
                                        fontSize: AppSizes.textSizeMedium),
                              ),
                              const SizedBox(
                                height: AppSizes.size16,
                              ),
                              const Divider(
                                thickness: 1,
                                height: 1,
                              ),
                              const SizedBox(
                                height: AppSizes.size16,
                              ),
                              if (invoiceViewDataModel?.otherError != 1 &&
                                  (invoiceViewDataModel?.itemList?.length ??
                                          0) >
                                      0) ...[
                                ListView.builder(
                                    itemCount: itemListData.length,
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return ViewInvoiceItems(
                                          context, itemListData[index]);
                                    }),
                              ] else ...[
                                Center(
                                  child: Text((invoiceViewDataModel
                                              ?.message?.isNotEmpty ==
                                          true)
                                      ? (invoiceViewDataModel?.message ?? "")
                                      : Utils.getStringValue(
                                          context,
                                          AppStringConstant
                                              .noDownloadableProducts)),
                                )
                              ],
                              const SizedBox(
                                height: AppSizes.size16,
                              ),
                              Text(
                                  Utils.getStringValue(
                                      context,
                                      AppStringConstant
                                          .priceDetailsViewInvoice),
                                  style: Theme.of(context).textTheme.headlineLarge
                                  // ?.copyWith(
                                  // color: AppColors.textColorPrimary,
                                  // fontSize: AppSizes.textSizeMedium),
                                  ),
                              const SizedBox(
                                height: AppSizes.size16,
                              ),
                              const Divider(
                                thickness: 1,
                                height: 1,
                              ),
                              const SizedBox(
                                height: AppSizes.size16,
                              ),
                              if (invoiceViewDataModel?.otherError != 1 &&
                                  (invoiceViewDataModel?.totals?.length ?? 0) >
                                      0) ...[
                                ListView.builder(
                                    itemCount: totalItemListData.length,
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return ViewInvoiceTotalItems(
                                          context, totalItemListData[index]);
                                    }),
                              ] else ...[
                                Center(
                                  child: Text((invoiceViewDataModel
                                              ?.message?.isNotEmpty ==
                                          true)
                                      ? (invoiceViewDataModel?.message ?? "")
                                      : Utils.getStringValue(
                                          context,
                                          AppStringConstant
                                              .noDownloadableProducts)),
                                )
                              ],
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        height: 45,
                        child: ElevatedButton(
                            onPressed: () async {
                              _viewInvoiceScreenBloc!.add(PrintInvoiceViewDataEvent(widget.invoiceId!, widget.increementId!));
                              _viewInvoiceScreenBloc?.emit(ViewInvoiceInitial());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  iconLeft ?? Icons.save_alt,
                                  size: AppSizes.size20,
                                  color: AppColors.white,
                                ),
                                const SizedBox(
                                  width: AppSizes.paddingGeneric,
                                ),
                                Text(
                                    (Utils.getStringValue(
                                                context,
                                                AppStringConstant
                                                    .saveInvoice) ??
                                            '')
                                        .toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(color: AppColors.white))
                              ],
                            )
                            // ),
                            ),
                      ),
                    ],
                  ),
                ),
              )),
          Visibility(
            visible: isLoading,
            child: const Loader(),
          ),
        ],
      ),
    );
  }
}
