/*
 *
  

 *
 * /
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/PreCacheApiHelper.dart';
import '../../../models/categoryPage/category.dart';
import '../../../network_manager/api_client.dart';

class SubCategoryListItem extends StatefulWidget {
  List<Category>? subCategories;

  SubCategoryListItem({Key? key, this.subCategories}) : super(key: key);

  @override
  State<SubCategoryListItem> createState() => _SubCategoryListItemState();
}



class _SubCategoryListItemState extends State<SubCategoryListItem> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.subCategories?.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          precCacheCategoryPage(widget.subCategories?[index].id ?? 0);
            //=============If no child's are found=========//
            return Padding(
              padding: const EdgeInsets.only(left: AppSizes.size4,right: AppSizes.size4),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: AppSizes.size16),
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSizes.size6),
                      // color: Colors.grey[200],
                      border: Border.all(color: Colors.black,width: .5),

                    ),
                    child: ListTile(
                      // contentPadding: EdgeInsets.zero,
                      minTileHeight: 20,
                      title: Text(
                        widget.subCategories?[index].name ?? "",
                        style: KTextStyle.of(context).boldSixteen,
                      ),
                      trailing: const Icon(Icons.arrow_right),
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.catalog,
                            arguments: getCatalogMap(
                              widget.subCategories?[index].id.toString() ?? "",
                              widget.subCategories?[index].name ?? "",
                              BUNDLE_KEY_CATALOG_TYPE_CATEGORY,
                              false,
                            ));
                      },
                    ),
                  ),
                ],

              ),
            );

        });
  }
}
