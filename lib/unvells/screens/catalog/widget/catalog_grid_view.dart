/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/models/categoryPage/product_tile_data.dart';
import '../../../app_widgets/loader.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/PreCacheApiHelper.dart';
import '../../../models/productDetail/product_detail_page_model.dart';
import '../../../network_manager/api_client.dart';
import '../../home/widgets/item_bloc_widget_wrapper.dart';
import '../../home/widgets/item_card_bloc/item_card_bloc.dart';
import '../../home/widgets/item_card_bloc/item_card_state.dart';
import 'item_catalog_product_grid.dart';

class CatalogGridView extends StatelessWidget {
  const CatalogGridView({Key? key, this.products, this.controller})
      : super(key: key);

  final List<ProductTileData>? products;
  final ScrollController? controller;

  int getListLength() {
    if (products == null) {
      return 0;
    } else {
      return products?.length.isEven == true
          ? products?.length ?? 0
          : products?.length ?? 0 + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    ItemCardBloc itemCardBloc = context.read<ItemCardBloc>();

    return Stack(
      children: [
        GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.55,
          ),
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: getListLength(),
          controller: controller,

          itemBuilder: (context, index) {
            //  pre-cache
            if (!(mainBox.containsKey(
                "ProductPageData:${products![index].entityId}" ?? ""))) {
              precCacheProductPage(products![index].entityId.toString() ?? "");
            }
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.productPage,
                    arguments: getProductDataAttributeMap(
                      products![index].name ?? "",
                      products![index].entityId.toString() ?? "",
                    ),
                  );
                },
                child: ItemCatalogProductGrid(
                  product: products![index],
                  imageSize: AppSizes.deviceHeight * .2,
                  isSelected: false,
                ),
              ),
            );
          },
        ),
        BlocBuilder<ItemCardBloc, ItemCardState>(
          builder: (context, state) {
            return Visibility(
              visible: itemCardBloc.isLoadingAction,
              child: const Loader(),
            );
          },
        )
      ],
    );
  }
}
