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
      ),
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
    return Container(
      color: Theme.of(context).cardColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          categoryListView(),
          (isLoading == true)
              ? SizedBox(
                  width: MediaQuery.of(context).size.width -
                      MediaQuery.of(context).size.width / 3.5,
                  child: const Loader(),
                )
              : subcategoryListView()
        ],
      ),
    );
  }

  //========For Left (main) categories==========//
  Widget categoryListView() {
    return Container(
      color: Colors.white,
      child: SizedBox(
        width: AppSizes.deviceWidth / 3.5,
        height: AppSizes.deviceHeight,
        child: ListView.separated(
          shrinkWrap: true,
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
                          ? const Color(0xffF5F5F5)
                          : Colors.transparent,
                    ),
                    height: AppSizes.deviceHeight * 0.06,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(homePageData?.categories?[index].name ?? "",
                          textAlign: TextAlign.center,
                          style: KTextStyle.of(context).boldTwelve.copyWith(
                              color: _selectedIndex == index
                                  ? AppColors.gold
                                  : null)

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
            return  Container(
              color: const Color(0x7FE3E4E5),
              height: 1,
              width: double.infinity,
            );
          },

        ),
      ),
    );
  }

  //======For Right (sub) categories========//
  Widget subcategoryListView() {
    var width = MediaQuery.of(context).size.width -
        MediaQuery.of(context).size.width / 3.5;
    return SingleChildScrollView(
      child: Container(
        color: const Color(0xffF9F9F9),
        child: Column(
          children: [
            if ((_categoryPageResponse?.smallBannerImage ?? []).isNotEmpty)
              SizedBox(
                width: width,
                child: CategoryBanners(
                    (_categoryPageResponse?.smallBannerImage ?? [])),
              ),
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
        ),
      ),
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
