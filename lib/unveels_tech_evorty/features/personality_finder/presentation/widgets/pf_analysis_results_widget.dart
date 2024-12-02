import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import '../../../../shared/configs/asset_path.dart';
import '../../../../shared/configs/color_config.dart';
import '../../../../shared/configs/size_config.dart';
import '../../../../shared/extensions/fa_tab_bar_parsing.dart';
import '../../../../shared/extensions/pf_tab_bar_parsing.dart';
import '../../../skin_tone_finder/skin_tone_product_model.dart';
import '../../face_analyzer_model.dart';
import 'pf_attributes_analysis_widget.dart';
import 'pf_personality_analysis_widget.dart';
import 'pf_recommendations_analysis_widget.dart';

import '../../../skin_tone_finder/skin_tone_model.dart';
import '../../look_product_model.dart';
import 'package:http/http.dart' as http;

class PFAnalysisResultsWidget extends StatefulWidget {
  const PFAnalysisResultsWidget(
      {super.key,
      required this.isFaceAnalyzer,
      required this.personalityList,
      required this.faceShapeList,
      required this.resultDataParsed});
  final List<FaceAnalyzerModel> resultDataParsed;
  final bool isFaceAnalyzer;
  final SkinToneModel personalityList;
  final SkinToneModel faceShapeList;

  @override
  State<PFAnalysisResultsWidget> createState() =>
      _PFAnalysisResultsWidgetState();
}

class _PFAnalysisResultsWidgetState extends State<PFAnalysisResultsWidget> {
  Uint8List? imageBytes;
  static Map<String, String> personalityAnalysisResult = {
    "Extravert":
        "Individuals with an extravert personality are outgoing, energetic, and talkative. They thrive in social settings, seek excitement, and enjoy being the center of attention. Strong in communication, leadership, and relationship-building skills, Unveels suggests recommendations based on your extraversion.",
    "Neurotic":
        "Neuroticism reflects a tendency to experience negative emotions like anxiety, depression, and moodiness. People high in neuroticism may be more prone to worry and stress, while those low in neuroticism are more emotionally stable and resilient. Unveels offers a bespoke recommendation list based on your neuroticism.",
    "Agreable":
        "People with an agreeable personality are kind-hearted and compassionate, characterized by a strong desire to maintain harmonious relationships. They are cooperative, empathetic, and considerate towards others, making them valuable team players and supportive friends. Unveels has prepared a customized recommendation list based on your agreeable personality.",
    "Conscientious":
        "Individuals high in conscientiousness are organized, responsible, and goal-oriented. Known for their reliability, diligence, and attention to detail, they are diligent in their work and well-prepared. Unveels has unveiled the conscientious side of your personality and provides a recommended list based on it.",
    "Open":
        "Individuals with an open personality possess a vibrant imagination, curiosity, and eagerness to explore new ideas and experiences. They are creative, flexible, and adaptable, receptive to change and innovation. Unveels has prepared a recommendation list based on your open personality.",
  };

  SkinToneProductModel parfumeProducts = SkinToneProductModel();
  SkinToneProductModel accessoriesProducts = SkinToneProductModel();
  SkinToneProductModel lipProducts = SkinToneProductModel();
  LookPacketModel lookProducts = LookPacketModel();
  bool isLoadingParfume = true;
  bool isLoadingAccessories = true;
  bool isLoadingLip = true;
  bool isLoadingLook = true;
  String personalityId = "";
  @override
  void initState() {
    initData();
    super.initState();
  }

  initData() async {
    String tempBytes = widget.resultDataParsed
            .where((e) => e.name == "Image Data")
            .first
            .imageData ??
        '';
    imageBytes = base64Decode(
        tempBytes.contains(',') ? tempBytes.split(',').last : tempBytes);
    String tempData = widget.resultDataParsed
            .where((e) => e.name == "Personality Finder")
            .first
            .outputLabel ??
        '-';
    personalityId = widget.personalityList.options!
            .where((e) => e.label == tempData)
            .first
            .value ??
        '';
    getParfume();
    getAcce();
    getLipstick();
    getLook();
  }

  getParfume() async {
    try {
      setState(() {
        isLoadingParfume = true;
      });
      Uri fullUrl = Uri.parse(
          '${ApiConstant.webUrl}/rest/V1/products?searchCriteria[filter_groups][0][filters][0][field]=category_id&searchCriteria[filter_groups][0][filters][0][value]=878&searchCriteria[filter_groups][0][filters][0][condition_type]=eq&searchCriteria[filter_groups][1][filters][0][field]=type_id&searchCriteria[filter_groups][1][filters][0][value]=simple&searchCriteria[filter_groups][1][filters][0][condition_type]=eq&searchCriteria[filter_groups][2][filters][0][field]=personality&searchCriteria[filter_groups][2][filters][0][value]=$personalityId&searchCriteria[filter_groups][2][filters][0][condition_type]=finset');
      var res = await http.get(fullUrl, headers: {
        "Authorization": "Bearer hb2vxjo1ayu0agrkr97eprrl5rccqotc"
      });
      log(res.body, name: 'GET SKIN TONE PRODUCT');
      if (res.statusCode == 200) {
        setState(() {
          parfumeProducts = SkinToneProductModel.fromJson(jsonDecode(res.body));
        });
      } else {
        log(res.statusCode.toString());
      }

      setState(() {
        isLoadingParfume = false;
      });
    } catch (e) {
      log(e.toString(), name: 'GET SKIN TONE PRODUCT ERROR');
      setState(() {
        isLoadingParfume = false;
      });
    }
  }

  getLipstick() async {
    try {
      setState(() {
        isLoadingLip = true;
      });
      Uri fullUrl = Uri.parse(
          '${ApiConstant.webUrl}/rest/V1/products?searchCriteria[filter_groups][0][filters][0][field]=category_id&searchCriteria[filter_groups][0][filters][0][value]=457&searchCriteria[filter_groups][0][filters][0][condition_type]=eq&searchCriteria[filter_groups][1][filters][0][field]=type_id&searchCriteria[filter_groups][1][filters][0][value]=simple&searchCriteria[filter_groups][1][filters][0][condition_type]=eq&searchCriteria[filter_groups][2][filters][0][field]=personality&searchCriteria[filter_groups][2][filters][0][value]=$personalityId&searchCriteria[filter_groups][2][filters][0][condition_type]=finset');
      var res = await http.get(fullUrl, headers: {
        "Authorization": "Bearer hb2vxjo1ayu0agrkr97eprrl5rccqotc"
      });
      log(res.body, name: 'GET SKIN TONE PRODUCT');
      if (res.statusCode == 200) {
        setState(() {
          lipProducts = SkinToneProductModel.fromJson(jsonDecode(res.body));
        });
      } else {
        log(res.statusCode.toString());
      }

      setState(() {
        isLoadingLip = false;
      });
    } catch (e) {
      log(e.toString(), name: 'GET SKIN TONE PRODUCT ERROR');
      setState(() {
        isLoadingLip = false;
      });
    }
  }

  getAcce() async {
    try {
      setState(() {
        isLoadingAccessories = true;
      });
      Uri fullUrl = Uri.parse(
          '${ApiConstant.webUrl}/rest/V1/products?searchCriteria[filter_groups][0][filters][0][field]=category_id&searchCriteria[filter_groups][0][filters][0][value]=401&searchCriteria[filter_groups][0][filters][0][condition_type]=eq&searchCriteria[filter_groups][1][filters][0][field]=type_id&searchCriteria[filter_groups][1][filters][0][value]=simple&searchCriteria[filter_groups][1][filters][0][condition_type]=eq&searchCriteria[filter_groups][2][filters][0][field]=personality&searchCriteria[filter_groups][2][filters][0][value]=$personalityId&searchCriteria[filter_groups][2][filters][0][condition_type]=finset');
      var res = await http.get(fullUrl, headers: {
        "Authorization": "Bearer hb2vxjo1ayu0agrkr97eprrl5rccqotc"
      });
      log(res.body, name: 'GET SKIN TONE PRODUCT');
      if (res.statusCode == 200) {
        setState(() {
          accessoriesProducts =
              SkinToneProductModel.fromJson(jsonDecode(res.body));
        });
      } else {
        log(res.statusCode.toString());
      }

      setState(() {
        isLoadingAccessories = false;
      });
    } catch (e) {
      log(e.toString(), name: 'GET SKIN TONE PRODUCT ERROR');
      setState(() {
        isLoadingAccessories = false;
      });
    }
  }

  getLook() async {
    try {
      setState(() {
        isLoadingLook = true;
      });
      Uri fullUrl = Uri.parse(
          '${ApiConstant.webUrl}/en/rest/V1/lookbook/categories');
      var res = await http.get(fullUrl, headers: {
        "Authorization": "Bearer hb2vxjo1ayu0agrkr97eprrl5rccqotc"
      });
      log(res.body, name: 'GET LOOK PRODUCT'); // Logs the response body

      if (res.statusCode == 200) {
        var responseBody = jsonDecode(res.body);
        log('Decoded Response Body: $responseBody', name: 'Response Body');

        // Inspect the type of the response body
        if (responseBody is List) {
          // If it's a list, handle it differently
          log('Response is a List');
          // Handle the case when the response is a list of items
          lookProducts = List<LookPacketModel>.from(
              responseBody.map((item) => LookPacketModel.fromJson(item)))[0];
        } else if (responseBody is Map) {
          // If it's a map, it's a single object
          log('Response is a Map');
          // lookProducts = LookPacketModel.fromJson(responseBody);
        } else {
          log('Unexpected response format');
        }

        setState(() {
          isLoadingLook = false;
        });
      } else {
        log(res.statusCode.toString());
      }
    } catch (e) {
      log(e.toString(), name: 'GET LOOK PRODUCT ERROR');
      setState(() {
        isLoadingLook = false;
      });
    }
  }
  //perfume : 878
  //lipstick : 457
  //accessories : 401

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black,
      child: DefaultTabController(
        length: PFTabBar.values.length,
        child: Column(
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
              child: Row(
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          initData();
                        },
                        child: Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: const Color.fromARGB(255, 138, 95, 2)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.memory(
                              imageBytes!,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.resultDataParsed
                                .where((e) => e.name == "Personality Finder")
                                .first
                                .outputLabel ??
                            '-',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          IconPath.hasTagCircle,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "AI Personality Analysis :",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                personalityAnalysisResult[widget
                                            .resultDataParsed
                                            .where((e) =>
                                                e.name == "Personality Finder")
                                            .first
                                            .outputLabel ??
                                        '-'] ??
                                    '',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
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
            const SizedBox(
              height: 20,
            ),
            TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                unselectedLabelColor: const Color(0xFF9E9E9E),
                labelColor: ColorConfig.primary,
                indicatorColor: ColorConfig.primary,
                labelStyle: const TextStyle(
                  fontSize: 14,
                ),
                padding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                indicatorPadding: EdgeInsets.zero,
                dividerColor: const Color(0xFF9E9E9E),
                dividerHeight: 1.5,
                tabs: widget.isFaceAnalyzer
                    ? FATabBar.values.map((e) {
                        return Tab(
                          text: e.title,
                        );
                      }).toList()
                    : PFTabBar.values.map((e) {
                        return Tab(
                          text: e.title,
                        );
                      }).toList()),
            Expanded(
              child: TabBarView(
                children: [
                  if (widget.isFaceAnalyzer == false)
                    PFPersonalityAnalysisWidget(
                      resultParsedData: widget.resultDataParsed,
                    ),
                  PFAttributesAnalysisWidget(
                      resultDataParsed: widget.resultDataParsed),
                  PfRecommendationsAnalysisWidget(
                    resultDataParsed: widget.resultDataParsed,
                    isLoadingParfume: isLoadingParfume,
                    parfumeData: parfumeProducts,
                    lipData: lipProducts,
                    isLoadingLip: isLoadingLip,
                    accData: accessoriesProducts,
                    isLoadingAcc: isLoadingAccessories,
                    lookData: lookProducts,
                    isLoadLook: isLoadingLook,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
