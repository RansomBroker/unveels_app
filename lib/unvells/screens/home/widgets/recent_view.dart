/*
 *
  

 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/models/categoryPage/product_tile_data.dart';
import 'package:test_new/unvells/screens/home/widgets/product_carasoul_widget_type1.dart';
import 'package:test_new/unvells/screens/home/widgets/product_carasoul_widget_type2.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/app_string_constant.dart';
import '../../../helper/LocalDb/floor/database.dart';
import '../../../helper/LocalDb/floor/entities/recent_product.dart';
import '../../../helper/LocalDb/floor/recent_view_controller.dart';
import '../../../helper/app_localizations.dart';
import '../../../models/homePage/home_page_carausel.dart';
import '../bloc/home_screen_bloc.dart';

class RecentView extends StatefulWidget {
  const RecentView({Key? key}) : super(key: key);

  @override
  State<RecentView> createState() => _RecentViewState();
}

class _RecentViewState extends State<RecentView> {
  AppLocalizations? _localizations;
  List<ProductTileData>? _recentProductList;
  late double _size;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _size = (AppSizes.deviceWidth / 2.5) - AppSizes.linePadding;
    fetchRecentProducts();
    RecentViewController.controller.stream.listen((event) {
      fetchRecentProducts();
    });

    super.initState();
  }

  void fetchRecentProducts() async {
    List<RecentProduct> recentProducts =
        await (await AppDatabase.getDatabase()).recentProductDao.getProducts();

    // print("TEST_LOG==>recentProducts==>${recentProducts.toList().toString()}");

    List<ProductTileData> mRecentProducts = [];
    // recentProducts.reversed.toList().asMap().forEach((index, element) {
    //   if (index < 4) {
    //     mRecentProducts?.add(ProductTileData(element.availability, element.dominantColor, element.entityId, element.finalPrice??"",
    //         element.formattedFinalPrice, element.formattedPrice, element.formattedTierPrice, false, element.isAvailable,
    //         element.isInRange, element.isInWishlist, element.isNew, element.minAddToCartQty, element.name,
    //         element.price, element.reviewCount, element.thumbNail, element.tierPrice, element.typeId, element.rating, element.wishlistItemId));
    //
    //   }
    // });

    for (var i = recentProducts.length - 1; i >= 0; i--) {
      if (mRecentProducts.length < 5) {
        mRecentProducts?.add(ProductTileData(
            recentProducts[i].availability,
            recentProducts[i].dominantColor,
            recentProducts[i].entityId,
            recentProducts[i].finalPrice ?? "",
            recentProducts[i].formattedFinalPrice,
            recentProducts[i].formattedPrice,
            recentProducts[i].formattedTierPrice,
            false,
            recentProducts[i].isAvailable,
            recentProducts[i].isInRange,
            recentProducts[i].isInWishlist,
            recentProducts[i].isNew,
            recentProducts[i].minAddToCartQty,
            recentProducts[i].name,
            recentProducts[i].price,
            recentProducts[i].reviewCount,
            recentProducts[i].thumbNail,
            recentProducts[i].tierPrice,
            recentProducts[i].typeId,
            recentProducts[i].rating,
            recentProducts[i].wishlistItemId));
      }
    }

    _recentProductList = await mRecentProducts;

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ((_recentProductList ?? []).isNotEmpty) ? recentView() : Container();
  }

  Widget recentView() {
    return Column(
      children: [
        ProductCarasoulType2(
          (_recentProductList ?? []),
          context,
          '',
          '',
          _localizations?.translate(AppStringConstant.recentlyViewed) ?? '',
          isShowViewAll: false,
        ),
      ],
    );
  }
}
