/*
 *


 *
 * /
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/screens/subcategory/widgets/subcategory_list_item.dart';
import 'package:test_new/unvells/screens/subcategory/widgets/subcategory_product.dart';

import '../../app_widgets/app_bar.dart';
import '../../app_widgets/loader.dart';
import '../../constants/app_string_constant.dart';
import '../../constants/arguments_map.dart';
import '../../helper/utils.dart';
import '../../models/categoryPage/category_page_response.dart';
import 'bloc/subcategory_screen_bloc.dart';
import 'bloc/subcategory_screen_events.dart';
import 'bloc/subcategory_screen_state.dart';

class SubCategoryScreen extends StatefulWidget {

  const SubCategoryScreen(this.arguments, {Key? key}) : super(key: key);

  final Map<String, dynamic> arguments;

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  SubCategoryScreenBloc? subcategoryScreenBloc;
  bool isLoading = true;
  CategoryPageResponse? _categoryPageResponse;

  @override
  void initState() {
    subcategoryScreenBloc = context.read<SubCategoryScreenBloc>();
    subcategoryScreenBloc?.add(SubCategoryScreenDataFetchEvent(widget.arguments[categoryId]));
    subcategoryScreenBloc?.emit(SubCategoryScreenInitial());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
          widget.arguments[labelKey] == null ? Utils.getStringValue(context, AppStringConstant.categories) : widget.arguments[labelKey]  ?? "" , context),
      body: _buildMainUi(),
    );
  }

  Widget _buildMainUi() {
    return BlocBuilder<SubCategoryScreenBloc, SubCategoryScreenState>(
      builder: (context, currentState) {
        if (currentState is SubCategoryScreenInitial) {
          isLoading = true;
        } else if (currentState is SubCategoryScreenSuccess) {
          isLoading = false;
          _categoryPageResponse = currentState.categoryPageResponse;
          print("RESPONSE${currentState.categoryPageResponse}");
        } else if (currentState is SubCategoryScreenError) {
          isLoading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {});
        }
        return _buildUI();
      },
    );
  }

  Widget _buildUI() {
    return (isLoading == true)
        ? const Loader()
        : SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            categoryProducts(),

            SubCategoryListItem(
              subCategories: _categoryPageResponse?.categories,
            )
          ],
        )
    );
  }

  //=========Showing products for selected category=======//
  Widget categoryProducts() {
    return buildSubCategoryProducts(
        _categoryPageResponse?.productList ?? [],
        context,
        false,
        widget.arguments[categoryId].toString()??"",
        widget.arguments[labelKey]);
  }
}
