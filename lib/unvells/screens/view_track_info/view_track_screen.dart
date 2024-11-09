/*
 *
  

 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/models/shipment_view/shipment_view_model.dart';
import 'package:test_new/unvells/screens/view_track_info/bloc/view_order_track_event.dart';
import 'package:test_new/unvells/screens/view_track_info/bloc/view_order_track_state.dart';
import 'package:test_new/unvells/screens/view_track_info/views/view_track_items.dart';
import '../../app_widgets/app_alert_message.dart';
import '../../app_widgets/app_bar.dart';
import '../../app_widgets/app_dialog_helper.dart';
import '../../app_widgets/loader.dart';
import '../../constants/app_constants.dart';
import 'bloc/view_order_track_bloc.dart';

class ViewTrackScreen extends StatefulWidget {
  ViewTrackScreen(this.shipmentId, {Key? key}) : super(key: key);
  String shipmentId;

  @override
  _ViewTrackScreenState createState() => _ViewTrackScreenState();
}

class _ViewTrackScreenState extends State<ViewTrackScreen> {
  ViewOrderTrackBloc? _viewTrackScreenBloc;
  bool isLoading = false;
  ShipmentViewModel? shipmentViewDataModel;
  List<TrackingListData> itemListData = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _viewTrackScreenBloc = context.read<ViewOrderTrackBloc>();

    _viewTrackScreenBloc?.add(ViewOrderTrackFetchEvent(widget.shipmentId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
          Utils.getStringValue(context, AppStringConstant.trackingInformation),
          context,
          isLeadingEnable: true, onPressed: () {
        Navigator.pop(context);
      }),
      body: BlocBuilder<ViewOrderTrackBloc, ViewOrderTrackState>(
          builder: (context, currentState) {
        if (currentState is ViewOrderTrackInitial) {
          isLoading = true;
        } else if (currentState is ViewOrderTrackSuccess) {
          isLoading = false;
          shipmentViewDataModel = currentState.shipmentViewModel;
          itemListData.addAll(shipmentViewDataModel?.trackingData ?? []);
        } else if (currentState is ViewOrderTrackError) {
          isLoading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showError(currentState.message, context);
          });
        }
        return isLoading ? const Loader() : _buildUI();
      }),
    );
  }

  Widget _buildUI() {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            if (shipmentViewDataModel?.otherError != 1 &&
                (itemListData.length ?? 0) > 0) ...[

              Text(
                Utils.getStringValue(
                    context, (AppStringConstant.trackingInformation)) ??
                    "",
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                  itemCount: itemListData.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ViewTrackItems(context, itemListData[index]);
                  }),
            ] else ...[
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text((shipmentViewDataModel?.message?.isNotEmpty == true)
                    ? (shipmentViewDataModel?.message ?? "")
                    : Utils.getStringValue(
                        context, Utils.getStringValue(context, AppStringConstant.noTrackingInformationFound))),
              )
            ],
          ],
        )
      ],
    );
  }
}
