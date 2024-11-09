/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/constants/app_routes.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/models/shipment_view/shipment_view_model.dart';
import 'package:test_new/unvells/screens/view_order_shipment/bloc/view_order_shipment_event.dart';
import 'package:test_new/unvells/screens/view_order_shipment/bloc/view_order_shipment_state.dart';
import 'package:test_new/unvells/screens/view_order_shipment/views/view_order_shipment_items.dart';
import '../../app_widgets/app_alert_message.dart';
import '../../app_widgets/app_bar.dart';
import '../../app_widgets/app_dialog_helper.dart';
import '../../app_widgets/app_outlined_button.dart';
import '../../app_widgets/loader.dart';
import '../../configuration/unvells_theme.dart';
import '../../constants/app_constants.dart';
import '../../helper/app_localizations.dart';
import 'bloc/view_order_shipment_bloc.dart';

class ViewOrderShipmentScreen extends StatefulWidget {
  ViewOrderShipmentScreen(this.increementId, this.shipmentId, {Key? key})
      : super(key: key);
  String? increementId;
  String? shipmentId;

  @override
  _ViewOrderShipmentScreenState createState() =>
      _ViewOrderShipmentScreenState();
}

class _ViewOrderShipmentScreenState extends State<ViewOrderShipmentScreen> {
  ViewOrderShipmentBloc? _viewOrderShipmentScreenBloc;
  bool isLoading = false;
  ShipmentViewModel? shipmentViewDataModel;
  List<ItemShipmentListData> itemListData = [];
  TrackingListData? item;
  // List<TrackingListData> trackingListData = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _viewOrderShipmentScreenBloc = context.read<ViewOrderShipmentBloc>();

    _viewOrderShipmentScreenBloc
        ?.add(ViewOrderShipmentDetailFetchEvent(widget.shipmentId!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
          '${Utils.getStringValue(context, AppStringConstant.shipment)}  -  #${widget.increementId}',
          context,
          isLeadingEnable: true, onPressed: () {
        Navigator.pop(context);
      }),
      body: BlocBuilder<ViewOrderShipmentBloc, ViewOrderShipmentState>(
          builder: (context, currentState) {
        if (currentState is ViewOrderShipmentInitial) {
          isLoading = true;
        } else if (currentState is ViewOrderShipmentSuccess) {
          isLoading = false;
          shipmentViewDataModel = currentState.shipmentViewModel;
          itemListData.addAll(shipmentViewDataModel?.itemList ?? []);
        } else if (currentState is ViewOrderShipmentError) {
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
    return Stack(
      children: <Widget>[
        Visibility(
            visible: shipmentViewDataModel != null,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    flex: 9,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: AppSizes.size16,
                              ),
                              Text(
                                '${shipmentViewDataModel?.itemList?.length}  ${Utils.getStringValue(context, AppStringConstant.itemsTotal)} ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        fontSize: AppSizes.textSizeMedium),
                              ),
                              const SizedBox(
                                height: AppSizes.size16,
                              ),
                              const Divider(
                                thickness: 1,
                                height: 1,
                              ),const SizedBox(
                                height: AppSizes.size16,
                              ),
                              if (shipmentViewDataModel?.otherError != 1 &&
                                  (shipmentViewDataModel?.itemList?.length ??
                                          0) >
                                      0) ...[
                                ListView.builder(
                                    itemCount: itemListData.length,
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return ViewOrderShipmentItems(
                                          context, itemListData[index]);
                                    }),
                              ] else ...[
                                Center(
                                  child: Text((shipmentViewDataModel
                                              ?.message?.isNotEmpty ==
                                          true)
                                      ? (shipmentViewDataModel?.message ?? "")
                                      : Utils.getStringValue(
                                          context,
                                          AppStringConstant
                                              .noDownloadableProducts)),
                                )
                              ],
                              const SizedBox(
                                height: AppSizes.size16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                const SizedBox(
                  height: AppSizes.size16,
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  height: 45,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.orderTrack,
                            arguments: widget.shipmentId.toString());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            iconLeft ?? Icons.location_on_outlined,
                            size: AppSizes.size20,
                            color: AppColors.white,
                          ),
                          const SizedBox(
                            width: AppSizes.paddingGeneric,
                          ),
                          Text(
                            (Utils.getStringValue(
                                        context, AppStringConstant.track) ??
                                    '')
                                .toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                    color: AppColors.white,
                                    fontSize: AppSizes.textSizeMedium),
                          )
                        ],
                      )),
                ),
                const SizedBox(
                  height: AppSizes.size16,
                ),
              ],
            )),
        Visibility(
          visible: isLoading,
          child: const Loader(),
        ),
      ],
    );
  }
}
