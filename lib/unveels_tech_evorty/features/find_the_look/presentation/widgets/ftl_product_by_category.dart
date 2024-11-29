import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test_new/logic/get_product_utils/get_product_types.dart';
import 'package:test_new/logic/get_product_utils/repository/product_repository.dart';
import 'package:test_new/unveels_tech_evorty/shared/configs/size_config.dart';
import 'package:test_new/unveels_tech_evorty/shared/widgets/products/product_item_widget.dart';

class FtlProductByCategory extends StatefulWidget {
  final dynamic Function() onAddToCart;
  final dynamic Function() onSelectProduct;
  final String sectionTitle;

  const FtlProductByCategory({
    super.key,
    required this.onAddToCart,
    required this.onSelectProduct,
    required this.sectionTitle,
  });

  @override
  State<FtlProductByCategory> createState() => _FtlProductByCategoryState();
}

class _FtlProductByCategoryState extends State<FtlProductByCategory> {
  final Dio dio = Dio();
  List<ProductData>? products;
  bool _isLoading = false;
  final ProductRepository productRepository = ProductRepository();

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      String? key = getProductKeyByLabel(widget.sectionTitle);
      var dataResponse = await productRepository.fetchProducts(
          // texture: textures!.isEmpty ? null : textures.join(","),
          productType: key,
          productTypes: getProductTypeByLabel(key!, widget.sectionTitle));

      setState(() {
        products = dataResponse;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.horizontalPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.sectionTitle,
                  style: const TextStyle(
                    color: Color(0xFFE6E5E3),
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const Text(
                  "View All",
                  style: TextStyle(
                    color: Color(0xFFE6E5E3),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 215,
            child: _isLoading
                ? Padding(
                    padding: EdgeInsets.only(
                      left: SizeConfig.horizontalPadding,
                      right: SizeConfig.horizontalPadding,
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 137,
                          height: 137,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    itemCount: products?.length ?? 0,
                    shrinkWrap: true,
                    primary: false,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 10,
                      );
                    },
                    itemBuilder: (context, index) {
                      final isFirst = index == 0;
                      final isEnd = index == 10 - 1;

                      return Padding(
                        padding: EdgeInsets.only(
                          left: isFirst ? SizeConfig.horizontalPadding : 0,
                          right: isEnd ? SizeConfig.horizontalPadding : 0,
                        ),
                        child: ProductItemWidget(
                          product: products![index],
                          height: 215,
                          width: 137,
                          onAddToCart: widget.onAddToCart,
                          onSelect: widget.onSelectProduct,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
