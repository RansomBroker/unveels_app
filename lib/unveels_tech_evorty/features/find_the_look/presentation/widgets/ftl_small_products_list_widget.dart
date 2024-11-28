import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_new/logic/get_product_utils/get_product_types.dart';
import 'package:test_new/logic/get_product_utils/repository/product_repository.dart';
import 'package:test_new/unveels_tech_evorty/features/find_the_look/presentation/pages/ftl_live_page.dart';

import '../../../../shared/widgets/buttons/button_widget.dart';
import '../../../../shared/widgets/products/small_product_item_widget.dart';

enum ProductType { makeup, accessories }

class FTLSmallProductsListWidget extends StatefulWidget {
  final Function() onViewAll;
  final List<FTLResult> categories;

  const FTLSmallProductsListWidget({
    super.key,
    required this.onViewAll,
    required this.categories,
  });

  @override
  State<FTLSmallProductsListWidget> createState() =>
      _FTLSmallProductsListWidgetState();
}

class _FTLSmallProductsListWidgetState
    extends State<FTLSmallProductsListWidget> {
  String? _selectedCategory;
  ProductType _productType = ProductType.makeup;
  final List<String> _makeupCategories = [];
  final List<String> _accessoriesCategories = [];

  @override
  void initState() {
    super.initState();

    _init();
  }

  void _init() {
    for (var i = 0; i < widget.categories.length; i++) {
      FTLResult category = widget.categories[i];
      if (category.section == "makeup") {
        _makeupCategories.add(category.label);
      } else if (category.section == "accessories") {
        _accessoriesCategories.add(category.label);
      }
    }
    fetchData();
  }

  final Dio dio = Dio();
  List<ProductData>? products;
  bool _isLoading = false;
  final ProductRepository productRepository = ProductRepository();

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      String? key = getProductKeyByLabel(_selectedCategory!);
      var dataResponse = await productRepository.fetchProducts(
          // texture: textures!.isEmpty ? null : textures.join(","),
          productType: key,
          productTypes: getProductTypeByLabel(key!, _selectedCategory!));
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

  Widget makeupOrAccessoriesChoice() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _productType = ProductType.makeup;
                    });
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Text(
                      'Make Up',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.luxuriousRoman(
                          color: Colors.white,
                          fontSize: 16,
                          shadows: _productType == ProductType.makeup
                              ? [
                                  const BoxShadow(
                                    offset: Offset(0, 0),
                                    color: Colors.yellow,
                                    spreadRadius: 0,
                                    blurRadius: 10,
                                  )
                                ]
                              : null),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                height: 20,
                width: 1,
                color: Colors.white,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _productType = ProductType.accessories;
                    });
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Text(
                      'Accessories',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.luxuriousRoman(
                          color: Colors.white,
                          fontSize: 16,
                          shadows: ProductType.accessories == _productType
                              ? [
                                  const BoxShadow(
                                    offset: Offset(0, 0),
                                    color: Colors.yellow,
                                    spreadRadius: 0,
                                    blurRadius: 10,
                                  )
                                ]
                              : null),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(thickness: 1, color: Colors.white)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        makeupOrAccessoriesChoice(),
        SizedBox(
          height: 30,
          child: ListView.separated(
            itemCount: _productType == ProductType.makeup ? _makeupCategories.length :_accessoriesCategories.length,
            shrinkWrap: true,
            primary: false,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 15,
              );
            },
            itemBuilder: (context, index) {
              final category = _productType == ProductType.makeup  ? _makeupCategories[index] :_accessoriesCategories[index];
              final isSelected = _selectedCategory == category;
              final isFirst = index == 0;
              final isEnd = index == widget.categories.length - 1;

              return Padding(
                padding: EdgeInsets.only(
                  left: isFirst ? 14 : 0,
                  right: isEnd ? 14 : 0,
                ),
                child: ButtonWidget(
                  text: category,
                  backgroundColor: isSelected ? null : Colors.transparent,
                  borderColor: Colors.white,
                  padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                  borderRadius: BorderRadius.circular(99),
                  onTap: () {
                    setState(() {
                      _selectedCategory = category;
                    });
                    fetchData();
                  },
                  style: GoogleFonts.lato(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: widget.onViewAll,
            child: const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 14,
              ),
              child: Text(
                "View All",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 130,
          child: _isLoading
              ? Column(
                  children: [
                    Container(
                      height: 68,
                      width: 100,
                      margin: const EdgeInsets.symmetric(horizontal: 14),
                      color: Colors.white,
                    ),
                  ],
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
                    final product = products?[index];
                    final isFirst = index == 0;
                    final isEnd = index == 10 - 1;

                    return Padding(
                      padding: EdgeInsets.only(
                        left: isFirst ? 14 : 0,
                        right: isEnd ? 14 : 0,
                      ),
                      child: SmallProductItemWidget(product: product),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
