/*
 *
  

 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/configuration/unvells_theme.dart';
import '../../../app_widgets/app_tool_bar.dart';
import '../../../app_widgets/loader.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/app_string_constant.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/PreCacheApiHelper.dart';
import '../../../helper/app_localizations.dart';
import '../../../models/categoryPage/category_page_response.dart';
import '../../../network_manager/api_client.dart';
import '../../category/widgets/category_products.dart';
import '../../category/widgets/category_tile.dart';
import '../bloc/category_listing_bloc.dart';
import '../bloc/category_listing_events.dart';
import '../bloc/category_listing_repository.dart';
import '../bloc/category_listing_states.dart';

class SubCategoryView extends StatefulWidget {
  int? id;
  String? name;

  SubCategoryView({this.name, this.id, Key? key}) : super(key: key);

  @override
  State<SubCategoryView> createState() => _SubCategoryViewState();
}

class _SubCategoryViewState extends State<SubCategoryView> {
  CategoryListingBloc? categoryScreenBloc;
  bool isLoading = true;
  CategoryPageResponse? _categoryPageResponse;
  int _selectedIndex = 0;
  bool? isSubCategoryLoading;
  AppLocalizations? _localizations;

  @override
  void initState() {
    categoryScreenBloc = context.read<CategoryListingBloc>();
    categoryScreenBloc?.add(CategoryListingDataFetchEvent(widget.id ?? 0));
    categoryScreenBloc?.emit(CategoryListingInitial());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appToolBar(widget.name ?? "", context),
      body: _buildMainUi(),
    );
  }

  Widget _buildMainUi() {
    return BlocBuilder<CategoryListingBloc, CategoryListingState>(
      builder: (context, currentState) {
        if (currentState is CategoryListingInitial) {
          isLoading = true;
        } else if (currentState is CategoryListingSuccess) {
          isLoading = false;
          _categoryPageResponse = currentState.categoryPageResponse;
        } else if (currentState is CategoryListingError) {
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
      child: (isLoading == true)
          ? SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Loader(),
            )
          : subcategoryListView(),
    );
  }

  Widget subcategoryListView() {
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: width,
            child: (_categoryPageResponse?.categories ?? []).isNotEmpty
                ? Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                          _categoryPageResponse?.categories?.length ?? 0,
                          itemBuilder: (context, int index) {
                            //  pre-cache
                            precCacheCategoryPage(_categoryPageResponse?.categories?[index].id ?? 0);
                            return GestureDetector(
                              onTap: (){
                                if(_categoryPageResponse?.categories?[index].hasChildren??false ){
                                  Navigator.push(context, MaterialPageRoute(builder: (_){
                                    return BlocProvider(create: (context)=>CategoryListingBloc(
                                      repository: CategoryListingRepositoryImp(),
                                    ),
                                      child:SubCategoryView(name: _categoryPageResponse?.categories?[index].name,id:  _categoryPageResponse?.categories?[index].id??0,),);
                                  }));
                                }else{
                                  Navigator.pushNamed(context, AppRoutes.catalog,
                                      arguments: getCatalogMap(
                                        _categoryPageResponse?.categories?[index].id.toString()??"",
                                        _categoryPageResponse?.categories?[index].name ?? "",
                                        BUNDLE_KEY_CATALOG_TYPE_CATEGORY,
                                        false,
                                      ));

                                }

                              },
                              child: Container(
                                color: Theme.of(context).cardColor,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(_categoryPageResponse
                                          ?.categories?[index].name ??
                                          "",style: Theme.of(context).textTheme.bodyMedium,
                                      ),
                                      trailing: Icon(Icons.arrow_forward_ios_outlined,size: 12,),
                                    ),
                                    Divider(height: AppSizes.size1,),
                                  ],
                                )
                              ),
                            );
                          }),

                      SizedBox(height: AppSizes.spacingTiny),
                      categoryProducts()
                    ],
                  )
                : categoryProducts(),
          ),
        ],
      ),
    );
  }

  //=========Showing products for selected category=======//
  Widget categoryProducts() {
    return buildCategoryProducts(_categoryPageResponse?.productList ?? [],
        context, isSubCategoryLoading, widget.id.toString(), widget.name ?? "");
  }
}
