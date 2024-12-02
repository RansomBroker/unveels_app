import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:test_new/unvells/constants/app_constants.dart';
import '../../../../shared/configs/size_config.dart';
import '../../../../shared/extensions/context_parsing.dart';
import '../../../../shared/extensions/live_step_parsing.dart';
import '../../../../shared/widgets/buttons/button_widget.dart';
import '../../../../shared/widgets/clippers/face_clipper.dart';
import '../../../../shared/widgets/lives/bottom_copyright_widget.dart';
import '../../../../shared/widgets/lives/live_widget.dart';
import '../../../find_the_look/presentation/pages/ftl_live_page.dart';
import '../../skin_tone_model.dart';
import '../../skin_tone_product_model.dart';
import '../../tone_type_model.dart';
import '../widgets/stf_shades_widget.dart';

class STFLivePage extends StatefulWidget {
  const STFLivePage({
    super.key,
  });

  @override
  State<STFLivePage> createState() => _STFLivePageState();
}

class _STFLivePageState extends State<STFLivePage> {
  late LiveStep step;
  int? selectedIndex;
  Map<String, String> hexColorTone = {
    "cooler": "A37772",
    "lighter": "DF9F86",
    "perfect fit": "B7775E",
    "warmer": "CB8B5E",
    "darker": "8F4F36"
  };
  String selectedTone = "perfect fit";
  SkinToneModel skinToneModel = SkinToneModel();
  ToneTypeModel toneTypeModel = ToneTypeModel();
  SkinToneProductModel skinToneProductModel = SkinToneProductModel();
  bool isLoadingProductt = true;
  bool _isShowShades = false;
  String? resultData;

  @override
  void initState() {
    super.initState();

    _init();
  }

  void _init() async {
    // default step
    step = LiveStep.photoSettings;
    await getToneType();
    await getSkinTone();
  }

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

  getToneType() async {
    try {
      Uri fullUrl = Uri.parse(
          '${ApiConstant.webUrl}/en/rest/V1/products/attributes/tone_type');
      var res = await http.get(fullUrl, headers: {
        "Authorization": "Bearer hb2vxjo1ayu0agrkr97eprrl5rccqotc"
      });
      log(res.body, name: 'GET TONE');
      if (res.statusCode == 200) {
        setState(() {
          toneTypeModel = ToneTypeModel.fromJson(jsonDecode(res.body));
        });
      } else {
        log(res.statusCode.toString());
      }
    } catch (e) {
      log(e.toString(), name: 'GET TONE ERROR');
    }
  }

  getSkinTone() async {
    try {
      Uri fullUrl = Uri.parse(
          '${ApiConstant.webUrl}/en/rest/V1/products/attributes/skin_tone');
      var res = await http.get(fullUrl, headers: {
        "Authorization": "Bearer hb2vxjo1ayu0agrkr97eprrl5rccqotc"
      });
      log(res.body, name: 'GET SKIN TONE');
      if (res.statusCode == 200) {
        setState(() {
          skinToneModel = SkinToneModel.fromJson(jsonDecode(res.body));
        });
      } else {
        log(res.statusCode.toString());
      }
    } catch (e) {
      log(e.toString(), name: 'GET SKIN TONE ERROR');
    }
  }

  getProduct(String skinId, String toneTypeId) async {
    try {
      setState(() {
        isLoadingProductt = true;
        selectedIndex = null;
      });
      Uri fullUrl = Uri.parse(
          "${ApiConstant.webUrl}/rest/V1/products?searchCriteria[filter_groups][0][filters][0][field]=category_id&searchCriteria[filter_groups][0][filters][0][value]=451&searchCriteria[filter_groups][0][filters][0][condition_type]=eq&searchCriteria[filter_groups][1][filters][0][field]=skin_tone&searchCriteria[filter_groups][1][filters][0][value]=$skinId&searchCriteria[filter_groups][2][filters][0][condition_type]=eq&searchCriteria[filter_groups][2][filters][0][field]=tone_type&searchCriteria[filter_groups][2][filters][0][value]=$toneTypeId&searchCriteria[filter_groups][2][filters][0][condition_type]=finset");
      var res = await http.get(fullUrl, headers: {
        "Authorization": "Bearer hb2vxjo1ayu0agrkr97eprrl5rccqotc"
      });
      log(res.body, name: 'GET SKIN TONE PRODUCT');
      if (res.statusCode == 200) {
        setState(() {
          skinToneProductModel =
              SkinToneProductModel.fromJson(jsonDecode(res.body));
        });
      } else {
        log(res.statusCode.toString());
      }

      setState(() {
        isLoadingProductt = false;
      });
    } catch (e) {
      log(e.toString(), name: 'GET SKIN TONE PRODUCT ERROR');
      setState(() {
        isLoadingProductt = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiveWidget(
        liveStep: step,
        liveType: LiveType.liveCamera,
        body: _buildBody,
        onLiveStepChanged: (value, result) {
          if (value != step) {
            if (mounted) {
              setState(() {
                step = value;
              });
            }
          }

          if (result != null) {
            getProduct(
                skinToneModel.options!
                        .where((e) =>
                            e.label.toString().toLowerCase() ==
                            jsonDecode(result)["skinType"]
                                .toString()
                                .split(' ')[0]
                                .toLowerCase())
                        .first
                        .value ??
                    '',
                toneTypeModel.options
                        ?.where((e) =>
                            e.label?.toLowerCase() ==
                            selectedTone.toLowerCase())
                        .first
                        .value ??
                    '');
            resultData = result;
            setState(() {});
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
        if (_isShowShades) {
          return const BottomCopyrightWidget(
            child: SizedBox.shrink(),
          );
        }

        return BottomCopyrightWidget(
          child: Column(
            children: [
              ButtonWidget(
                  text: 'SHOW SHADES',
                  width: context.width / 2,
                  backgroundColor: Colors.black,
                  onTap: () {
                    _onShowShades(
                        skinToneProductModel, skinToneModel, toneTypeModel);
                  }),
            ],
          ),
        );
      case LiveStep.makeup:
        return const SizedBox.shrink();
    }
  }

  _onShowShades(SkinToneProductModel skinToneProductModels, skinToneModels,
      toneTypeModels) async {
    // show analysis results
    setState(() {
      _isShowShades = true;
    });

    // show bottom sheet
    await showModalBottomSheet<bool?>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      elevation: 0,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: SizeConfig.bottomLiveMargin,
          ),
          child: SafeArea(
            bottom: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                STFShadesWidget(
                  skinToneModel: skinToneModels,
                  toneTypeModel: toneTypeModels,
                  resultData: resultData,
                ),
              ],
            ),
          ),
        );
      },
    );

    // hide analysis results
    setState(() {
      _isShowShades = false;
    });
  }
}
