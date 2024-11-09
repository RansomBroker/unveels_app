/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/constants/app_routes.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/screens/category/widgets/view_all.dart';

import '../../../app_widgets/loader.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/PreCacheApiHelper.dart';
import '../../../models/catalog/request/catalog_product_request.dart';
import '../../../models/categoryPage/product_tile_data.dart';
import '../../category/widgets/category_products.dart';
import '../../home/widgets/category_widget_type1.dart';
import '../../home/widgets/item_card.dart';

Widget buildSubCategoryProducts(
    List<ProductTileData> products,
    BuildContext context,
    bool? isLoading,
    String? categoryId,
    String categoryName) {

  //unvells  pre-cache
  Map<String,String>? sort =  Map<String,String>();
  var req = CatalogProductRequest(page: 1, id: categoryId, type:BUNDLE_KEY_CATALOG_TYPE_CUSTOM_CAROUSEL,sortData: sort,filterData: []);
  preCacheGetCatalogProducts(req);

  return (isLoading ?? false)
      ? const Loader()
      : Visibility(
          visible: products.isNotEmpty,
          child: Container(
            color: Theme.of(context).cardColor,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: AppSizes.size8,
                  bottom: AppSizes.size4,
                  left: AppSizes.size4,
                  right: AppSizes.size4),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppSizes.size8 / 2),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppSizes.size8 / 2),
                        ),
                        child: Text(
                          Utils.getStringValue(
                              context, AppStringConstant.products),
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(fontSize: AppSizes.textSizeMedium),
                        ),
                      ),
                      viewAllButton(context, () {
                        Navigator.pushNamed(context, AppRoutes.catalog,
                            arguments: getCatalogMap(
                              categoryId ?? "",
                              categoryName ?? "",
                              BUNDLE_KEY_CATALOG_TYPE_CATEGORY,
                              false,
                            ));
                      }),
                    ],
                  ),
                  const SizedBox(
                    height: AppSizes.size8,
                  ),
                  SizedBox(
                    width: AppSizes.deviceWidth.toDouble(),
                    height: ((AppSizes.deviceWidth / 1.6) + 6),
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: products.length,
                        itemBuilder: (BuildContext context, int index) {
                          var data = products[index];
                          // pre-cache
                          if (!(mainBox.containsKey("ProductPageData:" + (data.entityId ?? 0).toString() ?? ""))) {
                            precCacheProductPage(
                                (data.entityId ?? 0).toString() ?? "");
                          }                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                AppRoutes.productPage,
                                arguments: getProductDataAttributeMap(
                                  data.name ?? "",
                                  data.entityId.toString() ?? "",
                                ),
                              );
                            },
                            child: ItemCard(
                              product: data,
                              imageSize: (AppSizes.deviceWidth -
                                      (AppSizes.size8 + AppSizes.size8)) /
                                  2.5,
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        );
}
