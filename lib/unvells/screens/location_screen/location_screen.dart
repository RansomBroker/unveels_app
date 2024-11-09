/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;
import 'package:test_new/unvells/constants/app_constants.dart';

import '../../app_widgets/app_alert_message.dart';
import '../../app_widgets/app_bar.dart';
import '../../app_widgets/loader.dart';
import '../../constants/app_string_constant.dart';
import '../../helper/open_bottom_model_sheet.dart';
import '../../helper/utils.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double? latitude;
  double? longitude;
  late LatLng position;
  location.Location currentLocation = location.Location();
  GoogleMapController? _controller;
  String address = '';
  Map<String, dynamic> addressMap = {};


  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.only(top: AppSizes.size20),
        child: Column(
          children: [
            Expanded(
              child: ((latitude != null) && (longitude != null))
                    ? Stack(children: [
                      GoogleMap(
                        zoomControlsEnabled: false,
                        initialCameraPosition: CameraPosition(
                        target: LatLng(
                          latitude ?? 28.6296987, longitude ?? 77.3762753),
                          zoom: 16.0,
                       ),
                      onMapCreated: (GoogleMapController controller) {
                      _controller = controller;
                       },
                        onCameraMove: (positions) {
                        setState(() {
                          position = positions.target;
                        });
                    },
                      onCameraIdle: () {
                        getLocation(position);
                        setState(() {
                          address = '';
                        });
                      },
                    ),
                      const Positioned(
                          right: 0,
                          top: 0,
                          left: 0,
                          bottom: 0,
                          child: Icon(
                            Icons.location_pin,
                            color: AppColors.red,
                            size: 40,
                          )),
                    Positioned(
                        bottom: 18,
                        right: 18,
                        child: InkWell(
                          onTap: getCurrentLocation,
                          child:  CircleAvatar(
                            backgroundColor: Theme.of(context).colorScheme.onPrimary,
                            child: const Icon(Icons.my_location_sharp,  ),
                          ),
                        )),
                      GestureDetector(
                        onTap: () {
                          placeSearchBottomModelSheet(context, (value) {
                            print(' callback value $value');
                            placeSearch(value);
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(AppSizes.paddingMedium),
                          margin: const EdgeInsets.all(AppSizes.paddingMedium),
                          color: Theme.of(context).cardColor,
                          child: Row(
                            children: [
                              const Icon(Icons.search),
                              const SizedBox(
                                width: AppSizes.size16,
                              ),
                              Text(
                                Utils.getStringValue(context, AppStringConstant.searchLocation)
                                // GenericMethods.getStringValue(context, AppStrings.searchLocation),
                                // style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.black),
                              )
                            ],
                          ),
                        ),
                      ),
              ])
                  : Loader(),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context, addressMap);
              },
              child: Container(
                padding: const EdgeInsets.all(AppSizes.size16),
                height: AppSizes.deviceHeight / 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_pin),
                        const SizedBox(
                          width: AppSizes.paddingNormal,
                        ),
                        Text( Utils.getStringValue(context, AppStringConstant.selectLocation)
                          // GenericMethods.getStringValue(context, AppStrings.selectLocation),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: AppSizes.size16,
                    ),
                    (address != '')
                        ? Flexible(
                        child: Text(
                          address,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: AppColors.lightGray),
                        ))
                        : Text( Utils.getStringValue(context, AppStringConstant.loadingMessage)
                      // GenericMethods.getStringValue(context, AppStrings.loadingMessage),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void getCurrentLocation() async {
    var location;
    try {
      location = await currentLocation.getLocation();
    } catch (e) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        AlertMessage.showError(e.toString(), context);
      });
      Navigator.pop(context);
      print('exception----------- $e');
    }
    setState(() {
      latitude = location.latitude;
      longitude = location.longitude;
    });
    position = LatLng(latitude!, longitude!);
    _controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(latitude ?? 28.6296987, longitude ?? 77.3762753),
      zoom: 16.0,
    )));
  }

  void placeSearch(LatLng location) {
    setState(() {
      latitude = location.latitude;
      longitude = location.longitude;
    });
    position = LatLng(latitude!, longitude!);
    _controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(latitude ?? 28.6296987, longitude ?? 77.3762753),
      zoom: 16.0,
    )));
    getLocation(location);
  }

  void getLocation(LatLng latLng) async {
    List<Placemark> placemarks =
    await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    setState(() {
      if ((placemarks.first.street ?? '') != '') {
        address += '${placemarks.first.street}, ';
        addressMap['street1'] = placemarks.first.street;
      }
      if ((placemarks.first.thoroughfare ?? '') != '') {
        address += '${placemarks.first.thoroughfare}, ';
        addressMap['street2'] = placemarks.first.thoroughfare;
      }
      if ((placemarks.first.subLocality ?? '') != '') {
        address += '${placemarks.first.subLocality}, ';
        addressMap['street3'] = placemarks.first.subLocality;
      }
      if ((placemarks.first.locality ?? '') != '') {
        address += '${placemarks.first.locality}, ';
        addressMap['city'] = placemarks.first.locality;
      }
      if ((placemarks.first.administrativeArea ?? '') != '') {
        address += '${placemarks.first.administrativeArea}, ';
        addressMap['state'] = placemarks.first.administrativeArea;
      }
      if ((placemarks.first.postalCode ?? '') != '') {
        address += '${placemarks.first.postalCode}, ';
        addressMap['zip'] = placemarks.first.postalCode;
      }
      if ((placemarks.first.country ?? '') != '') {
        address += '${placemarks.first.country} ';
        addressMap['country'] = placemarks.first.country;
      }
      if ((placemarks.first.country ?? '') != '') {
        address += '${placemarks.first.country} ';
        addressMap['isoCountryCode'] = placemarks.first.isoCountryCode;
      }
    });
    print(" placemarks------- $placemarks");
    print("------------------------------------------------");
  }
}
