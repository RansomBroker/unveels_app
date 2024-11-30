import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:test_new/logic/get_product_utils/get_skin_concern.dart';
import 'package:test_new/logic/get_product_utils/repository/product_repository.dart';
import 'package:test_new/unveels_tech_evorty/features/skin_analysis/models/skin_analysis_model.dart';

import '../../../../shared/configs/color_config.dart';
import '../../../../shared/configs/size_config.dart';
import '../../../../shared/widgets/buttons/button_widget.dart';
import 'sa_product_item_widget.dart';

class SAAnalysisResultsWidget extends StatefulWidget {
  final Function() onViewAll;
  final List<SkinAnalysisModel>? analysisResult;

  const SAAnalysisResultsWidget({
    super.key,
    required this.onViewAll,
    this.analysisResult,
  });

  @override
  State<SAAnalysisResultsWidget> createState() =>
      _SAAnalysisResultsWidgetState();
}

class _SAAnalysisResultsWidgetState extends State<SAAnalysisResultsWidget> {
  String? _selectedCategory;
  final List<String> _categories = SkinAnalysisModel.categories;
  final Dio dio = Dio();
  List<ProductData>? products;
  bool _isLoading = false;
  final ProductRepository productRepository = ProductRepository();

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      String? skinConcernId = getSkinConcernByLabel(_selectedCategory!);
      var dataResponse =
          await productRepository.fetchProducts(skinConcern: skinConcernId);
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
  void initState() {
    super.initState();

    _init();
  }

  void _init() {
    _selectedCategory = _categories.first;
    fetchData();
  }

  SkinAnalysisModel? getByClassId(int id) {
    return widget.analysisResult?.firstWhere((i) => i.classId == id);
  }

  SkinAnalysisModel? getByLabel(String label) {
    return widget.analysisResult?.firstWhere((i) => i.label == label);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 55,
          child: ListView.separated(
            itemCount: _categories.length,
            shrinkWrap: true,
            primary: false,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 8,
              );
            },
            itemBuilder: (context, index) {
              final category = _categories[index];
              final isSelected = _selectedCategory == category;
              final isFirst = index == 0;
              final isEnd = index == _categories.length - 1;

              return Padding(
                padding: EdgeInsets.only(
                  left: isFirst ? 8 : 0,
                  right: isEnd ? 8 : 0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (isSelected) ...[
                      Text(
                        "${SkinAnalysisModel.getScoreByCategory(widget.analysisResult ?? [], category).toStringAsFixed(0)}%",
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                    ButtonWidget(
                      text: category,
                      backgroundColor: isSelected ? null : Colors.transparent,
                      borderColor: Colors.white,
                      height: 20,
                      padding: const EdgeInsets.all(0),
                      borderRadius: BorderRadius.circular(99),
                      onTap: () {
                        setState(() {
                          _selectedCategory = category;
                        });
                        fetchData();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.horizontalPadding * 1.9,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Description",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 2,
              ),
              ReadMoreText(
                SkinAnalysisModel.getDescriptionByCategory(_selectedCategory!),
                trimMode: TrimMode.Line,
                trimLines: 3,
                colorClickableText: ColorConfig.primary,
                trimCollapsedText: 'More',
                trimExpandedText: 'Less',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                ),
                moreStyle: TextStyle(
                  fontSize: 11,
                  color: ColorConfig.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: widget.onViewAll,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: SizeConfig.horizontalPadding,
              ),
              child: const Text(
                "View All",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        _isLoading
            ? SizedBox(
                height: 130,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      color: Colors.white,
                      width: 86,
                      height: 86 * 0.65,
                    ),
                  ],
                ))
            : SizedBox(
                height: 130,
                child: ListView.separated(
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
                    final product = products?[index];

                    return Padding(
                      padding: EdgeInsets.only(
                        left: isFirst ? 8 : 0,
                        right: isEnd ? 8 : 0,
                      ),
                      child: SAProductItemWidget(product: product!),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
