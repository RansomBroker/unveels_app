import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/configs/color_config.dart';
import '../../face_analyzer_model.dart';
import 'pf_alaysis_details_widget.dart';

class PFPersonalityAnalysisWidget extends StatelessWidget {
  const PFPersonalityAnalysisWidget(
      {super.key, required this.resultParsedData});
  final List<FaceAnalyzerModel> resultParsedData;

  static Map<String, String> descriptionPersonality = {
    "Extravert":
        "An extravert personality provides insights into an individual's social behaviour and interaction preferences. Extraverts are known for their outgoing, energetic, and talkative nature. They thrive in social settings, seek excitement, and enjoy being the center of attention. Extraverts are often described as sociable, assertive, and enthusiastic individuals who are comfortable in group settings and have a wide circle of friends.  This also delves into the extraversion traits; highlighting that they're strong in communication, leadership, and relationship-building skills.  Therefore, here's what Unveels suggests for you based on your Extraversio",
    "Neurotic":
        "Neuroticism is indicative of an emotional individual who feels deeply and has a tendency to worry and be self-conscious.Low scorers tend to be more resilient to change and keep calm under stress.",
    "Agreable":
        "Agreeableness speaks to kindhearted, sympathetic individuals who get along well with others.Low scorers tend to be competitive and have a harder time maintaining stable relationships.",
    "Conscientious":
        "Conscientiousness speaks to the reliable, hardworking personality type that exercises self-discipline and self-control in order to achieve their goals.Low scorers tend to see rules as restricting and confining, and have more selfish tendencies.",
    "Open":
        "Openness to Experience is representative of the imaginative, creative minds that remain curious to the world around them.High scorers are imaginative, curious minds who love to try new things.",
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        top: 20,
      ),
      child: Column(
        children: [
          Column(
            children: [
              Center(
                child: Text(
                  "Main 5 Personality Traits",
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
                    _CircularChartBarWidget(
                      height: 140,
                      width: 140,
                      color: ColorConfig.yellow,
                      value: resultParsedData
                              .where((element) =>
                                  element.name == "Personality Finder")
                              .first
                              .outputData?["0"] ??
                          0.0,
                    ),
                    _CircularChartBarWidget(
                      height: 160,
                      width: 160,
                      color: ColorConfig.pink,
                      value: resultParsedData
                              .where((element) =>
                                  element.name == "Personality Finder")
                              .first
                              .outputData?["1"] ??
                          0.0,
                    ),
                    _CircularChartBarWidget(
                      height: 180,
                      width: 180,
                      color: ColorConfig.oceanBlue,
                      value: resultParsedData
                              .where((element) =>
                                  element.name == "Personality Finder")
                              .first
                              .outputData?["2"] ??
                          0.0,
                    ),
                    _CircularChartBarWidget(
                      height: 200,
                      width: 200,
                      color: ColorConfig.green,
                      value: resultParsedData
                              .where((element) =>
                                  element.name == "Personality Finder")
                              .first
                              .outputData?["3"] ??
                          0.0,
                    ),
                    _CircularChartBarWidget(
                      height: 220,
                      width: 220,
                      color: ColorConfig.purple,
                      value: resultParsedData
                              .where((element) =>
                                  element.name == "Personality Finder")
                              .first
                              .outputData?["4"] ??
                          0.0,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          _LegendItemWidget(
                            color: ColorConfig.yellow,
                            value: ((resultParsedData
                                            .where((element) =>
                                                element.name ==
                                                "Personality Finder")
                                            .first
                                            .outputData?["0"] ??
                                        0.0) *
                                    100.0)
                                .toInt(),
                            label: resultParsedData
                                    .where((element) =>
                                        element.name == "Personality Finder")
                                    .first
                                    .labels?[0] ??
                                '-',
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          _LegendItemWidget(
                            color: ColorConfig.pink,
                            value: ((resultParsedData
                                            .where((element) =>
                                                element.name ==
                                                "Personality Finder")
                                            .first
                                            .outputData?["1"] ??
                                        0.0) *
                                    100.0)
                                .toInt(),
                            label: resultParsedData
                                    .where((element) =>
                                        element.name == "Personality Finder")
                                    .first
                                    .labels?[1] ??
                                '-',
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          _LegendItemWidget(
                            color: ColorConfig.oceanBlue,
                            value: ((resultParsedData
                                            .where((element) =>
                                                element.name ==
                                                "Personality Finder")
                                            .first
                                            .outputData?["2"] ??
                                        0.0) *
                                    100.0)
                                .toInt(),
                            label: resultParsedData
                                    .where((element) =>
                                        element.name == "Personality Finder")
                                    .first
                                    .labels?[2] ??
                                '-',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          _LegendItemWidget(
                            color: ColorConfig.green,
                            value: ((resultParsedData
                                            .where((element) =>
                                                element.name ==
                                                "Personality Finder")
                                            .first
                                            .outputData?["3"] ??
                                        0.0) *
                                    100.0)
                                .toInt(),
                            label: resultParsedData
                                    .where((element) =>
                                        element.name == "Personality Finder")
                                    .first
                                    .labels?[3] ??
                                '-',
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          _LegendItemWidget(
                            color: ColorConfig.purple,
                            value: ((resultParsedData
                                            .where((element) =>
                                                element.name ==
                                                "Personality Finder")
                                            .first
                                            .outputData?["4"] ??
                                        0.0) *
                                    100.0)
                                .toInt(),
                            label: resultParsedData
                                    .where((element) =>
                                        element.name == "Personality Finder")
                                    .first
                                    .labels?[4] ??
                                '-',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: resultParsedData
                    .where((element) => element.name == "Personality Finder")
                    .first
                    .labels
                    ?.length ??
                0,
            itemBuilder: (context, index) {
              return PFAnalysisDetailsWidget(
                title: resultParsedData
                        .where(
                            (element) => element.name == "Personality Finder")
                        .first
                        .labels?[index] ??
                    '',
                description: descriptionPersonality[resultParsedData
                            .where((element) =>
                                element.name == "Personality Finder")
                            .first
                            .labels?[index] ??
                        ''] ??
                    '',
                percent: resultParsedData
                        .where(
                            (element) => element.name == "Personality Finder")
                        .first
                        .outputData?[index.toString()] ??
                    0.0,
              );
            },
          )
        ],
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
          height: 32,
          width: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            "$value%",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
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
              fontSize: 14,
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
          value: value,
          strokeCap: StrokeCap.round,
          strokeWidth: 6,
        ),
      ),
    );
  }
}
