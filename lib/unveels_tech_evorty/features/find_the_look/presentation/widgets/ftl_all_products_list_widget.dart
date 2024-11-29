import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_new/unveels_tech_evorty/features/find_the_look/presentation/pages/ftl_live_page.dart';
import 'package:test_new/unveels_tech_evorty/features/find_the_look/presentation/widgets/ftl_product_by_category.dart';

import '../../../../shared/configs/asset_path.dart';
import '../../../../shared/configs/size_config.dart';
import '../../../../shared/extensions/product_tab_parsing.dart';
import '../../../../shared/widgets/buttons/button_widget.dart';
import '../cubit/product_cart/product_cart_cubit.dart';

class FTLAllProductsListWidget extends StatefulWidget {
  final Function() onBack;
  final Function() onTryNow;
  final List<FTLResult> categories;

  const FTLAllProductsListWidget({
    super.key,
    required this.onBack,
    required this.onTryNow,
    required this.categories,
  });

  @override
  State<FTLAllProductsListWidget> createState() =>
      _FTLAllProductsListWidgetState();
}

class _FTLAllProductsListWidgetState extends State<FTLAllProductsListWidget> {
  SmilarProductTab? _selectedTab;
  final List<String> _makeupCategories = [];
  final List<String> _accessoriesCategories = [];

  @override
  void initState() {
    super.initState();

    _init();
  }

  void _init() {
    _selectedTab = SmilarProductTab.smilarMakeup;

    for (var i = 0; i < widget.categories.length; i++) {
      FTLResult category = widget.categories[i];
      if (category.section == "makeup") {
        _makeupCategories.add(category.label);
      } else if (category.section == "accessories") {
        _accessoriesCategories.add(category.label);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.horizontalPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: widget.onBack,
                  child: const Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      IconPath.love,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset(
                      IconPath.cart,
                    ),
                  ],
                ),
              ],
            ),
          ),
          BlocBuilder<ProductCartCubit, ProductCartState>(
            builder: (context, state) {
              List<int> products = [];
              if (state is ProductCartLoaded) {
                products = state.products;
              }

              if (products.isEmpty) {
                return const SizedBox.shrink();
              }

              return SizedBox(
                height: 90,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.24),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: ListView.separated(
                    itemCount: products.length,
                    shrinkWrap: true,
                    primary: false,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 10,
                      );
                    },
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 50,
                        width: 50,
                        child: Stack(
                          children: [
                            Image.asset(
                              ImagePath.productExample,
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              right: -3,
                              top: -3,
                              child: GestureDetector(
                                onTap: _onRemoveFromCart,
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.horizontalPadding,
            ),
            child: Row(
              children: [
                _SmilarTabItemWidget(
                  tab: SmilarProductTab.smilarMakeup,
                  isSelected: _selectedTab == SmilarProductTab.smilarMakeup,
                  onTabSelected: _onTabSelected,
                ),
                _SmilarTabItemWidget(
                  tab: SmilarProductTab.smilarAccessories,
                  isSelected:
                      _selectedTab == SmilarProductTab.smilarAccessories,
                  onTabSelected: _onTabSelected,
                ),
              ],
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: _selectedTab == SmilarProductTab.smilarMakeup ? 0 : 1,
              children: [
                ListView.separated(
                  itemCount: _makeupCategories.length,
                  shrinkWrap: true,
                  primary: false,
                  scrollDirection: Axis.vertical,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 15,
                    );
                  },
                  itemBuilder: (context, index) {
                    String category = _makeupCategories[index];
                    return FtlProductByCategory(
                        onAddToCart: () {},
                        onSelectProduct: () {},
                        sectionTitle: category);
                  },
                ),
                ListView.separated(
                  itemCount: _accessoriesCategories.length,
                  shrinkWrap: true,
                  primary: false,
                  scrollDirection: Axis.vertical,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 15,
                    );
                  },
                  itemBuilder: (context, index) {
                    String category = _accessoriesCategories[index];
                    return FtlProductByCategory(
                        onAddToCart: () {},
                        onSelectProduct: () {},
                        sectionTitle: category);
                  },
                ),
              ],
            ),
          ),
          BlocBuilder<ProductCartCubit, ProductCartState>(
            builder: (context, state) {
              List<int> products = [];
              if (state is ProductCartLoaded) {
                products = state.products;
              }

              if (products.isEmpty) {
                return const SizedBox.shrink();
              }

              return Container(
                color: Colors.black,
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: SizeConfig.horizontalPadding,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ButtonWidget(
                        text: 'TRY NOW',
                        backgroundColor: Colors.black,
                        borderColor: Colors.white,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        onTap: widget.onTryNow,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ButtonWidget(
                        text: 'ADD ALL TO CART',
                        backgroundColor: Colors.white,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                        onTap: _onAddAllToCart,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _onTabSelected(SmilarProductTab tab) {
    setState(() {
      _selectedTab = tab;
    });
  }

  void _onAddToCart() {
    // add product to cart
    BlocProvider.of<ProductCartCubit>(context).addProduct();
  }

  void _onRemoveFromCart() {
    // remove product from cart
    BlocProvider.of<ProductCartCubit>(context).removeProduct();
  }

  void _onSelectProduct() {
    // TODO: select product
  }

  void _onAddAllToCart() {
    // TODO: add all to cart
  }
}

class _SmilarTabItemWidget extends StatelessWidget {
  final SmilarProductTab tab;
  final bool isSelected;
  final Function(SmilarProductTab) onTabSelected;

  const _SmilarTabItemWidget({
    required this.tab,
    required this.isSelected,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          onTabSelected(tab);
        },
        child: Container(
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.black,
            border: Border.all(
              color: Colors.white,
            ),
          ),
          child: Text(
            tab.title.toUpperCase(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
