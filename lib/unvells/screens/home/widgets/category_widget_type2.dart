/*
 *


 *
 * /
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_new/unvells/app_widgets/flux_image.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'dart:core';

import '../../../../main.dart';
import '../../../app_widgets/image_view.dart';
import '../../../configuration/text_theme.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/PreCacheApiHelper.dart';
import '../../../helper/utils.dart';
import '../../../models/catalog/request/catalog_product_request.dart';
import '../../../models/homePage/featured_categories.dart';
import 'category_widget_type1.dart';

// Widget CategoryWidgetType2(
//     BuildContext context, List<FeaturedCategories>? carousel) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         Utils.getStringValue(
//             context, AppStringConstant.shopByCategory)
//             .toUpperCase(),
//         style: KTextStyle.of(context).boldSixteen,
//
//       ),
//       Padding(
//         padding: const EdgeInsets.all(AppSizes.spacingTiny),
//         child: GridView.builder(
//             physics: const NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 4,
//                 // childAspectRatio: (1 - (AppSizes.size30 / MediaQuery.of(context).size.width)),
//                 mainAxisExtent: (MediaQuery.of(context).size.width/4) + 30
//             ),
//             itemCount: (carousel?.length ?? 0),
//             itemBuilder: (BuildContext context, int itemIndex) {
//               //unvells  pre-cache
//               Map<String,String>? sort =  Map<String,String>();
//               var req = CatalogProductRequest(page: 1, id:  carousel?[itemIndex].categoryId.toString() ?? "", type: "category",sortData: sort,filterData: []);
//               preCacheGetCatalogProducts(req);
//               return InkWell(
//                 onTap: () {
//                   Navigator.pushNamed(context, AppRoutes.catalog,
//                       arguments: getCatalogMap(
//                         carousel?[itemIndex].categoryId.toString() ?? "",
//                         carousel?[itemIndex].categoryName ?? "",
//                         BUNDLE_KEY_CATALOG_TYPE_CATEGORY,
//                         false,
//                       ));
//                 },
//                 child: Wrap(
//                   children: [
//                     Column(
//                       children: [
//                         Container(
//                           child: Padding(
//                             padding: const EdgeInsets.only(top: AppSizes.size4),
//                             child: ClipOval(
//                                 child: Image.network(
//                                   carousel?[itemIndex].url ?? "",
//                                   fit: BoxFit.cover,
//                                   width: AppSizes.featuredCategoryImageSizeSmall,
//                                   height: AppSizes.featuredCategoryImageSizeSmall,
//
//                                 )),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: AppSizes.size8, left: AppSizes.spacingTiny, right: AppSizes.spacingTiny),
//                           child: Container(
//                             width: AppSizes.deviceWidth/2.5,
//                             child: Text(carousel?[itemIndex].categoryName ?? "",
//                               overflow: TextOverflow.ellipsis,
//                               maxLines: 2,
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 fontSize: AppSizes.textSizeSmall,
//                                 fontWeight: FontWeight.bold,
//                                 color: Theme.of(context).brightness ==
//                                     Brightness.dark
//                                     ? Colors.white
//                                     : Colors.grey[600],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             }),
//       )
//     ],
//   );
// }

class CategoryWidgetType2 extends StatelessWidget {
  const CategoryWidgetType2({super.key, this.carousel});

  final List<FeaturedCategories>? carousel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            Utils.getStringValue(context, AppStringConstant.categories)
                ,
            style: KTextStyle.of(context).boldSixteen,
          ),
          const SizedBox(
            height: AppSizes.size16,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .1087,
            // width: AppSizes.deviceWidth,
            child: ListView.separated(
              // physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,

              // padding: const EdgeInsetsDirectional.only(end: 22),

              // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 4,
              //     // childAspectRatio: (1 - (AppSizes.size30 / MediaQuery.of(context).size.width)),
              //     mainAxisExtent: (MediaQuery.of(context).size.width / 4) + 30),
              itemCount: (carousel?.length ?? 0),
              itemBuilder: (BuildContext context, int itemIndex) {
                //  pre-cache
                Map<String, String>? sort = Map<String, String>();
                var req = CatalogProductRequest(
                    page: 1,
                    id: carousel?[itemIndex].categoryId.toString() ?? "",
                    type: "category",
                    sortData: sort,
                    filterData: []);
                preCacheGetCatalogProducts(req);
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.catalog,
                        arguments: getCatalogMap(
                          carousel?[itemIndex].categoryId.toString() ?? "",
                          carousel?[itemIndex].categoryName ?? "",
                          BUNDLE_KEY_CATALOG_TYPE_CATEGORY,
                          false,
                        ));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(50),
                            color: Colors.transparent,
                            // image: DecorationImage(image: CachedNetworkImageProvider(carousel?[itemIndex].url ?? ""),fit: BoxFit.fitWidth),
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.gold, width: 1.3),
                          ),
                          // height: constrains.maxHeight*.8,
                          width: 73,
                          child: ClipOval(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: FluxImage(
                                imageUrl: carousel?[itemIndex].url ?? "",
                                // fit: BoxFit.fitHeight,
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   height: 4,
                      // ),
                      Text(

                          carousel?[itemIndex].categoryName ?? "",
                          overflow: TextOverflow.ellipsis,

                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: KTextStyle.of(context).sixteen.copyWith(fontSize: 14,color: AppColors.gold)
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  width: 12,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
