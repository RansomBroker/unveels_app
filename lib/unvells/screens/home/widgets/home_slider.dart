/*
 *


 *
 * /
 */

import 'dart:async';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:test_new/unvells/app_widgets/flux_image.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/models/homePage/home_page_banner.dart';

import '../../../app_widgets/circle_page_indicator.dart';
import '../../../app_widgets/image_view.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/app_string_constant.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/PreCacheApiHelper.dart';
import '../../../models/catalog/request/catalog_product_request.dart';
import '../../../network_manager/api_client.dart';
import '../../category/widgets/category_products.dart';

class HomeSliders extends StatefulWidget {
  List<Banners> banners = [];
  bool showTitle;

  HomeSliders(this.banners, this.showTitle);

  @override
  _HomeSlidersState createState() => _HomeSlidersState();
}

class _HomeSlidersState extends State<HomeSliders> {
  final _pageController = PageController(initialPage: 0);
  final _currentPageNotifier = ValueNotifier<int>(0);
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
    //   if (_currentPageNotifier.value < widget.banners.length) {
    //     _currentPageNotifier.value++;
    //   } else {
    //     _currentPageNotifier.value = 0;
    //   }
    //
    //   if (widget.banners.length > 1) {
    //     _pageController.animateToPage(_currentPageNotifier.value,
    //         duration: const Duration(milliseconds: 60),
    //         curve: Curves.easeInToLinear);
    //   }
    // });
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
    final bool multiImage = widget.banners.length > 1;
    return multiImage?CarouselSlider(
      options: CarouselOptions(
        autoPlay: false,
        pauseAutoPlayOnTouch: true,
        viewportFraction: .95 ,
        enlargeCenterPage: false,
        clipBehavior: Clip.none,
        disableCenter: true,
        padEnds: false,
        height: AppSizes.deviceHeight*.24,


        autoPlayInterval: const Duration(seconds: 5),
        // aspectRatio: 1.6,
        enableInfiniteScroll: false,
        onPageChanged: (index, reason) {},
      ),
      items: widget.banners
          .map((item) => Padding(
            padding:  EdgeInsetsDirectional.only(end: AppSizes.deviceWidth*.03),
            child: InkWell(
              onTap: () => handleBannerClicks(item, context),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FluxImage(
                    useExtendedImage: true,
                    imageUrl: item.url ?? item.bannerImage ?? "",
                    fit: BoxFit.fill,
                  )),
            ),
          ))
          .toList(), // Passing the item to VacationRequestItem
    ):InkWell(
      onTap: () => handleBannerClicks(widget.banners.first, context),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FluxImage(
            useExtendedImage: true,
            imageUrl: widget.banners.first.url ?? widget.banners.first.bannerImage ?? "",
            fit: BoxFit.contain,
          )),
    );
  }


  void handleBannerClicks(Banners banner, BuildContext context) {
    if (banner.type == "category") {
      Navigator.pushNamed(context, AppRoutes.catalog,
          arguments: getCatalogMap(
            banner.id.toString() ?? "",
            banner.name ?? "",
            banner.type,
            false,
          ));
    } else if (banner.type == "product") {
      Navigator.of(context).pushNamed(
        AppRoutes.productPage,
        arguments: getProductDataAttributeMap(
          banner.name.toString(),
          banner.id.toString(),
        ),
      );
    }
  }
}
