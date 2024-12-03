/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/screens/category/widgets/view_card.dart';

import '../../../../main.dart';
import '../../../app_widgets/flux_image.dart';
import '../../../app_widgets/image_view.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/PreCacheApiHelper.dart';
import '../../../models/categoryPage/category.dart';
import '../../../network_manager/api_client.dart';

// ignore: must_be_immutable
class CategoryTile extends StatefulWidget {
  List<Category>? subCategories;

  CategoryTile({Key? key, this.subCategories}) : super(key: key);

  @override
  State<CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: widget.subCategories?.length ?? 0,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        //unvells  pre-cache
        precCacheCategoryPage(widget.subCategories?[index].id ?? 0);
        if ((widget.subCategories?[index].childCategories ?? []).isEmpty) {
          //=============If no child's are found=========//
          return ListTile(
            title: Text(
              widget.subCategories?[index].name ?? "",
              style: KTextStyle.of(context).twelve,
            ),
            trailing: const Icon(Icons.arrow_right),
            onTap: () {
              Navigator.pushNamed(
                  navigatorKey.currentContext!, AppRoutes.catalog,
                  arguments: getCatalogMap(
                    widget.subCategories?[index].id.toString() ?? "",
                    widget.subCategories?[index].name ?? "",
                    BUNDLE_KEY_CATALOG_TYPE_CATEGORY,
                    false,
                  ));
            },
          );
        }
        return Column(
            //==========If sub category have child's=============//
            // initiallyExpanded: true,

            // widget.subCategories?[index] == widget.subCategories?.first
            //     ? true
            //     : false,
            // expandedCrossAxisAlignment:CrossAxisAlignment.stretch ,
            // trailing: Text(
            //   Utils.getStringValue(context, AppStringConstant.viewAll),
            //   style: KTextStyle.of(context)
            //       .boldSixteen
            //       .copyWith(color: Colors.white),
            // ),
            //
            // // dense: true,
            // title: Text(
            //   widget.subCategories?[index].name ?? "",
            //   style: KTextStyle.of(context)
            //       .boldSixteen
            //       .copyWith(color: Colors.white),
            // ),
            // shape: const Border(),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.subCategories?[index].name ?? "",
                    style: KTextStyle.of(context)
                        .boldSixteen
                        .copyWith(color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.catalog,
                          arguments: getCatalogMap(
                            widget.subCategories?[index].id.toString() ?? '',
                            widget.subCategories?[index].name ?? "",
                            BUNDLE_KEY_CATALOG_TYPE_CATEGORY,
                            false,
                          ));
                    },
                    child: Text(
                      Utils.getStringValue(context, AppStringConstant.viewAll),
                      style: KTextStyle.of(context)
                          .boldSixteen
                          .copyWith(color: Colors.white),
                    ),
                  )
                ],
              ),
              if (widget.subCategories?[index].childCategories != null)
                Container(child: expandedTileContent(index)),
            ]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: AppSizes.deviceHeight * .05,
        );
      },
    );
  }

  //=========View after tile expansion===========//
  Widget expandedTileContent(int index) {
    return SizedBox(
      height: AppSizes.deviceHeight * .2,
      child: ListView.separated(
        // physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        // padding: const EdgeInsets.all(8),
        shrinkWrap: true,
        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //   crossAxisCount: 3,
        //   childAspectRatio: (1 - (80 / MediaQuery.of(context).size.width)),
        // ),
        itemCount: (widget.subCategories?[index].childCategories?.length ?? 0),
        itemBuilder: (BuildContext context, int itemIndex) {
          //unvells  pre-cache
          precCacheCategoryPage(widget.subCategories?[index].id ?? 0);
          // if (itemIndex ==
          //     (widget.subCategories?[index].childCategories?.length ?? 0)) {
          //   return ViewCard(widget.subCategories?[index].id,
          //       widget.subCategories?[index].name ?? "");
          // }
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.catalog,
                  arguments: getCatalogMap(
                    widget.subCategories?[index].childCategories?[itemIndex].id
                            .toString() ??
                        "",
                    widget.subCategories?[index].childCategories?[itemIndex]
                            .name ??
                        "",
                    BUNDLE_KEY_CATALOG_TYPE_CATEGORY,
                    false,
                  ));
            },
            child: LayoutBuilder(builder: (context, constrains) {
              return Column(
                children: [
                  Container(
                    width: constrains.maxHeight * .74,
                    height: constrains.maxHeight * .74,
                    decoration: ShapeDecoration(
                      color: Colors.white.withOpacity(.9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                        // side: BorderSide(
                        //   width: .7,
                        //   color: Colors.grey.withOpacity(
                        //     0.1,
                        //   ),
                        // ),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: FluxImage(
                        imageUrl: widget.subCategories?[index]
                                .childCategories?[itemIndex].thumbnail ??
                            '',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  // Spacer(),
                  // ClipRRect(
                  //
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Center(
                  //       child: ImageView(
                  //         url: widget.subCategories?[index]
                  //                 .childCategories?[itemIndex].thumbnail ??
                  //             "",
                  //         fit: BoxFit.fill,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 8,
                  // ),
                  SizedBox(
                    width: AppSizes.deviceWidth * .3,
                    child: Text(
                      "${widget.subCategories?[index].childCategories?[itemIndex].name}" ??
                          "",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: KTextStyle.of(context)
                          .boldTwelve
                          .copyWith(color: Colors.white, fontSize: 14),
                    ),
                  )
                ],
              );
            }),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 8,
          );
        },
      ),
    );
  }
}
