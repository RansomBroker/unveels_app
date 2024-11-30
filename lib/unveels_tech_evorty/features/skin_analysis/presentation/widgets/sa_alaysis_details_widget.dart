import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_new/logic/get_product_utils/get_skin_concern.dart';
import 'package:test_new/logic/get_product_utils/repository/product_repository.dart';
import 'package:test_new/unveels_tech_evorty/features/skin_analysis/models/skin_analysis_model.dart';

import '../../../../shared/configs/asset_path.dart';
import '../../../../shared/configs/color_config.dart';
import '../../../../shared/configs/size_config.dart';
import 'sa_product_item_widget.dart';

class SAAnalysisDetailsWidget extends StatefulWidget {
  final String title;
  final List<SkinAnalysisModel> analysisResult;

  const SAAnalysisDetailsWidget({
    super.key,
    required this.title,
    required this.analysisResult,
  });

  @override
  State<SAAnalysisDetailsWidget> createState() =>
      _SAAnalysisDetailsWidgetState();
}

class _SAAnalysisDetailsWidgetState extends State<SAAnalysisDetailsWidget> {
  final Dio dio = Dio();

  List<ProductData>? products;
  bool _isLoading = false;
  final ProductRepository productRepository = ProductRepository();

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      String? skinConcernId = getSkinConcernByLabel(widget.title);
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
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    int score = SkinAnalysisModel.getScoreByCategory(
            widget.analysisResult, widget.title)
        .toInt();
    String scoreType = score < 40
        ? "Low"
        : score < 70
            ? "Moderate"
            : "High";
    Color scoreColor = score < 40
        ? Colors.green
        : score < 70
            ? Colors.yellow
            : Colors.red;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.horizontalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                height: 40,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    IconPath.chevronDown,
                    height: 24,
                    width: 24,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Detected",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                "Forehead: Mild spots observed, likely due to sun exposure.\nCheeks: A few dark spots noted on both cheeks, possibly post-inflammatory hyperpigmentation",
                style: TextStyle(
                  fontSize: 11,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Description",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                SkinAnalysisModel.getDescriptionByCategory(widget.title),
                style: const TextStyle(
                  fontSize: 11,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Severity",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "$scoreType $score%",
                style: TextStyle(
                  fontSize: 11,
                  color: scoreColor,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Recommended products",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        _isLoading
            ? SizedBox(
                height: 130,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
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
                    final product = products![index];

                    return Padding(
                      padding: EdgeInsets.only(
                        left: isFirst ? SizeConfig.horizontalPadding : 0,
                        right: isEnd ? SizeConfig.horizontalPadding : 0,
                      ),
                      child: SAProductItemWidget(product: product),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
