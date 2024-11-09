/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/models/order_details/order_detail_model.dart';
import 'package:test_new/unvells/screens/invoice_screen/views/invoice_item.dart';
import 'package:test_new/unvells/screens/order_shipment/views/order_shipment_item.dart';
import '../../app_widgets/app_alert_message.dart';
import '../../app_widgets/app_bar.dart';
import '../../app_widgets/app_dialog_helper.dart';
import '../../helper/app_localizations.dart';
import '../../models/shipment_view/shipment_view_model.dart';
import '../order_details/views/order_id_date_view.dart';
import 'bloc/order_shipment_screen_bloc.dart';
import 'bloc/order_shipment_screen_events.dart';
import 'bloc/order_shipment_screen_state.dart';

class OrderShipmentScreen extends StatefulWidget {
  OrderShipmentScreen(this.arguments, {Key? key}) : super(key: key);

  final OrderDetailModel arguments;

  @override
  _OrderShipmentScreenState createState() => _OrderShipmentScreenState();
}

class _OrderShipmentScreenState extends State<OrderShipmentScreen> {
  final ScrollController _scrollController = ScrollController();
  OrderShipmentScreenBloc? _orderShipmentScreenBloc;
  bool isLoading = false;
  bool isFromPagination = false;
  OrderDetailModel? orderDetailModel;
  ShipmentViewModel? shipmentViewModel;
  List<ShipmentListData> shipmentListData = [];
  int page = 1;
  int? cartCount = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _orderShipmentScreenBloc = context.read<OrderShipmentScreenBloc>();
    orderDetailModel = widget.arguments;
    shipmentListData.addAll(orderDetailModel?.shipmentList ?? []);

    _scrollController.addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
          Utils.getStringValue(context, AppStringConstant.orderShipment)
              .localized(),
          context),
      body: BlocBuilder<OrderShipmentScreenBloc, OrderShipmentScreenState>(
          builder: (context, currentState) {
        if (currentState is OrderShipmentScreenInitial) {
          if (!isFromPagination) {
            isLoading = true;
          }
        } else if (currentState is OrderShipmentTrackSuccess) {
          isLoading = false;
          shipmentViewModel = currentState.shipmentViewModel;
          AppDialogHelper.shipmentTrackDialog(
              context, shipmentViewModel?.trackingData,
              onConfirm: () async {});
        } else if (currentState is OrderShipmentScreenError) {
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  orderIdContainer(
                      context, orderDetailModel, AppLocalizations.of(context)),
                  orderPlaceDateContainer(
                      context, orderDetailModel, AppLocalizations.of(context)),
                  if (orderDetailModel?.error != 1 &&
                      (orderDetailModel?.shipmentList?.length ?? 0) > 0) ...[
                    ListView.builder(
                        controller: _scrollController,
                        itemCount: shipmentListData.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return OrderShipmentItem(
                              context, shipmentListData[index]);
                        }),
                  ] else ...[
                    Center(
                      child: Text(
                          (orderDetailModel?.message?.isNotEmpty == true)
                              ? (orderDetailModel?.message ?? "")
                              : Utils.getStringValue(
                                  context, AppStringConstant.noShipment)),
                    )
                  ],
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
