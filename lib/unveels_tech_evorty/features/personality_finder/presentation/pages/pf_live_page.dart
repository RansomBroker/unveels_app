import 'package:flutter/material.dart';
import 'package:test_new/unvells/constants/app_constants.dart';

import '../../../../shared/extensions/context_parsing.dart';
import '../../../../shared/extensions/live_step_parsing.dart';
import '../../../../shared/widgets/buttons/button_widget.dart';
import '../../../../shared/widgets/lives/bottom_copyright_widget.dart';
import '../../../../shared/widgets/lives/live_widget.dart';
import '../../../find_the_look/presentation/pages/ftl_live_page.dart';
import '../widgets/pf_analysis_results_widget.dart';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import '../../../skin_tone_finder/skin_tone_model.dart';
import '../../face_analyzer_model.dart';

import 'package:http/http.dart' as http;

class PFLivePage extends StatefulWidget {
  const PFLivePage({
    super.key,
    this.isFaceAnalyzer,
  });
  final bool? isFaceAnalyzer;
  @override
  State<PFLivePage> createState() => _PFLivePageState();
}

class _PFLivePageState extends State<PFLivePage> {
  late LiveStep step;
  SkinToneModel personalityList = SkinToneModel();
  SkinToneModel faceShapeList = SkinToneModel();

  List<FaceAnalyzerModel> resultDataParsed = <FaceAnalyzerModel>[];
  Uint8List? imageBytes;
  Color hexToColor(String hexString) {
    // Ensure the string is properly formatted
    hexString = hexString.toUpperCase().replaceAll('#', '');

    // If the hex code is only 6 characters (RRGGBB), add the 'FF' prefix for full opacity
    if (hexString.length == 6) {
      hexString = 'FF' + hexString;
    }

    // Parse the hex string to an integer and return the color
    return Color(int.parse(hexString, radix: 16));
  }

  String result = "";

  bool _isShowAnalysisResults = false;

  @override
  void initState() {
    super.initState();

    _init();
  }

  void _init() {
    // default step
    step = LiveStep.photoSettings;
    getSkinTone();
    getSkinTone2();
  }

  getSkinTone() async {
    try {
      Uri fullUrl = Uri.parse(
          '${ApiConstant.webUrl}/en/rest/V1/products/attributes/personality');
      var res = await http.get(fullUrl, headers: {
        "Authorization": "Bearer hb2vxjo1ayu0agrkr97eprrl5rccqotc"
      });
      log(res.body, name: 'GET SKIN TONE');
      if (res.statusCode == 200) {
        setState(() {
          personalityList = SkinToneModel.fromJson(jsonDecode(res.body));
        });
      } else {
        log(res.statusCode.toString());
      }
    } catch (e) {
      log(e.toString(), name: 'GET SKIN TONE ERROR');
    }
  }

  getSkinTone2() async {
    try {
      Uri fullUrl = Uri.parse(
          '${ApiConstant.webUrl}/en/rest/V1/products/attributes/face_shape');
      var res = await http.get(fullUrl, headers: {
        "Authorization": "Bearer hb2vxjo1ayu0agrkr97eprrl5rccqotc"
      });
      log(res.body, name: 'GET SKIN TONE');
      if (res.statusCode == 200) {
        setState(() {
          faceShapeList = SkinToneModel.fromJson(jsonDecode(res.body));
        });
      } else {
        log(res.statusCode.toString());
      }
    } catch (e) {
      log(e.toString(), name: 'GET SKIN TONE ERROR');
    }
  }

  @override
  Widget build(BuildContext context) {
    Color? screenRecordBackrgoundColor;
    if (_isShowAnalysisResults) {
      screenRecordBackrgoundColor = Colors.black;
    }

    return Scaffold(
      body: LiveWidget(
        liveStep: step,
        liveType: LiveType.liveCamera,
        url: "${ApiConstant.techWebUrl}/personality-finder-web",
        body: _buildBody,
        screenRecordBackrgoundColor: screenRecordBackrgoundColor,
        onLiveStepChanged: (value, result) {
          if (value != step) {
            if (mounted) {
              setState(() {
                step = value;
              });
            }
          }

          if (result != null) {
            setState(() {
              try {
                resultDataParsed =
                    FaceAnalyzerModel.fromJsonList(json.decode(result));
                setState(() {
                  String tempBytes = resultDataParsed
                          .where((e) => e.name == "Image Data")
                          .first
                          .imageData ??
                      '';
                  imageBytes = base64Decode(tempBytes.contains(',')
                      ? tempBytes.split(',').last
                      : tempBytes);
                });
              } catch (e) {
                log(e.toString());
              }
            });
          }
        },
      ),
    );
  }

  Widget get _buildBody {
    switch (step) {
      case LiveStep.photoSettings:
        return const SizedBox.shrink();
      case LiveStep.scanningFace:
        // show oval face container
        return const SizedBox();

      case LiveStep.scannedFace:
        if (_isShowAnalysisResults) {
          return PFAnalysisResultsWidget(
            resultDataParsed: resultDataParsed,
            faceShapeList: faceShapeList,
            personalityList: personalityList,
            isFaceAnalyzer: widget.isFaceAnalyzer ?? false,
          );
        }

        return BottomCopyrightWidget(
          child: Column(
            children: [
              ButtonWidget(
                text: 'PERSONALITY FINDER',
                width: context.width / 2,
                backgroundColor: Colors.black,
                onTap: _onPersonalityFinder,
              ),
            ],
          ),
        );
      case LiveStep.makeup:
        return const SizedBox.shrink();
    }
  }

  Future<void> _onPersonalityFinder() async {
    // show analysis results
    setState(() {
      _isShowAnalysisResults = true;
    });
  }
}
