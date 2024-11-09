/*
 *


 *
 * /
 */

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_new/unvells/models/categoryPage/banner_images.dart';

import '../../../app_widgets/circle_page_indicator.dart';
import '../../../app_widgets/image_view.dart';
import '../../../constants/app_constants.dart';

class CategoryBanners extends StatefulWidget {
  List<BannerImages> banners = [];
  CategoryBanners(this.banners);

  @override
  State<CategoryBanners> createState() => _CategoryBannersState();
}

class _CategoryBannersState extends State<CategoryBanners> {
  final _pageController = PageController(initialPage: 0);
  final _currentPageNotifier = ValueNotifier<int>(0);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPageNotifier.value < widget.banners.length) {
        _currentPageNotifier.value++;
      } else {
        _currentPageNotifier.value = 0;
      }

      _pageController.animateToPage(_currentPageNotifier.value,
          duration: const Duration(milliseconds: 60),
          curve: Curves.easeInToLinear);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer?.cancel();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(
              left: AppSizes.spacingGeneric,
              right: AppSizes.spacingGeneric,
              top: AppSizes.spacingGeneric),
          height: AppSizes.deviceWidth / 4 + 30,
          width: AppSizes.deviceWidth.toDouble(),
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.banners.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () => {},
                child: Card(
                    margin: EdgeInsets.zero,
                    child: ImageView(
                      url: widget.banners[index].url ?? "",
                      fit: BoxFit.fill,
                      isBottomPadding: false,
                    )),
              );
            },
            onPageChanged: (int index) {
              setState(() {
                _currentPageNotifier.value = index;
              });
            },
          ),
        ),
        if (widget.banners.length > 1)
          Container(
            width: AppSizes.deviceWidth,
            color: Theme.of(context).cardColor,
            child: Center(
              child: _buildCircularindicator(_currentPageNotifier),
            ),
          )
      ],
    );
  }

  Widget _buildCircularindicator(_currentPageNotifier) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CirclePageIndicator(
        dotColor: AppColors.darkGray,
        selectedDotColor:
            Theme.of(context).bottomAppBarTheme.color ?? Colors.black,
        itemCount: widget.banners.length,
        currentPageNotifier: _currentPageNotifier,
      ),
    );
  }
}
