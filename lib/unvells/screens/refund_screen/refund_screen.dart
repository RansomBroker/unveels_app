/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/constants/arguments_map.dart';
import 'package:test_new/unvells/helper/app_storage_pref.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/models/order_details/order_detail_model.dart';
import 'package:test_new/unvells/screens/downloadable_products/views/download_product_item.dart';
import 'package:test_new/unvells/screens/invoice_screen/views/invoice_item.dart';
import 'package:test_new/unvells/screens/refund_screen/views/refund_item.dart';

import '../../app_widgets/app_alert_message.dart';
import '../../app_widgets/app_bar.dart';
import '../../app_widgets/badge_icon.dart';
import '../../app_widgets/loader.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_routes.dart';
import '../../helper/app_localizations.dart';
import '../order_details/views/order_id_date_view.dart';
import 'bloc/refund_screen_bloc.dart';
import 'bloc/refund_screen_state.dart';

class RefundScreen extends StatefulWidget {

  RefundScreen( this.arguments, {Key? key}) : super(key: key);

  final OrderDetailModel arguments;

  @override
  _RefundScreenState createState() => _RefundScreenState();

}

class _RefundScreenState extends State<RefundScreen> {
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  bool isFromPagination = false;
  OrderDetailModel? orderDetailModel;
  Creditmemo? creditmemoListDataModel;
  List<Creditmemo> creditmemoListData = [];
  int page = 1;
  int? cartCount = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    orderDetailModel = widget.arguments;
    creditmemoListData.addAll(orderDetailModel?.creditmemoList ?? []);

    _scrollController.addListener(() {
      // if (!widget.isFromDashboard) paginationFunction();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
          Utils.getStringValue(context, AppStringConstant.refund).localized(),
          context),

      body: BlocBuilder<RefundScreenBloc, RefundScreenState>(
          builder: (context, currentState) {
        if (currentState is RefundScreenInitial) {
          if (!isFromPagination) {
            isLoading = true;
          }
        } else if (currentState is RefundScreenSuccess) {
          isLoading = false;
          creditmemoListDataModel = currentState.creditmemoListData;

        } else if (currentState is RefundScreenError) {
          isLoading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showError(currentState.message, context);
          });
        }
        return _buildUI();
      }
      ),
    );
  }


  Widget _buildUI() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              orderIdContainer(context, orderDetailModel, AppLocalizations.of(context)),
              orderPlaceDateContainer(context, orderDetailModel, AppLocalizations.of(context)),

              if(orderDetailModel?.error!=1 && (orderDetailModel?.invoiceList?.length??0)>0)...[
                ListView.builder(
                    controller: _scrollController,
                    itemCount: creditmemoListData.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return refundItem(context, creditmemoListData[index], "${ApiConstant.webUrl}/mobikulhttp/customer/printInvoice?storeId=1&customerToken=${appStoragePref.getCustomerToken()}&incrementId=${creditmemoListData[index].incrementId}&invoiceId=${creditmemoListData[index].incrementId}");
                    }),
              ]else...[

                Center(
                  child: Text((orderDetailModel?.message?.isNotEmpty==true)?(orderDetailModel?.message??""):
                  Utils.getStringValue(context, AppStringConstant.noInvoice)),
                )
              ],
            ],
          ),
        )
      ],
    );
  }

}
