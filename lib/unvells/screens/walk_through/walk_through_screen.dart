import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/app_widgets/app_outlined_button.dart';
import 'package:test_new/unvells/app_widgets/custom_button.dart';
import 'package:test_new/unvells/app_widgets/flux_image.dart';
import 'package:test_new/unvells/configuration/unvells_theme.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/helper/utils.dart';

import '../../app_widgets/app_alert_message.dart';
import '../../app_widgets/circle_page_indicator.dart';
import '../../app_widgets/image_view.dart';
import '../../app_widgets/loader.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_routes.dart';
import '../../constants/app_string_constant.dart';
import '../../helper/PreCacheApiHelper.dart';
import '../../helper/app_storage_pref.dart';
import '../../models/walk_through/walk_through_model.dart';
import '../../network_manager/api_client.dart';
import 'bloc/walk_through_bloc.dart';
import 'bloc/walk_through_event.dart';
import 'bloc/walk_through_state.dart';

class WalkThroughScreen extends StatefulWidget {
  const WalkThroughScreen({Key? key}) : super(key: key);

  @override
  _WalkThroughScreenState createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  WalkThroughBloc? _walkThroughBloc;
  bool isLoading = false;
  WalkThroughModel? walkViewThroughModel;
  List<WalkthroughData> itemListData = [];
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _walkThroughBloc = context.read<WalkThroughBloc>();
    precCacheHomePage(false);
    _walkThroughBloc?.add(const WalkThroughFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WalkThroughBloc, WalkThroughState>(
          builder: (context, currentState) {
            if (currentState is WalkThroughInitial) {
              isLoading = true;
            } else if (currentState is WalkThroughSuccess) {
              isLoading = false;
              walkViewThroughModel = currentState.model;
              itemListData.addAll(walkViewThroughModel?.walkthroughData ?? []);
            } else if (currentState is WalkThroughError) {
              isLoading = false;
              Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.bottomTabBar, (Route<dynamic> route) => false);
            }
            return isLoading ? const Loader() : _buildUI();
          }),
    );
  }

  Widget _buildUI() {
    if ((walkViewThroughModel?.walkthroughData ?? []).isEmpty) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.bottomTabBar, (Route<dynamic> route) => false);
    }
    return Stack(
      children: [
        // Dynamic background image
        walkViewThroughModel != null && walkViewThroughModel!.walkthroughData!.isNotEmpty
            ? ImageView(
          url:    walkViewThroughModel!.walkthroughData?[_currentPageNotifier.value].name??"",
          fit: BoxFit.fill,
          height: AppSizes.deviceHeight*.7,
          width: double.infinity,
        )
            : Container(),

        Stack(
          children: [
            // Positioned.fill(
            //   // bottom: -1,
            //   // top: 300,
            //   child: Container(
            //     color: Colors.black.withOpacity(0.3), // Optional overlay
            //   ),
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // const SizedBox(height: 40), // Add some top padding if needed
                _buildPageView(),
                _buildTextContent(),
                _buildCircularIndicator(_currentPageNotifier),
                _buildBottomButton(),
                const SizedBox(height: 30), // Add some bottom padding if needed
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPageView() {
    return CarouselSlider.builder(
        itemCount: walkViewThroughModel?.walkthroughData?.length,
        options: CarouselOptions(
          onPageChanged: (index, reason) {
            setState(() {
              _currentPageNotifier.value = index;
            });
          },
          enlargeCenterPage: true,

          height: MediaQuery.of(context).size.height * 0.2,
          viewportFraction: 0.8,

          // aspectRatio: 1/1,
          enableInfiniteScroll: false,

        ),
        itemBuilder: (context, index, i) {
          return Container(); // Empty container as we are not displaying text here
        });
  }

  Widget _buildTextContent() {
    final currentIndex = _currentPageNotifier.value;
    final currentData = walkViewThroughModel?.walkthroughData?[currentIndex];

    return SizedBox(
      width: AppSizes.deviceWidth*.85,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            currentData?.productId ?? "",
            textAlign: TextAlign.center,
            maxLines: 2,
            style: KTextStyle.of(context).bold32,
          ),
          const SizedBox(height: 10),
          Text(
            currentData?.content ?? "",
            textAlign: TextAlign.center,
            maxLines: 3,
            style: KTextStyle.of(context).boldTwelve.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularIndicator(ValueNotifier<int> currentPageNotifier) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: CirclePageIndicator(
        dotColor: AppColors.lightGray,
        selectedDotColor:
        Theme.of(context).bottomAppBarTheme.color ?? Colors.white,
        itemCount: walkViewThroughModel?.walkthroughData?.length,
        currentPageNotifier: currentPageNotifier,
      ),
    );
  }

  Widget _buildBottomButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomButton(
        onPressed: () {
          if (_currentPageNotifier.value ==
              (walkViewThroughModel?.walkthroughData?.length ?? 1) - 1) {
            appStoragePref.setShowWalkThrough(false);
            Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.bottomTabBar, (Route<dynamic> route) => false);
          } else {
            setState(() {
              _currentPageNotifier.value++;
            });
          }
        },
        title: _currentPageNotifier.value ==
            (walkViewThroughModel?.walkthroughData?.length ?? 1) - 1
            ? Utils.getStringValue(context, AppStringConstant.skip).toUpperCase()
            : Utils.getStringValue(context, AppStringConstant.continue_to_next).toUpperCase(),
      ),
    );
  }
}
