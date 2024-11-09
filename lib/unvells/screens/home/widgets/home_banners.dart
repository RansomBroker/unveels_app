/*
 *


 *
 * /
 */

import 'dart:async';
import 'dart:developer';
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

class HomeBanners extends StatefulWidget {
  List<Banners> banners = [];
  bool showTitle;
  String imageSize;

  HomeBanners(this.banners, this.showTitle, {required this.imageSize});

  @override
  _HomeBannersState createState() => _HomeBannersState();
}

class _HomeBannersState extends State<HomeBanners> {
  final _pageController = PageController(initialPage: 0);
  final _currentPageNotifier = ValueNotifier<int>(0);
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
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
    final bool isTwo = widget.banners.length == 2;
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: false,
        pauseAutoPlayOnTouch: true,
        viewportFraction: isTwo
            ? .5
            : multiImage
                ? .49
                : 1,
        enlargeCenterPage: false,
        clipBehavior: Clip.none,
        disableCenter: true,
        padEnds: false,
        // height: AppSizes.deviceHeight*.24,
        aspectRatio: widget.imageSize == "large" ? .8 / 1 : 1.7 / 1,

        autoPlayInterval: const Duration(seconds: 5),
        // aspectRatio: 1.6,
        enableInfiniteScroll: false,
        onPageChanged: (index, reason) {},
      ),
      items: widget.banners
          .map((item) {
            return Container(
                margin: EdgeInsetsDirectional.only(
                    end: item != widget.banners.last
                        ? AppSizes.deviceWidth * .03
                        : 0),
                child: InkWell(
                  onTap: () => handleBannerClicks(item, context),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FluxImage(
                        useExtendedImage: true,
                        imageUrl: item.url ?? "",
                        fit: BoxFit.fill,
                      )),
                ),
              );
          })
          .toList(), // Passing the item to VacationRequestItem
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
    } else if (banner.type == "page") {
      if (banner.route == 'lookbook') {
        Navigator.of(context).pushNamed(
          AppRoutes.lookBookList,
        );
      }
    }
  }
}
