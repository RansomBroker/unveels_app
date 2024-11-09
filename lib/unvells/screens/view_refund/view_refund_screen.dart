/*
 *


 *
 * /
 */

import 'dart:io';
import 'package:flutter/foundation.dart';
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
import '../../models/invoice_view/invoice_view_model.dart';
import '../../models/refund_view/refund_view_model.dart';
import '../product_detail/widgets/file_download.dart';
import 'bloc/view_refund_event.dart';
import 'bloc/view_refund_screen_bloc.dart';
import 'bloc/view_refund_screen_state.dart';


class ViewRefundScreen extends StatefulWidget {

  ViewRefundScreen(this.increementId,this.refundId,this.url, {Key? key}) : super(key: key);
  String? increementId;
  String? refundId;
  // final File file;
  final String url;

  @override
  _ViewRefundScreenState createState() => _ViewRefundScreenState();
}

class _ViewRefundScreenState extends State<ViewRefundScreen> {
  ViewRefundBloc? _viewInvoiceScreenBloc;
  bool isLoading = false;
  RefundViewModel? refundViewDataModel;
  List<ItemListData> itemListData = [];
  List<TotalsData> totalItemListData = [];
  TextEditingController textEditingController = TextEditingController();
  int page =1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _viewInvoiceScreenBloc = context.read<ViewRefundBloc>();

    _viewInvoiceScreenBloc?.add(ViewRefundDetailFetchEvent(widget.refundId!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
          '${Utils.getStringValue(context, AppStringConstant.refund)}  -  #${widget.refundId}',
          context,
          isLeadingEnable: true, onPressed: () {
        Navigator.pop(context);
      }),


      body: BlocBuilder<ViewRefundBloc, ViewRefundState>(
          builder: (context, currentState) {
            if (currentState is ViewRefundInitial) {
              isLoading = true;
            } else if (currentState is ViewRefundSuccess) {
              isLoading = false;
              refundViewDataModel = currentState.refundViewModel;
              itemListData.addAll(refundViewDataModel?.itemList ?? []);
              totalItemListData.addAll(refundViewDataModel?.totals ?? []);

            } else if (currentState is ViewRefundError) {
              isLoading = false;
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showError((currentState.message.isNotEmpty) ? currentState.message : Utils.getStringValue(context, AppStringConstant.somethingWentWrong), context);
              });
            }
            return _buildUI();
          }),
    );
  }


  Widget _buildUI() {
    IconData? iconLeft;
    return Container(
      color: Theme.of(context).cardColor,
      child: Stack(
        children: <Widget> [
          Visibility(
              visible: refundViewDataModel != null,
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(flex: 9,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(AppSizes.size8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const SizedBox(
                            height: AppSizes.size16,
                          ),

                          Text(
                            '${refundViewDataModel?.itemList?.length}  ${Utils.getStringValue(context, AppStringConstant.itemsTotal)} ',
                            style: Theme.of(context).textTheme.bodySmall
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

                          if(refundViewDataModel?.otherError!=1 && (refundViewDataModel?.itemList?.length??0)>0)...[
                            ListView.builder(
                                itemCount: itemListData.length,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return ViewInvoiceItems(context, itemListData[index]);
                                }),
                          ]else...[

                            Center(
                              child: Text((refundViewDataModel?.message?.isNotEmpty==true)?(refundViewDataModel?.message??""): Utils.getStringValue(context, AppStringConstant.noDownloadableProducts)),
                            )
                          ],

                          const SizedBox(
                            height: AppSizes.size16,
                          ),

                          Text(
                              Utils.getStringValue(context, AppStringConstant.priceDetailsViewInvoice),
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

                          if(refundViewDataModel?.otherError!=1 && (refundViewDataModel?.totals?.length??0)>0)...[
                            ListView.builder(
                                itemCount: totalItemListData.length,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return ViewInvoiceTotalItems(context, totalItemListData[index]);
                                }),
                          ]else...[

                            Center(
                              child: Text((refundViewDataModel?.message?.isNotEmpty==true)?(refundViewDataModel?.message??""): Utils.getStringValue(context, AppStringConstant.noDownloadableProducts)),
                            )
                          ],

                        ],
                      ),
                    ),
                  ),
                ],
              )
          ),
          Visibility(
            visible: isLoading,
            child: const Loader(),
          ),

        ],
      ),
    );
  }
}
