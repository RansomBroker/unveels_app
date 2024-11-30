import 'package:flutter/material.dart';

import '../../../../shared/configs/size_config.dart';
import '../../../skin_tone_finder/skin_tone_product_model.dart';
import '../../face_analyzer_model.dart';
import '../../look_product_model.dart';
import 'pf_product_item_widget.dart';

class PfRecommendationsAnalysisWidget extends StatelessWidget {
  const PfRecommendationsAnalysisWidget({
    super.key,
    required this.resultDataParsed,
    required this.isLoadingParfume,
    required this.parfumeData,
    required this.isLoadingLip,
    required this.lipData,
    required this.isLoadingAcc,
    required this.accData,
    required this.isLoadLook,
    required this.lookData,
  });
  final List<FaceAnalyzerModel> resultDataParsed;
  final bool isLoadingParfume;
  final SkinToneProductModel parfumeData;
  final bool isLoadingLip;
  final SkinToneProductModel lipData;
  final bool isLoadingAcc;
  final SkinToneProductModel accData;
  final bool isLoadLook;
  final LookPacketModel lookData;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProductItemWidget(
            title: "Perfumes Recommendations",
            productList: parfumeData,
            isLoading: isLoadingParfume,
          ),
          SizedBox(
            height: 30,
          ),
          _ProductItemWidget(
            title: "Look Recommendations",
            description:
                "A bold red lipstick and defined brows, mirror your strong, vibrant personality",
            productList: parfumeData,
            lookModel: lookData,
            profile: resultDataParsed
                    .where((e) => e.name == "Personality Finder")
                    .first
                    .outputLabel ??
                '-',
            isLoading: isLoadLook,
          ),
          SizedBox(
            height: 30,
          ),
          _ProductItemWidget(
            title: "Lip Color Recommendations",
            description: "The best lip color for you are orange shades",
            productList: lipData,
            isLoading: isLoadingLip,
          ),
          SizedBox(
            height: 30,
          ),
          _ProductItemWidget(
            title: "Accessories Recommendations",
            productList: accData,
            isLoading: isLoadingAcc,
          ),
        ],
      ),
    );
  }
}

class _ProductItemWidget extends StatelessWidget {
  final String title;
  final String? description;

  final SkinToneProductModel productList;
  final LookPacketModel? lookModel;
  final bool isLoading;
  final String? profile;
  const _ProductItemWidget(
      {required this.title,
      this.description,
      this.profile,
      this.lookModel,
      required this.productList,
      required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.horizontalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (description != null) ...[
                const SizedBox(
                  height: 6,
                ),
                Text(
                  description!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 242,
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : lookModel != null
                  ? lookModel!.profiles!
                          .where((e) => e.tryOnUrl!.contains(profile ?? '-'))
                          .isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.only(
                            left: SizeConfig.horizontalPadding,
                            right: SizeConfig.horizontalPadding,
                          ),
                          child: PFProductItemWidget(
                            lookData: lookModel!.profiles
                                ?.where(
                                    (e) => e.tryOnUrl!.contains(profile ?? '-'))
                                .first,
                          ),
                        )
                      : Center(
                          child: Text('No Product'),
                        )
                  : productList.items == null
                      ? Center(
                          child: Text('No Product'),
                        )
                      : productList.items!.isEmpty
                          ? Center(
                              child: Text('No Product'),
                            )
                          : ListView.separated(
                              itemCount: productList.items?.length ?? 0,
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

                                return Padding(
                                  padding: EdgeInsets.only(
                                    left: isFirst
                                        ? SizeConfig.horizontalPadding
                                        : 0,
                                    right: isEnd
                                        ? SizeConfig.horizontalPadding
                                        : 0,
                                  ),
                                  child: PFProductItemWidget(
                                    productData: productList.items![index],
                                  ),
                                );
                              },
                            ),
        ),
      ],
    );
  }
}
