import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_widgets/loader.dart';
import '../../../configuration/text_theme.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/app_string_constant.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/PreCacheApiHelper.dart';
import '../../../helper/utils.dart';
import '../../../models/catalog/request/catalog_product_request.dart';
import '../../../models/categoryPage/product_tile_data.dart';
import '../../category/widgets/category_products.dart';
import '../../category/widgets/view_all.dart';
import 'category_widget_type1.dart';
import 'item_card.dart';
import 'item_card_bloc/item_card_bloc.dart';
import 'item_card_bloc/item_card_state.dart';

class ProductCarasoulType2 extends StatefulWidget {
  final List<ProductTileData> products;
  final BuildContext context;
  final String id;
  final String category_id;
  final String title;
  final String? description;
  final bool isShowViewAll;
  final Function? callBack;

  const ProductCarasoulType2(
    this.products,
    this.context,
    this.id,
    this.category_id,
    this.title, {
    this.isShowViewAll = true,
    this.callBack,
    this.description,
    super.key,
  });

  @override
  _ProductCarasoulType2State createState() => _ProductCarasoulType2State();
}

class _ProductCarasoulType2State extends State<ProductCarasoulType2> {
  late ItemCardBloc itemCardBloc;

  @override
  void initState() {
    super.initState();
    itemCardBloc = widget.context.read<ItemCardBloc>();

    // pre-cache
    Map<String, String>? sort = {};
    var req = CatalogProductRequest(
      page: 1,
      id: widget.id,
      category_id: widget.category_id,
      type: BUNDLE_KEY_CATALOG_TYPE_CUSTOM_CAROUSEL,
      sortData: sort,
      filterData: [],
    );
    preCacheGetCatalogProducts(req);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemCardBloc, ItemCardState>(
      builder: (context, state) {
        return Stack(
          children: [
            Visibility(
              visible: widget.products.isNotEmpty,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.title,
                          style: KTextStyle.of(context).boldSixteen,
                        ),
                        if (widget.isShowViewAll)
                          viewAllButton(context, () {
                            log(widget.category_id);
                            Navigator.pushNamed(
                              context,
                              AppRoutes.catalog,
                              arguments: getCatalogMap(
                                widget.id,

                                widget.title,
                                BUNDLE_KEY_CATALOG_TYPE_CUSTOM_CAROUSEL,
                                false,
                                category_id: widget.category_id,
                              ),
                            );
                          }),
                      ],
                    ),
                    if (widget.description != null) ...[
                      const SizedBox(
                        height: 2,
                      ),
                      SizedBox(
                          width: AppSizes.deviceHeight * .3,
                          child: Text(
                            widget.description ?? '',
                            style: KTextStyle.of(context)
                                .twelve
                                .copyWith(color: const Color(0xff959393)),
                          )),
                    ],

                    const SizedBox(
                      height: AppSizes.size16,
                    ),
                    SizedBox(
                      width: AppSizes.deviceWidth,
                      height: AppSizes.deviceHeight * .37,
                      child: ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(
                          width: AppSizes.deviceWidth * .03,
                        ),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.products.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (BuildContext context, int index) {
                          var data = widget.products[index];
                          if (!(mainBox.containsKey(
                              "ProductPageData:${data.entityId ?? 0}" ?? ""))) {
                            precCacheProductPage(
                                (data.entityId ?? 0).toString() ?? "");
                          }
                          return ItemCard(
                            product: data,
                            imageSize: (AppSizes.deviceWidth -
                                    (AppSizes.size8 + AppSizes.size8)) /
                                2.5,
                            isSelected: false,
                            callBack: widget.callBack,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: itemCardBloc.isLoadingAction,
              child: const Loader(),
            )
          ],
        );
      },
    );
  }
}
