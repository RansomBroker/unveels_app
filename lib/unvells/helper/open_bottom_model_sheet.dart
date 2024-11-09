/*
 *
  

 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../app_widgets/bottom_sheet.dart';
import '../screens/location_screen/bloc/location_bloc.dart';
import '../screens/location_screen/bloc/location_repository.dart';
import '../screens/location_screen/views/place_search.dart';

void placeSearchBottomModelSheet(
    BuildContext context, Function(LatLng) callback) {
  showAppModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (context) => BlocProvider(
        create: (context) =>
            LocationScreenBloc(repository: LocationRepositoryImp()),
        child: const PlaceSearch(),
      )).then((value) {
    if(value is LatLng){
      callback(value);
    }
  });
}