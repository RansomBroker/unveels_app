import 'dart:developer';
import 'dart:io';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:image_size_getter_http_input/image_size_getter_http_input.dart';
import 'package:flutter/material.dart';
import 'package:test_new/unvells/app_widgets/custom_button.dart';
import 'package:test_new/unvells/app_widgets/flux_image.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/request_overlay.dart';
import 'package:test_new/unvells/helper/utils.dart';

import '../../app_widgets/dialog_helper.dart';
import '../../configuration/text_theme.dart';
import '../../helper/bottom_sheet_helper.dart';
import '../../helper/image_measure.dart';
import '../../helper/skeleton_widget.dart';
import '../../models/lookBook/marker_model.dart';

class LookupDetailsArgument {
  final String image;
  final List<MarkerModel> markerList;

  LookupDetailsArgument({required this.image, required this.markerList});
}

class LookupDetailsScreen extends StatefulWidget {
  final LookupDetailsArgument detailsArgument;

  const LookupDetailsScreen({super.key, required this.detailsArgument});

  @override
  _LookupDetailsScreenState createState() => _LookupDetailsScreenState();
}

class _LookupDetailsScreenState extends State<LookupDetailsScreen> {
  Size? imgSize;
  double? responsiveHieght;
  bool isLoading = false;

  @override
  void initState() {
    isLoading = true;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getImageSize();
    });
  }

  Future getImageSize() async {
    final testUrl = "${ApiConstant.mediaUrl}${widget.detailsArgument.image}";
    final httpInput = await HttpInput.createHttpInput(testUrl);
    final size = await ImageSizeGetter.getSizeAsync(httpInput);
    setState(() {
      imgSize = size;
      isLoading = false;
    });
    print('size: ${size.height}');
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
          "Lookbook Details",
          style: KTextStyle.of(context).boldSixteen,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (isLoading)
              ? Center(
            child: Skeleton(
              width: AppSizes.deviceWidth,
              height: AppSizes.deviceHeight * .4,
            ),
          )
              :  MeasureSize(
            onSizeChanged: (p0) {
              setState(() {});
              responsiveHieght = p0.height;
            },
            child:  Stack(
                    children: [
                      FluxImage(
                        imageUrl:
                            "${ApiConstant.mediaUrl}${widget.detailsArgument.image}",
                      ),
                      if(responsiveHieght!=null)
                      ...List.generate(
                        widget.detailsArgument.markerList.length,
                        (index) {
                          final marker =
                              widget.detailsArgument.markerList[index];
                          log("equation:${(marker.left / 1000) * 393}");

                          return Positioned(
                            left: (marker.left / imgSize!.width) *
                                (AppSizes.deviceWidth -
                                    (AppSizes.deviceWidth * .06)),
                            top: (marker.top / imgSize!.height) *
                                (responsiveHieght! -
                                    (AppSizes.deviceHeight * .03)),
                            // Use dynamic height
                            child: IconButton(
                              icon: const Icon(
                                Icons.add_circle_outlined,
                                size: 15,
                              ),
                              color: Colors.white,
                              onPressed: () {
                                showProductBottomSheet(
                                  sku: marker.sku ?? '',
                                  context: context,
                                );
                              },
                            ),
                          );
                        },
                      )
                    ],
                  ),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
            title: Utils.getStringValue(context, AppStringConstant.tryOn),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
