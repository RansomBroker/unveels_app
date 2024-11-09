// /*
//  *
//
//
//  *
//  * /
//  */
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:test_new/unvells/app_widgets/app_order_button.dart';
// import 'package:test_new/unvells/constants/app_string_constant.dart';
// import 'package:test_new/unvells/helper/app_localizations.dart';
// import 'package:test_new/unvells/helper/utils.dart';
// import 'package:test_new/unvells/models/categoryPage/product_tile_data.dart';
//
// import '../../../app_widgets/app_outlined_button.dart';
// import '../../../constants/app_constants.dart';
// import '../../../constants/app_routes.dart';
// import '../../../constants/arguments_map.dart';
// import '../../../helper/PreCacheApiHelper.dart';
// import '../../../models/catalog/request/catalog_product_request.dart';
// import '../../category/widgets/category_products.dart';
// import '../../category/widgets/view_all.dart';
// import '../bloc/home_screen_bloc.dart';
// import 'category_widget_type1.dart';
// import 'home_page_product_card.dart';
// import 'item_card.dart';
//
// Widget ProductCarasoulType1(
//     List<ProductTileData> products,
//     BuildContext context,
//     String id,
//     String title,
//     HomeScreenBloc homeScreenBloc) {
//   //unvells  pre-cache
//   Map<String,String>? sort =  Map<String,String>();
//   var req = CatalogProductRequest(page: 1, id: id, type:BUNDLE_KEY_CATALOG_TYPE_CUSTOM_CAROUSEL,sortData: sort,filterData: []);
//   preCacheGetCatalogProducts(req);
//   return Container(
//     color: Theme.of(context).cardColor,
//     child: Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(AppSizes.size4 / 2),
//           decoration: BoxDecoration(
//             color: Theme.of(context).cardColor,
//             borderRadius: BorderRadius.circular(AppSizes.size4 / 2),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(AppSizes.size16),
//             child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   title.toUpperCase(),
//                   style: Theme.of(context).textTheme.bodyLarge,
//                 )),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(AppSizes.size8),
//           child: GridView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisExtent:
//                     (MediaQuery.of(context).size.height / 3.56) + 70,
//                 // childAspectRatio: (1 - (90 / AppSizes.deviceWidth / 1)),
//               ),
//               itemCount: 4,
//               itemBuilder: (BuildContext context, int index) {
//                 var data = products[index];
//                 if (!(mainBox.containsKey("ProductPageData:" + (data.entityId ?? 0).toString() ?? ""))) {
//                   precCacheProductPage((data.entityId ?? 0).toString() ?? "");
//                 }
//                 return GestureDetector(
//                   onTap: () {},
//                   child: HomePageProductCard(
//                     product: data,
//                     imageSize: (AppSizes.deviceWidth -
//                             (AppSizes.size8 + AppSizes.size8)) /
//                         2.6,
//                   ),
//                 );
//               }),
//         ),
//         Padding(
//             padding: const EdgeInsets.all(AppSizes.size8),
//             child: appOutlinedButton(context, () {
//
//               Navigator.pushNamed(context, AppRoutes.catalog,
//                   arguments: getCatalogMap(
//                     id,
//                     title,
//                     BUNDLE_KEY_CATALOG_TYPE_CUSTOM_CAROUSEL,
//                     false,
//                   ));
//             },
//                 Utils.getStringValue(context, AppStringConstant.viewAllProduct)
//                     .toUpperCase())),
//       ],
//     ),
//   );
// }
