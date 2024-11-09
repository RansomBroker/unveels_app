/*
 *


 *
 * /
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/models/categoryPage/product_tile_data.dart';
import 'package:test_new/unvells/screens/home/bloc/home_screen_bloc.dart';
import 'package:test_new/unvells/screens/home/widgets/product_item_full_width.dart';

import '../../../constants/app_routes.dart';
import '../../../constants/app_string_constant.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/PreCacheApiHelper.dart';
import '../../../models/catalog/request/catalog_product_request.dart';
import '../../category/widgets/category_products.dart';
import '../../category/widgets/view_all.dart';
import 'category_widget_type1.dart';
import 'home_page_product_card.dart';
import 'item_card.dart';

Widget productCarasoulWidgetType3(List<ProductTileData> products, String id,
    String title, BuildContext context, HomeScreenBloc homeScreenBloc) {
  List<Widget> customViews = [];
  for (int i = 0; i < products.length; i++) {
    if ((i + 1) % 3 == 0) {
      print("ewewfwe--Code3$i");

      customViews.add(SizedBox(
        height: (AppSizes.deviceWidth / 1.9)+20,
        width: AppSizes.deviceWidth,
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0,left:8.0,right:8.0),
          child: ProductItemFullWidth(
            product: products[i],
          ),
        ),
      ));
      i++;
    } else {
      if (i == 0) {
        continue;
      }
      print("ewewfwe--Code2$i----${i - 1}");
      //unvells  pre-cache
      if (!(mainBox.containsKey("ProductPageData:" + (products[i - 1].entityId ?? 0).toString() ?? ""))) {
        precCacheProductPage((products[i - 1].entityId ?? 0).toString() ?? "");
      }
      customViews.add(Padding(
        padding: const EdgeInsets.only(top: 0.0,left:8.0,right:8.0),
        child: Row(
          children: [
            SizedBox(
              width: AppSizes.deviceWidth / 2 -
                  (AppSizes.linePadding + AppSizes.linePadding),
              height: ((AppSizes.deviceWidth / 1.6)+20),
              child: HomePageProductCard(
                product: products[i - 1],
                imageSize:
                (AppSizes.deviceWidth - (AppSizes.size8 + AppSizes.size8)) /
                    2.5,
              ),
            ),
            SizedBox(
              height: ((AppSizes.deviceWidth / 1.6)+20),
              // height: 1000,
              width: AppSizes.deviceWidth / 2 -
                  (AppSizes.linePadding + AppSizes.linePadding),
              child: HomePageProductCard(
                product: products[i],
                imageSize:
                (AppSizes.deviceWidth - (AppSizes.size8 + AppSizes.size8)) /
                    2.5,
              ),
            )
          ],
        ),
      ));
    }
  }

  //unvells  pre-cache
  Map<String,String>? sort =  Map<String,String>();
  var req = CatalogProductRequest(page: 1, id: id, type: BUNDLE_KEY_CATALOG_TYPE_CUSTOM_CAROUSEL,sortData: sort,filterData: []);
  preCacheGetCatalogProducts(req);
  return Container(
    color: Theme.of(context).cardColor,
    child: Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 10.0,left:10.0,right:10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSizes.size8 / 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.size8 / 2),
              ),
              child: Text(
                title.toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge,
              ),
            ),
            viewAllButton(context, () {
              Navigator.pushNamed(context, AppRoutes.catalog,
                  arguments: getCatalogMap(
                    id ?? "",
                    title ?? "",
                    BUNDLE_KEY_CATALOG_TYPE_CUSTOM_CAROUSEL,
                    false,
                  ));
            }),
          ],
        ),
      ),
      const Padding(padding: EdgeInsets.only(top: AppSizes.size8)),
      Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Column(children: customViews),
      ),
    ]),
  );
}
