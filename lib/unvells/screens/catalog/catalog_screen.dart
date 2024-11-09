/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/app_widgets/flux_image.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/models/catalog/layered_data.dart';
import 'package:test_new/unvells/models/catalog/sorting_data.dart';
import 'package:test_new/unvells/models/categoryPage/product_tile_data.dart';
import 'package:test_new/unvells/models/homePage/home_page_banner.dart';
import 'package:test_new/unvells/screens/catalog/widget/catalog_grid_view.dart';
import 'package:test_new/unvells/screens/catalog/widget/catalog_listview.dart';
import 'package:test_new/unvells/screens/catalog/widget/filter_bottom_sheet.dart';
import 'package:test_new/unvells/screens/catalog/widget/sort_bottom_sheet.dart';

import '../../app_widgets/app_alert_message.dart';
import '../../app_widgets/app_tool_bar.dart';
import '../../app_widgets/loader.dart';
import '../../app_widgets/lottie_animation.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_routes.dart';
import '../../constants/app_string_constant.dart';
import '../../constants/arguments_map.dart';
import '../../helper/utils.dart';
import '../../models/catalog/catalog_model.dart';
import '../../models/catalog/request/catalog_product_request.dart';
import '../home/widgets/home_slider.dart';
import 'bloc/catalog_screen_bloc.dart';
import 'bloc/catalog_screen_event.dart';
import 'bloc/catalog_screen_state.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen(this.arguments, {Key? key}) : super(key: key);

  final Map<String, dynamic> arguments;

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  late bool _isGrid, _loading, _sortApplied, _filterApplied;
  CatalogScreenBloc? _bloc;
  CatalogModel? _model;
  late List<Banners> _banners;
  List<ProductTileData> _products = [];
  late List<SortingData> _sorts;
  Map<String, String> _sortData = {};
  Map<String, String> _selectedFilterDataItem = {};
  late List<Map<String, String>> _selectedFilterData;
  late List<LayeredData> _filterGroups;
  late ScrollController _scrollController;
  late CatalogProductRequest _request;
  late int _page;
  SortingData? _sort;
  String? label;
  bool showFilterOption = true;
  bool isFromPagination = false;
  List<String>? selectedFiltersLabel = [];

  @override
  void initState() {
    label = widget.arguments[catalogNameKey];
    _isGrid = true;
    _loading = true;
    _sortApplied = false;
    _filterApplied = false;
    _page = 1;
    _banners = [];
    _products = [];
    _sorts = [];
    _sortData = {};
    _selectedFilterData = [];
    _selectedFilterDataItem = {};
    _filterGroups = [];
    _scrollController = ScrollController()..addListener(setupPagination);
    _bloc = context.read<CatalogScreenBloc>();
    _callAPI();
    super.initState();
  }

  setupPagination() {
    if (_scrollController.hasClients &&
        _scrollController.position.maxScrollExtent ==
            _scrollController.offset) {
      if (hasMoreData()) {
        _page += 1;
        _callAPI();
        isFromPagination = true;
      }
    }
  }

  _callAPI() {
    // var home = widget.arguments[fromHomePageKey];
    _request = CatalogProductRequest(
      page: _page,
      id: (widget.arguments[catalogIdKey ?? ""]).toString(),
      category_id: (widget.arguments[categoryIdKey ?? ""]).toString(),
      type: widget.arguments[catalogTypeKey],
      sortData: _sortData,
      filterData: _selectedFilterData,
    );
    print(
        "TEST_LOG =_callAPI==>prevSelectedFilterData==>  ${_selectedFilterData} ");
    print(
        "TEST_LOG =_callAPI==>selectedFiltersLabel==>  ${selectedFiltersLabel} ");
    _bloc?.add(FetchCatalogEvent(_request));
    label = widget.arguments[catalogNameKey];
  }

  bool hasMoreData() {
    var total = 0;
    if (_model != null) {
      total = total = _model?.totalCount ?? 0;
    } else {
      total = _model?.totalCount ?? 0;
    }
    return (total > _products.length && !_loading);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        // elevation: .5,
        leading: Padding(
          padding: const EdgeInsetsDirectional.only(start: 20),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        centerTitle: true,

        title: Text(
          label == null
              ? Utils.getStringValue(context, AppStringConstant.products)
              : label ?? "",
          style: KTextStyle.of(context).boldSixteen,
        ),
        // title: Html(
        //   data: widget.arguments[productNameKey] ?? "",
        //   style: {
        //     "body": Style(
        //       fontSize:  FontSize(AppSizes.textSizeLarge),
        //       color: Theme.of(context).brightness == Brightness.dark
        //           ? AppColorsDark.textColorPrimary
        //           : AppColors.textColorPrimary,
        //     ),
        //   },
        // ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.sort,
              color: _sortApplied ? Colors.red : Colors.black,
            ),
            onPressed: () {
              if (_sorts.isEmpty == true) {
                WidgetsBinding.instance?.addPostFrameCallback((_) {
                  AlertMessage.showWarning(
                      Utils.getStringValue(
                          context, AppStringConstant.sortOptionsNotAvailable),
                      context);
                });
                return;
              }
              showModalBottomSheet(
                context: context,
                builder: (ctx) => SortBottomSheet(
                  _sorts,
                  (sort) {
                    setState(() {});
                    Navigator.of(context).pop();
                    _sort = sort;
                    _sortData["code"] = sort?.code.toString() ?? "";
                    _sortData["direction"] = sort?.direction.toString() ?? "";
                    _page = 1;
                    _products = [];
                    _callAPI();
                    _sortApplied = true;
                  },
                  selected: _sort,
                ),
              );
            },
          ),
          IconButton(
              onPressed: () {
                if (_filterGroups.isEmpty == true && _filterApplied == false) {
                  WidgetsBinding.instance?.addPostFrameCallback((_) {
                    AlertMessage.showWarning(
                        Utils.getStringValue(context,
                            AppStringConstant.filterOptionsNotAvailable),
                        context);
                  });
                  return;
                }
                showModalBottomSheet(
                  context: context,
                  builder: (ctx) => FilterBottomSheet(
                    _filterGroups,
                    () {
                      print("TEST_LOG");
                      setState(() {});
                      _selectedFilterData = [];
                      selectedFiltersLabel = [];
                      Navigator.of(context).pop();
                      for (var element in _filterGroups) {
                        element.options?.forEach((filter) {
                          if (filter.selected == true) {
                            _selectedFilterDataItem["code"] =
                                "\"${element.code}\"";
                            _selectedFilterDataItem["value"] =
                                "\"${filter.id}\"";
                            _selectedFilterData.add(_selectedFilterDataItem);
                            selectedFiltersLabel
                                ?.add("${element.label}: ${filter.label}");
                          }
                        });
                      }
                      _page = 1;
                      _products = [];
                      _callAPI();

                      _filterApplied = _selectedFilterData.isNotEmpty;
                    },
                    _selectedFilterData,
                    selectedFiltersLabel: selectedFiltersLabel,
                  ),
                );
              },
              icon: FluxImage(
                imageUrl: "assets/icons/filter.svg",
                color: _filterApplied ? Colors.red : Colors.black,
              )),
        ],
      ),
      // appBar: appToolBar(
      //     label == null
      //         ? Utils.getStringValue(context, AppStringConstant.products)
      //         : label ?? "",
      //     context),
      body: BlocBuilder<CatalogScreenBloc, CatalogScreenState>(
        builder: (ctx, currentState) {
          if (currentState is CatalogInitialState) {
            if (!isFromPagination) {
              _loading = true;
            }
          } else if (currentState is CatalogFetchState) {
            _loading = false;
            isFromPagination = false;
            _model = currentState.model;
            if (_page == 1) {
              _sorts = _model?.sortingData ?? [];
              _filterGroups = _model?.layeredData ?? [];
              _products = _model?.productList ?? [];
              _banners = _model?.banners ?? [];
            } else {
              _products.addAll(_model?.productList ?? []);
            }
          } else if (currentState is ChangeViewState) {
            _isGrid = currentState.isGrid;
          } else if (currentState is CatalogErrorState) {
            _loading = false;
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(currentState.message ?? '', context);
            });
          }
          return buildUI();
        },
      ),
    );
  }

  Widget buildUI() {
    return Stack(
      children: [
        if (_products.isNotEmpty && (!_loading))
          NestedScrollView(
              floatHeaderSlivers: false,
              physics: const BouncingScrollPhysics(),
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  if (_banners.isNotEmpty)
                    SliverAppBar(
                      pinned: true,
                      floating: false,
                      elevation: 0,
                      toolbarHeight: 0,
                      collapsedHeight: null,
                      automaticallyImplyLeading: false,
                      expandedHeight: AppSizes.deviceWidth / 2 + 90,
                      flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.parallax,
                          background: Column(
                            children: <Widget>[
                              HomeSliders(_banners ?? [], false)
                            ],
                          )),
                      titleSpacing: AppSizes.size0,
                      primary: false,
                    ),
                ];
              },
              body: Scaffold(
                // appBar: AppBar(
                //   elevation: 0,
                //   leading: null,
                //   automaticallyImplyLeading: false,
                //   title: toolBarContainer(),
                // ),
                body: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: <Widget>[
                      Visibility(
                        visible: _products.isNotEmpty,
                        child: Expanded(child: getProductView()),
                      ),
                      Visibility(
                        visible: _products.isNotEmpty && isFromPagination,
                        child: Column(
                          children: [
                            const SizedBox(height: AppSizes.spacingGeneric),
                            SizedBox(
                              height: AppSizes.bottomProgressSize,
                              width: AppSizes.bottomProgressSize,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                            const SizedBox(height: AppSizes.spacingGeneric),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        Visibility(
          visible: (_products.isEmpty && (!_loading)),
          child: Center(
            child: LottieAnimation(
                lottiePath: AppImages.emptyOrderLottie,
                title: Utils.getStringValue(
                    context, AppStringConstant.noProductAvailable),
                subtitle: "",
                buttonTitle: Utils.getStringValue(
                    context, AppStringConstant.continueShopping),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.bottomTabBar, (route) => false);
                }),
          ),
        ),
        Visibility(visible: _loading, child: const Loader())
      ],
    );
  }

  Widget getProductView() {
    return _isGrid
        ? CatalogGridView(
            products: _products,
            controller: _scrollController,
          )
        : CatalogListView(
            products: _products,
            controller: _scrollController,
          );
  }

  Widget toolBarContainer() {
    return Container(
      color: Theme.of(context).cardColor,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          iconButton(
            Icons.sort,
            Utils.getStringValue(context, AppStringConstant.sort),
            () {
              if (_sorts.isEmpty == true) {
                WidgetsBinding.instance?.addPostFrameCallback((_) {
                  AlertMessage.showWarning(
                      Utils.getStringValue(
                          context, AppStringConstant.sortOptionsNotAvailable),
                      context);
                });
                return;
              }
              showModalBottomSheet(
                context: context,
                builder: (ctx) => SortBottomSheet(
                  _sorts,
                  (sort) {
                    Navigator.of(context).pop();
                    _sort = sort;
                    _sortData["code"] = sort?.code.toString() ?? "";
                    _sortData["direction"] = sort?.direction.toString() ?? "";
                    _page = 1;
                    _products = [];
                    _callAPI();
                    _sortApplied = true;
                  },
                  selected: _sort,
                ),
              );
            },
            _sortApplied,
          ),
          if (showFilterOption)
            iconButton(
              Icons.filter_alt_outlined,
              Utils.getStringValue(context, AppStringConstant.filter),
              () {
                if (_filterGroups.isEmpty == true && _filterApplied == false) {
                  WidgetsBinding.instance?.addPostFrameCallback((_) {
                    AlertMessage.showWarning(
                        Utils.getStringValue(context,
                            AppStringConstant.filterOptionsNotAvailable),
                        context);
                  });
                  return;
                }
                showModalBottomSheet(
                  context: context,
                  builder: (ctx) => FilterBottomSheet(
                    _filterGroups,
                    () {
                      print("TEST_LOG");
                      _selectedFilterData = [];
                      selectedFiltersLabel = [];
                      Navigator.of(context).pop();
                      for (var element in _filterGroups) {
                        element.options?.forEach((filter) {
                          if (filter.selected == true) {
                            _selectedFilterDataItem["code"] =
                                "\"${element.code}\"";
                            _selectedFilterDataItem["value"] =
                                "\"${filter.id}\"";
                            _selectedFilterData.add(_selectedFilterDataItem);
                            selectedFiltersLabel
                                ?.add("${element.label}: ${filter.label}");
                          }
                        });
                      }
                      _page = 1;
                      _products = [];
                      _callAPI();

                      _filterApplied = _selectedFilterData.isNotEmpty;
                    },
                    _selectedFilterData,
                    selectedFiltersLabel: selectedFiltersLabel,
                  ),
                );
              },
              _filterApplied,
            ),
          iconButton(
              _isGrid ? Icons.grid_view : Icons.list,
              _isGrid
                  ? Utils.getStringValue(context, AppStringConstant.grid)
                  : Utils.getStringValue(context, AppStringConstant.list), () {
            _bloc?.add(ChangeViewEvent(!_isGrid));
          }),
        ],
      ),
    );
  }

  Widget iconButton(IconData icon, String title, VoidCallback onPressed,
          [bool optional = false]) =>
      Expanded(
        child: Material(
          child: InkWell(
            onTap: onPressed,
            child: Container(
              color: Theme.of(context).cardColor,
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.size12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      icon,
                    ),
                    const SizedBox(width: AppSizes.size8),
                    Text(
                      title.toUpperCase(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    if (optional) const SizedBox(width: AppSizes.size4),
                    if (optional)
                      Container(
                        height: AppSizes.size8,
                        width: AppSizes.size8,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(AppSizes.size4),
                          ),
                          color: Colors.red,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
