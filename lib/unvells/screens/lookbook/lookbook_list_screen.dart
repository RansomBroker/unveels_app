import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/helper/request_overlay.dart';
import 'package:test_new/unvells/screens/lookbook/bloc/lookbook_screen_bloc.dart';
import 'package:test_new/unvells/screens/lookbook/bloc/lookbook_screen_event.dart';

import '../../app_widgets/flux_image.dart';
import '../../configuration/text_theme.dart';
import '../../constants/app_routes.dart';
import '../../helper/PreCacheApiHelper.dart';
import '../../models/lookBook/marker_model.dart';
import '../catalog/widget/item_catalog_product_grid.dart';
import 'bloc/lookbook_screen_state.dart';
import 'lookup_details_screen.dart';

class LookbookListScreen extends StatefulWidget {
  const LookbookListScreen({super.key});

  @override
  State<LookbookListScreen> createState() => _LookbookListScreenState();
}

class _LookbookListScreenState extends State<LookbookListScreen> {
  int? selectedIndex; // Track the selected index
  LookbookScreenBloc? _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<LookbookScreenBloc>()..add(FetchLookBookEvent());
    selectedIndex = 0; // Set the first item as selected by default
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsetsDirectional.only(start: 20),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        centerTitle: true,
        title: Text(
          "Lookbook",
          style: KTextStyle.of(context).boldSixteen,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: BlocBuilder<LookbookScreenBloc, LookBookState>(
            builder: (context, state) {
              final data = _bloc?.model;
              final profiles = _bloc?.model?[selectedIndex!].profiles;
              return KRequestOverlay(
                isLoading: state is LookBookInitialState,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: SizedBox(
                        height: AppSizes.deviceHeight * .04,
                        child: ListView.separated(
                          itemCount: data?.length ?? 0,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex =
                                      index; // Update selected index
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: selectedIndex == index
                                      ? const Color(0xff6F716E)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(2),
                                  border: Border.all(
                                    color: Colors.grey,
                                    // width: 1,
                                  ),
                                ),
                                child: Center(
                                    child: Text(
                                  data?[index].title ?? '',
                                  style: KTextStyle.of(context)
                                      .boldTwelve
                                      .copyWith(
                                          color: selectedIndex == index
                                              ? Colors.white
                                              : const Color(0xff777777)),
                                )),
                              ),
                            );
                          },
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              width: 10,
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppSizes.deviceHeight * .02,
                    ),
                    ...List.generate(
                      profiles?.length ?? 0,
                      (i) => InkWell(
                        onTap: () {
                          final markers = json.decode(profiles?[i].marker ??
                              '[]'); // Use empty array '[]' as default to avoid parsing issues

                          List<MarkerModel> markerList = List<MarkerModel>.from(
                              markers.map((data) => MarkerModel.fromJson(data)));



                          Navigator.of(context).pushNamed(
                            AppRoutes.lookBookDetails,

                            arguments: LookupDetailsArgument(image: profiles?[i].image??'',markerList:markerList ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(color: const Color(0xffE8E8E8))),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FluxImage(
                                  useExtendedImage: true,
                                  imageUrl:
                                      "${ApiConstant.mediaUrl}${profiles?[i].image ?? ''}",
                                  fit: BoxFit.fill,
                                ),
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    profiles?[i].name ?? '',
                                    style: KTextStyle.of(context).sixteen,
                                  ),
                                ),
                                // const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
