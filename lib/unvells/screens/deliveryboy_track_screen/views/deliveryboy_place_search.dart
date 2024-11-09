/*
 *
  

 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/helper/utils.dart';

import '../../../app_widgets/app_alert_message.dart';
import '../../../constants/app_string_constant.dart';
import '../../../models/google_place_model.dart';
import '../bloc/deliveryboy_track_bloc.dart';
import '../bloc/deliveryboy_track_event.dart';
import '../bloc/deliveryboy_track_state.dart';

class DeliveryboyPlaceSearch extends StatefulWidget {
  const DeliveryboyPlaceSearch({Key? key}) : super(key: key);

  @override
  _DeliveryboyPlaceSearchState createState() => _DeliveryboyPlaceSearchState();
}

class _DeliveryboyPlaceSearchState extends State<DeliveryboyPlaceSearch> {
  TextEditingController searchController = TextEditingController();
  GooglePlaceModel? placeModel;
  bool isLoading = false;
  DeliveryboyTrackBloc? _deliveryboyTrackBloc;

  @override
  void initState() {
    _deliveryboyTrackBloc = context.read<DeliveryboyTrackBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeliveryboyTrackBloc, DeliveryboyTrackState>(
      builder: (context, state) {
        if (state is DeliveryboyTrackLoadingState) {
          isLoading = true;
        } else if (state is DeliveryboySearchPlaceSuccessState) {
          isLoading = false;
          placeModel = state.data;
          print("length -------${placeModel?.results?.length}");
        } else if (state is DeliveryboyErrorState) {
          isLoading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showError(state.message, context);
          });
        } else if (state is DeliveryboyTrackInitialState) {
          isLoading = false;
          placeModel = null;
        }
        return _buildUI();
      },
    );
  }

  Widget _buildUI() {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Utils.hideSoftKeyBoard();
              // Helper.hideSoftKeyBoard();
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.black,
            ),
          ),
          title: TextField(
            autofocus: true,
            controller: searchController,
            onChanged: (searchKey) {
              print(searchKey);
              if(searchKey.isNotEmpty){
                _deliveryboyTrackBloc?.add(SearchPlaceEvent(searchKey));
              }
              else{
                _deliveryboyTrackBloc?.add(SearchPlaceInitialEvent());
              }
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText:
                  Utils.getStringValue(context, AppStringConstant.search),
              hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.normal,color: AppColors.darkGray
              ),
            ),
            style: Theme.of(context).textTheme.bodyLarge,
            cursorColor: Theme.of(context).colorScheme.onPrimary,
          ),
          actions: [
            searchController.text.isNotEmpty
                ? IconButton(
                  onPressed: () {
                    Utils.hideSoftKeyBoard();
                    // Helper.hideSoftKeyBoard();
                    searchController.text = "";
                    placeModel = null;
                    _deliveryboyTrackBloc?.add(SearchPlaceInitialEvent());
                },
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.black,
                  ),
               )
                : Container()
          ],
        ),
        body: Column(
          children: [
            ((placeModel != null))
                ? (placeModel?.results?.isNotEmpty ?? false)
                ? Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: placeModel?.results?.length ?? 0,
                  itemBuilder: (context, index) => Container(
                    // padding: const EdgeInsets.all(AppSizes.imageRadius),
                    // margin: const EdgeInsets.all(AppSizes.imageRadius),
                      child: Card(
                        elevation: 5,
                        child: ListTile(
                          onTap: (){
                            Navigator.pop(context, LatLng(placeModel?.results?[index].geometry?.location?.lat ?? 0.0, placeModel?.results?[index].geometry?.location?.lng ?? 0.0));
                          },
                          title: Text(
                            placeModel?.results?[index].name ?? '',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.black),
                          ),
                          subtitle: Text(
                            placeModel?.results?[index].formattedAddress ?? '',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.lightGray),
                          ),

                        ),
                      )
                  )),
            )
                : Expanded(
                   child: Center(
                      child: Text( Utils.getStringValue(context, AppStringConstant.noResult),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.black),
                      ),
              ),
            )
                :
            Expanded(
              child: GestureDetector(
                onTap: (){Navigator.pop(context);},
              ),
            )
          ],
        )
    );
  }
}
