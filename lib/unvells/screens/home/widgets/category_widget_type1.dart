/*
 *


 *
 * /
 */

import 'dart:core';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/models/homePage/featured_categories.dart';

import '../../../constants/app_routes.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/PreCacheApiHelper.dart';
import '../../../helper/utils.dart';
import '../../../models/catalog/request/catalog_product_request.dart';
import '../../../models/categoryPage/category.dart';
import '../../../network_manager/api_client.dart';



Widget CategoryWidgetType1(
    BuildContext context, List<FeaturedCategories>? carousel) {
  List<Widget> x = [];
  carousel?.forEach((value) {
    //unvells  pre-cache
    Map<String,String>? sort =  Map<String,String>();
    var req = CatalogProductRequest(page: 1, id: value.categoryId.toString() ?? "", type: "category",sortData: sort,filterData: []);
    preCacheGetCatalogProducts(req);
    x.add(
        SizedBox(
          width: AppSizes.deviceWidth / 3,
          height: AppSizes.deviceWidth / 3.6,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.catalog,
                  arguments: getCatalogMap(
                    value.categoryId.toString() ?? "",
                    value.categoryName ?? "",
                    BUNDLE_KEY_CATALOG_TYPE_CATEGORY,
                    false,
                  ));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Card(
                  elevation: 2.0,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2.0))),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: AppSizes.deviceWidth / 3.1,
                        height: AppSizes.deviceWidth / 3.6,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(2.0),
                              topRight: Radius.circular(2.0)),
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl: value.url ?? "",
                            placeholder: (context, url) => Container(
                              color: Color(
                                  Utils.getColor(value.dominantColor ?? '')),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Color(
                                  Utils.getColor(value.dominantColor ?? "")),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                        padding: const EdgeInsets.all(8),
                        child: Center(
                            child: Text(
                              value.categoryName ?? "",
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: AppSizes.textSizeSmall,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.grey[600],
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  });

  return Container(
    padding: const EdgeInsets.fromLTRB(0, 8, 0, 6),
    margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
    height: AppSizes.deviceWidth / 3.6 + 65,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: x,
    ),
  );
}

