/*
 *


 *
 * /
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/constants/app_routes.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/constants/global_data.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/screens/category/bloc/category_screen_bloc.dart';
import 'package:test_new/unvells/screens/category/bloc/category_screen_events.dart';
import 'package:test_new/unvells/screens/category/bloc/category_screen_states.dart';
import 'package:test_new/unvells/screens/category/widgets/category_banners.dart';
import 'package:test_new/unvells/screens/category/widgets/category_products.dart';
import 'package:test_new/unvells/screens/category/widgets/category_tile.dart';

import '../../app_widgets/app_bar.dart';
import '../../app_widgets/loader.dart';
import '../../constants/app_constants.dart';
import '../../helper/PreCacheApiHelper.dart';
import '../../helper/bottom_sheet_helper.dart';
import '../../models/categoryPage/category_page_response.dart';
import '../../models/homePage/home_screen_model.dart';
import '../category_listing/category_listing_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  CategoryScreenBloc? categoryScreenBloc;
  bool isLoading = true;
  HomePageData? homePageData;
  CategoryPageResponse? _categoryPageResponse;
  int _selectedIndex = 0;
  bool? isSubCategoryLoading;

  @override
  void initState() {
    homePageData = GlobalData.homePageData;
    categoryScreenBloc = context.read<CategoryScreenBloc>();
    categoryScreenBloc?.add(
        CategoryScreenDataFetchEvent(homePageData?.categories?[0].id ?? 0));
    categoryScreenBloc?.emit(CategoryScreenInitial());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        Utils.getStringValue(context, AppStringConstant.categories),
        context,
        textColor: Colors.white

      ),
      backgroundColor: Colors.black,

      body: _buildMainUi(),
    );
  }

  Widget _buildMainUi() {
    return BlocBuilder<CategoryScreenBloc, CategoryScreenState>(
      builder: (context, currentState) {
        if (currentState is CategoryScreenInitial) {
          isLoading = true;
        } else if (currentState is CategoryScreenSuccess) {
          isLoading = false;
          _categoryPageResponse = currentState.categoryPageResponse;
        } else if (currentState is CategoryScreenError) {
          isLoading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {});
        }
        return _buildUI();
      },
    );
  }

  Widget _buildUI() {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: CustomScrollView(

        slivers: [
          // SizedBox(),
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: _SliverAppBarDelegate(
              minHeight: 30.0,  // Minimum height when collapsed
              maxHeight: 40.0,  // Maximum height when expanded
              child: categoryListView(),
            ),
          ),
          SliverToBoxAdapter(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : subcategoryListView(),
          ),
        ],
      ),
    );
  }


  //========For Left (main) categories==========//
  Widget categoryListView() {
    return ListView.separated(
      // shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: (homePageData?.categories ?? []).length,
      // padding: EdgeInsets.all(14),
      itemBuilder: (BuildContext context, int index) {
        //unvells  pre-cache
        precCacheCategoryPage(homePageData?.categories?[index].id ?? 0);
        return InkWell(
            onTap: () {
              _categoryPageResponse?.productList = null;
              categoryScreenBloc?.add(CategoryScreenDataFetchEvent(
                  homePageData?.categories?[index].id ?? 0));
              categoryScreenBloc?.emit(CategoryScreenInitial());
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Container(
                decoration: BoxDecoration(
                  color: _selectedIndex == index
                      ?  AppColors.gold
                      : Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: _selectedIndex == index
                       ? AppColors.white
                        : AppColors.gold,
                    width: 2.5,)
                ),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                // width: AppSizes.deviceWidth * .1,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(homePageData?.categories?[index].name?.toUpperCase() ?? "",
                      textAlign: TextAlign.center,
                      style: KTextStyle.of(context).boldSixteen.copyWith(
                          color: _selectedIndex == index
                              ? AppColors.white
                              : Colors.black)

                      //
                      // _selectedIndex == index
                      //     ? Theme.of(context)
                      //         .textTheme
                      //         .bodyMedium
                      //         ?.copyWith(
                      //             fontSize: AppSizes.textSizeSmall,
                      //             color: Theme.of(context).iconTheme.color)
                      //     : Theme.of(context)
                      //         .textTheme
                      //         .bodyMedium
                      //         ?.copyWith(fontSize: AppSizes.textSizeSmall),
                      ),
                )));
      },
      separatorBuilder: (BuildContext context, int index) {
        return  const SizedBox(

          width: 5,
        );
      },

    );
  }

  //======For Right (sub) categories========//
  Widget subcategoryListView() {
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        if ((_categoryPageResponse?.smallBannerImage ?? []).isNotEmpty)
          ...[
            const SizedBox(height: 20,),
            CategoryBanners(
                (_categoryPageResponse?.smallBannerImage ?? [])),
          ],

        const SizedBox(height: 30,),
        SizedBox(
          width: width,
          child: (_categoryPageResponse?.categories ?? []).isNotEmpty
              ? Column(
                  children: [
                    CategoryTile(
                      subCategories: _categoryPageResponse?.categories,
                    ),
                    // const SizedBox(height: AppSizes.size15),
                    // categoryProducts()
                  ],
                )
              : categoryProducts(),
        ),
      ],
    );
  }

  //=========Showing products for selected category=======//
  Widget categoryProducts() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.size10),
      child: buildCategoryProducts(
          _categoryPageResponse?.productList ?? [],
          context,
          isSubCategoryLoading,
          homePageData?.categories?[_selectedIndex].id.toString(),
          homePageData?.categories?[_selectedIndex].name ?? ""),
    );
  }
}
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(covariant _SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
