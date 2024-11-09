/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/configuration/unvells_theme.dart';
import 'package:test_new/unvells/screens/category_listing/view/sub_category_view.dart';
import '../../app_widgets/app_bar.dart';
import '../../app_widgets/image_view.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_routes.dart';
import '../../constants/app_string_constant.dart';
import '../../constants/arguments_map.dart';
import '../../constants/global_data.dart';
import '../../helper/PreCacheApiHelper.dart';
import '../../helper/app_localizations.dart';
import '../../helper/bottom_sheet_helper.dart';
import '../../helper/utils.dart';
import '../../models/homePage/home_screen_model.dart';
import 'package:test_new/unvells/models/categoryPage/category.dart';

import 'bloc/category_listing_bloc.dart';
import 'bloc/category_listing_repository.dart';

class CategorySearchScreen extends StatefulWidget {
  const CategorySearchScreen({Key? key}) : super(key: key);

  @override
  State<CategorySearchScreen> createState() => _CategorySearchScreenState();
}

class _CategorySearchScreenState extends State<CategorySearchScreen> {
  HomePageData? homePageData;
  AppLocalizations? _localizations;

  @override
  void initState() {
    homePageData = GlobalData.homePageData;
    // TODO: implement initState
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        Utils.getStringValue(context, AppStringConstant.categories), context,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.search);
              },
              icon: Icon(Icons.search,
                color: Theme.of(context).colorScheme.onPrimary,
              )),
          IconButton(
              onPressed: () {
                notificationBottomModelSheet(context);
              },
              icon: Icon(Icons.notifications,
                color: Theme.of(context).colorScheme.onPrimary,)
          )
        ],),
      body: categoryView(context, homePageData?.categories ?? []),
    );
  }
}

Widget categoryGridView(BuildContext context, List<Category>? carousel) {
  return Column(
    children: [
      SizedBox(height: 8,),
      GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: MediaQuery.of(context).size.height/8.2+8
            // childAspectRatio:MediaQuery.of(context).size.height/(MediaQuery.of(context).size.height-135)
          ),
          itemCount: (carousel?.length ?? 0),
          itemBuilder: (BuildContext context, int itemIndex) {
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return BlocProvider(
                    create: (context) => CategoryListingBloc(
                      repository: CategoryListingRepositoryImp(),
                    ),
                    child: SubCategoryView(
                      name: carousel?[itemIndex].name,
                      id: carousel?[itemIndex].id ?? 0,
                    ),
                  );
                }));
              },
              child: Column(
                children: [
                  Card(
                    elevation: 1,
                    shadowColor: AppColors.lightGray,
                    shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)
                    ) ,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Stack(
                      children: <Widget>[
                        Image.network(
                          carousel?[itemIndex].thumbnail ?? "",
                          fit: BoxFit.fill,
                          width:MediaQuery.of(context).size.width/3.15,
                          height:MediaQuery.of(context).size.height/8.2,
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 15.0, top: 8),
                          child: Text(
                            carousel?[itemIndex].name ?? "",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    ],
  );
}

Widget categoryView(BuildContext context, List<Category>? carousel) {
  return ListView.separated(
    shrinkWrap: true,
    itemBuilder: (ctx, index) =>
        InkWell(
          onTap: () {
            if (carousel?[index].hasChildren??false) {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return BlocProvider(
                  create: (context) => CategoryListingBloc(
                    repository: CategoryListingRepositoryImp(),
                  ),
                  child: SubCategoryView(
                    name: carousel?[index].name,
                    id: carousel?[index].id ?? 0,
                  ),
                );
              }));
            } else {
              Navigator.pushNamed(context, AppRoutes.catalog,
                  arguments: getCatalogMap(
                    carousel?[index].id.toString()??"",
                    carousel?[index].name ?? "",
                    BUNDLE_KEY_CATALOG_TYPE_CATEGORY,
                    false,
                  ));

            }
          },
          child: categoryItem(context, carousel?[index]),
        ),
    separatorBuilder: (ctx, index) {
      precCacheCategoryPage(carousel?[index].id ?? 0);
      return SizedBox(
        height: AppSizes.size4,
        child: Divider(),
      );
    },
    itemCount: (carousel?.length ?? 0),
  );
}

Widget categoryItem(BuildContext context, Category? item) {
  return Container(
    padding: const EdgeInsets.only(
        top: AppSizes.size8,
        left: AppSizes.size8,
        right: AppSizes.size8),
    margin: const EdgeInsets.only(bottom: AppSizes.size1),
    color: Theme.of(context).cardColor,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: AppSizes.categoryListingImageSize,
              width: AppSizes.categoryListingImageSize,
              child: ImageView(
                url: item?.thumbnail,
                height: AppSizes.categoryListingImageSize,
                width: AppSizes.categoryListingImageSize,
              ),
            ),
            const SizedBox(width: AppSizes.paddingGeneric),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                      item?.name.toString() ?? " ",
                      style: Theme.of(context).textTheme.bodyLarge
                    // .copyWith(fontSize: AppSizes.textSizeLarge, color: AppColors.textColorPrimary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
