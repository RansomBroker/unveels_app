import 'package:flutter/material.dart';
import 'package:test_new/logic/get_product_utils/repository/product_repository.dart';
import 'package:test_new/unveels_vto_project/common/component/vto_product_item.dart';
import 'package:test_new/unveels_vto_project/common/helper/constant.dart';

class VtoProductListView extends StatelessWidget {
  final List<ProductData>? products;
  final int? selectedProductId;
  final Function(ProductData)? onSelectedProduct;
  final bool isLoading;

  const VtoProductListView({
    super.key,
    this.products,
    this.selectedProductId,
    this.onSelectedProduct,
    this.isLoading = true,
  });

  Widget buildWidget() {
    if (isLoading) {
      return SizedBox(
          height: 135,
          child: Column(
            children: [
              Container(color: Colors.white, width: 100, height: 68),
            ],
          ));
    }

    if (products!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 135,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: products?.length ?? 0,
          separatorBuilder: (_, __) => Constant.xSizedBox12,
          itemBuilder: (context, index) {
            var product = products?[index];
            if (product != null) {
              return GestureDetector(
                onTap: () {
                  print(product.color);
                  if (onSelectedProduct != null) {
                    onSelectedProduct!(product);
                  }
                },
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: selectedProductId == product.id
                              ? const Color(0xFFFFD700)
                              : Colors.transparent),
                    ),
                    child: VtoProductItem(product: product)),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildWidget();
  }
}
