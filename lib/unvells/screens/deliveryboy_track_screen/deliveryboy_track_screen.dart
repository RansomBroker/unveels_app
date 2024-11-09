/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/screens/deliveryboy_track_screen/bloc/deliveryboy_track_state.dart';

import '../../app_widgets/app_alert_message.dart';
import '../../app_widgets/app_bar.dart';
import '../../app_widgets/loader.dart';
import '../../constants/app_string_constant.dart';
import '../../helper/open_bottom_model_sheet.dart';
import '../../helper/utils.dart';
import '../../models/DeliveryboyLocationDetails/deliveryboy_location_details_model.dart';
import '../../models/deliveryBoyDetails/delivery_boy_details_model.dart';
import 'bloc/deliveryboy_track_bloc.dart';
import 'bloc/deliveryboy_track_event.dart';

class DeliveryboyTrackScreen extends StatefulWidget {
  DeliveryboyTrackScreen(this.assignedDeliveryBoyDetails, {Key? key}) : super(key: key);

  final AssignedDeliveryBoyDetails assignedDeliveryBoyDetails;

  @override
  State<DeliveryboyTrackScreen> createState() => _DeliveryboyTrackState();
}

class _DeliveryboyTrackState extends State<DeliveryboyTrackScreen> {
  double? latitude;
  double? longitude;
  late LatLng position;

  location.Location currentLocation = location.Location();
  GoogleMapController? _controller;
  String address = '';
  Map<String, dynamic> addressMap = {};
  AssignedDeliveryBoyDetails? _assignedDeliveryBoyDetails;
  DeliveryboyTrackBloc? _deliveryboyTrackBloc;
  var mDeliveryBoyLatLng = LatLng;
  var mCustomerBoyLatLng = LatLng;
  var mPolyline= Polyline;
  bool isLoading = false;
  DeliveryBoyLocationDetailsModel? _deliveryBoyLocationDetailsModel;

  @override
  void initState() {
    _assignedDeliveryBoyDetails = widget.assignedDeliveryBoyDetails;
    _deliveryboyTrackBloc = context.read<DeliveryboyTrackBloc>();
    _deliveryboyTrackBloc?.add(DeliveryBoyLocationDetailsFetchEvent(widget.assignedDeliveryBoyDetails.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .background,
      body: BlocBuilder<DeliveryboyTrackBloc, DeliveryboyTrackState>(
          builder: (context, currentState) {
            if (currentState is DeliveryboyTrackInitialState) {
              isLoading = true;
            } else if (currentState is DeliveryboyLocationSuccessState) {
              isLoading = false;
              _deliveryBoyLocationDetailsModel =
                  currentState.deliveryBoyLocationDetailsModel;

              WidgetsBinding.instance?.addPostFrameCallback((_) {
                setState(() {
                  latitude = double.tryParse(_deliveryBoyLocationDetailsModel?.latitude ?? "");
                  longitude = double.tryParse(_deliveryBoyLocationDetailsModel?.longitude ?? "");
                });
              });


              print("latitude ==> $latitude   $longitude" );
            } else if (currentState is DeliveryboyErrorState) {
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
        Visibility(
            visible: latitude != null && longitude !=null,
            child: (_deliveryBoyLocationDetailsModel?.success ?? false)
                ? Container(
              width: AppSizes.deviceWidth,
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(AppSizes.paddingMedium),
                      topRight: Radius.circular(AppSizes.paddingMedium)),
                  border: Border.all(color: Theme.of(context).cardColor)),
              child:  GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(latitude ?? 0.0, longitude ?? 0.0),
                  zoom: 13.0,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId('Location'),
                    position: LatLng(latitude ?? 0.0, longitude ?? 0.0),
                  ),
                },
              ),
            )
                : Container()),



        Visibility(
          visible: isLoading,
          child: const Loader(),
        ),
        Positioned(
            top: 25,
            left: 5,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).cardColor,
              child: Center(
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_sharp,
                      color: Theme.of(context).iconTheme.color,
                    )),
              ),
            ))
      ],
    );
  }
}
