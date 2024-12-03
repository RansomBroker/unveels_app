import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_new/unveels_tech_evorty/features/skin_analysis/models/skin_analysis_model.dart';
import 'dart:math';
import '../../../../shared/configs/asset_path.dart';
import '../../../../shared/configs/color_config.dart';
import '../../../../shared/configs/size_config.dart';
import '../../../../shared/widgets/lives/bottom_copyright_widget.dart';
import 'sa_alaysis_details_widget.dart';

class SAFullAnalysisResultsWidget extends StatefulWidget {
  final List<SkinAnalysisModel> analysisResult;
  const SAFullAnalysisResultsWidget({super.key, required this.analysisResult});

  @override
  State<SAFullAnalysisResultsWidget> createState() =>
      _SAFullAnalysisResultsWidgetState();
}

class _SAFullAnalysisResultsWidgetState
    extends State<SAFullAnalysisResultsWidget> {
  double getScoreByCategory(String category) {
    return SkinAnalysisModel.getScoreByCategory(
        widget.analysisResult, category);
  }

  int calculateSkinHealthScore(List<SkinAnalysisModel> skinAnalysisResult) {
    return SkinAnalysisModel.calculateSkinHealthScore(skinAnalysisResult);
  }

  int calculateAverageSkinProblemsScore(
      List<SkinAnalysisModel> skinAnalysisResult) {
    return SkinAnalysisModel.calculateAverageSkinProblemsScore(
        skinAnalysisResult);
  }

  int calculateAverageSkinConditionScore(
      List<SkinAnalysisModel> skinAnalysisResult) {
    return SkinAnalysisModel.calculateAverageSkinConditionScore(
        skinAnalysisResult);
  }

  int skinAge = 20 + Random().nextInt(64 - 20 + 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SingleChildScrollView(
        child: BottomCopyrightWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                titleSpacing: 0,
                leading: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    margin: const EdgeInsets.only(top: 8),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black26),
                    child: const Icon(Icons.arrow_back_ios_new_rounded,
                        color: Colors.white),
                  ),
                ),
                actions: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      margin: const EdgeInsets.only(top: 8),
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black26),
                      child: const Icon(Icons.close, color: Colors.white),
                    ),
                  ),
                ],
                elevation: 0,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.horizontalPadding,
                ),
                child: Column(
                  children: [
                    const Text(
                      "Analysis Results",
                      style: TextStyle(
                        color: ColorConfig.primary,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: const Color.fromARGB(255, 138, 95, 2)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.memory(
                              SkinAnalysisModel.getImageData(
                                  widget.analysisResult),
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _SummaryItemWidget(
                                iconPath: IconPath.connectionChart,
                                value:
                                    "Skin Health Score : ${calculateSkinHealthScore(widget.analysisResult)}%",
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              _SummaryItemWidget(
                                iconPath: IconPath.hasTagCircle,
                                value: "Skin Age: $skinAge",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        "Detected Skin Problems",
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: 130,
                            width: 130,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${calculateAverageSkinProblemsScore(widget.analysisResult)}%",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Skin Problems",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _CircularChartBarWidget(
                            height: 120,
                            width: 120,
                            color: ColorConfig.green,
                            value: getScoreByCategory("Texture"),
                          ),
                          _CircularChartBarWidget(
                            height: 145,
                            width: 145,
                            color: ColorConfig.purple,
                            value: getScoreByCategory("Dark Circles"),
                          ),
                          _CircularChartBarWidget(
                            height: 170,
                            width: 170,
                            color: ColorConfig.oceanBlue,
                            value: getScoreByCategory("Eye Bags"),
                          ),
                          _CircularChartBarWidget(
                            height: 195,
                            width: 195,
                            color: ColorConfig.blue,
                            value: getScoreByCategory("Wrinkles"),
                          ),
                          _CircularChartBarWidget(
                            height: 220,
                            width: 220,
                            color: ColorConfig.yellow,
                            value: getScoreByCategory("Pores"),
                          ),
                          _CircularChartBarWidget(
                            height: 245,
                            width: 245,
                            color: ColorConfig.taffi,
                            value: getScoreByCategory("Spots"),
                          ),
                          _CircularChartBarWidget(
                            height: 270,
                            width: 270,
                            color: ColorConfig.pink,
                            value: getScoreByCategory("Acne"),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                _LegendItemWidget(
                                  color: ColorConfig.green,
                                  value: getScoreByCategory("Texture").toInt(),
                                  label: "Texture",
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                _LegendItemWidget(
                                  color: ColorConfig.purple,
                                  value: getScoreByCategory("Dark Circles")
                                      .toInt(),
                                  label: "Dark Circles",
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                _LegendItemWidget(
                                  color: ColorConfig.oceanBlue,
                                  value: getScoreByCategory("Eye Bags").toInt(),
                                  label: "Eyebags",
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                _LegendItemWidget(
                                  color: ColorConfig.blue,
                                  value: getScoreByCategory("Wrinkles").toInt(),
                                  label: "Wrinkles",
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                _LegendItemWidget(
                                  color: ColorConfig.yellow,
                                  value: getScoreByCategory("Pores").toInt(),
                                  label: "Pores",
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                _LegendItemWidget(
                                  color: ColorConfig.taffi,
                                  value: getScoreByCategory("Spots").toInt(),
                                  label: "Spots",
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                _LegendItemWidget(
                                  color: ColorConfig.pink,
                                  value: getScoreByCategory("Acne").toInt(),
                                  label: "Acne",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Text(
                        "Detected Skin Condition",
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: 130,
                            width: 130,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${calculateAverageSkinConditionScore(widget.analysisResult)}%",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Skin Condition",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _CircularChartBarWidget(
                            height: 120,
                            width: 120,
                            color: ColorConfig.primary,
                            value: getScoreByCategory("Firmness"),
                          ),
                          _CircularChartBarWidget(
                            height: 145,
                            width: 145,
                            color: ColorConfig.pink,
                            value: getScoreByCategory("Droopy Upper Eyelid"),
                          ),
                          _CircularChartBarWidget(
                            height: 170,
                            width: 170,
                            color: Colors.green,
                            value: getScoreByCategory("Droopy Lower Eyelid"),
                          ),
                          _CircularChartBarWidget(
                            height: 195,
                            width: 195,
                            color: ColorConfig.green,
                            value: getScoreByCategory("Moisture"),
                          ),
                          _CircularChartBarWidget(
                            height: 220,
                            width: 220,
                            color: ColorConfig.purple,
                            value: getScoreByCategory("Oiliness"),
                          ),
                          _CircularChartBarWidget(
                            height: 245,
                            width: 245,
                            color: ColorConfig.taffi,
                            value: getScoreByCategory("Redness"),
                          ),
                          _CircularChartBarWidget(
                            height: 270,
                            width: 270,
                            color: ColorConfig.oceanBlue,
                            value: getScoreByCategory("Radiance"),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                _LegendItemWidget(
                                  color: ColorConfig.primary,
                                  value: getScoreByCategory("Firmness").toInt(),
                                  label: "Firmness",
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                _LegendItemWidget(
                                  color: ColorConfig.pink,
                                  value:
                                      getScoreByCategory("Droopy Upper Eyelid")
                                          .toInt(),
                                  label: "Droopy Upper Eyelid",
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                _LegendItemWidget(
                                  color: Colors.green,
                                  value:
                                      getScoreByCategory("Droopy Lower Eyelid")
                                          .toInt(),
                                  label: "Droopy Lower Eyelid",
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                _LegendItemWidget(
                                  color: ColorConfig.green,
                                  value: getScoreByCategory("Moisture").toInt(),
                                  label: "Moisture Level",
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                _LegendItemWidget(
                                  color: ColorConfig.purple,
                                  value: getScoreByCategory("Oiliness").toInt(),
                                  label: "Oiliness",
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                _LegendItemWidget(
                                  color: ColorConfig.taffi,
                                  value: getScoreByCategory("Redness").toInt(),
                                  label: "Redness",
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                _LegendItemWidget(
                                  color: ColorConfig.oceanBlue,
                                  value: getScoreByCategory("Radiance").toInt(),
                                  label: "Radiance",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SAAnalysisDetailsWidget(
                title: "Spots",
                analysisResult: widget.analysisResult,
              ),
              SAAnalysisDetailsWidget(
                title: "Texture",
                analysisResult: widget.analysisResult,
              ),
              SAAnalysisDetailsWidget(
                title: "Dark Circles",
                analysisResult: widget.analysisResult,
              ),
              SAAnalysisDetailsWidget(
                title: "Redness",
                analysisResult: widget.analysisResult,
              ),
              SAAnalysisDetailsWidget(
                title: "Oiliness",
                analysisResult: widget.analysisResult,
              ),
              SAAnalysisDetailsWidget(
                title: "Moisture",
                analysisResult: widget.analysisResult,
              ),
              SAAnalysisDetailsWidget(
                title: "Pores",
                analysisResult: widget.analysisResult,
              ),
              SAAnalysisDetailsWidget(
                title: "Eye Bags",
                analysisResult: widget.analysisResult,
              ),
              SAAnalysisDetailsWidget(
                title: "Radiance",
                analysisResult: widget.analysisResult,
              ),
              SAAnalysisDetailsWidget(
                title: "Firmness",
                analysisResult: widget.analysisResult,
              ),
              SAAnalysisDetailsWidget(
                title: "Droopy Upper Eyelid",
                analysisResult: widget.analysisResult,
              ),
              SAAnalysisDetailsWidget(
                title: "Droopy Lower Eyelid",
                analysisResult: widget.analysisResult,
              ),
              SAAnalysisDetailsWidget(
                title: "Acne",
                analysisResult: widget.analysisResult,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LegendItemWidget extends StatelessWidget {
  final Color color;
  final int value;
  final String label;

  const _LegendItemWidget({
    required this.color,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 24,
          width: 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            "$value%",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
            ),
          ),
        ),
      ],
    );
  }
}

class _CircularChartBarWidget extends StatelessWidget {
  final double height, width, value;
  final Color color;

  const _CircularChartBarWidget({
    required this.height,
    required this.width,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Transform.rotate(
        angle: 1.5,
        child: CircularProgressIndicator(
          color: color,
          value: value / 100,
          strokeCap: StrokeCap.round,
          strokeWidth: 8,
          backgroundColor: const Color(0xFF151A20),
        ),
      ),
    );
  }
}

class _SummaryItemWidget extends StatelessWidget {
  final String iconPath;
  final String value;

  const _SummaryItemWidget({
    required this.iconPath,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          iconPath,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
