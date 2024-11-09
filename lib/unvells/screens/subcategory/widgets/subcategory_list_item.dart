/*
 *
  

 *
 * /
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                  Card(
                    elevation: AppSizes.size4,
                    child: ListTile(
                      title: Text(
                        widget.subCategories?[index].name ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: AppSizes.textSizeSmall),
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
