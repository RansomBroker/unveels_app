import 'package:flutter/material.dart';
import 'package:test_new/unveels_tech_evorty/features/skin_analysis/models/skin_analysis_model.dart';
import 'package:test_new/unvells/constants/app_constants.dart';

import '../../../../shared/configs/size_config.dart';
import '../../../../shared/extensions/context_parsing.dart';
import '../../../../shared/extensions/live_step_parsing.dart';
import '../../../../shared/widgets/buttons/button_widget.dart';
import '../../../../shared/widgets/lives/bottom_copyright_widget.dart';
import '../../../../shared/widgets/lives/live_widget.dart';
import '../../../find_the_look/presentation/pages/ftl_live_page.dart';
import '../widgets/sa_analysis_results_widget.dart';
import '../widgets/sa_full_analysis_results_widget.dart';

class SALivePage extends StatefulWidget {
  const SALivePage({
    super.key,
  });

  @override
  State<SALivePage> createState() => _SALivePageState();
}

class _SALivePageState extends State<SALivePage> {
  late LiveStep step;

  bool _isShowAnalysisResults = false;
  bool _isShowFullAnalysisResults = false;
  List<SkinAnalysisModel>? _analysisResult;
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();

    _init();
  }

  void _init() {
    // default step
    step = LiveStep.photoSettings;
  }

  @override
  Widget build(BuildContext context) {
    Color? screenRecordBackrgoundColor;
    if (_isShowFullAnalysisResults) {
      screenRecordBackrgoundColor = Colors.black;
    }

    return Scaffold(
      body: LiveWidget(
        liveStep: step,
        liveType: LiveType.liveCamera,
        url: "${ApiConstant.techWebUrl}/skin-analysis-web",
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
              _analysisResult = SkinAnalysisModel.fromJsonList(result);
            });
          }
        },
        onGetLabel: (label) {
          if (label != null) {
            String category = SkinAnalysisModel
                .categories[SkinAnalysisModel.categoryLabels.indexOf(label)];
            setState(() {
              _selectedCategory = category;
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
        if (_isShowFullAnalysisResults && _analysisResult != null) {
          return SAFullAnalysisResultsWidget(
            analysisResult: _analysisResult!,
          );
        }

        return BottomCopyrightWidget(
          child: SAAnalysisResultsWidget(
            analysisResult: _analysisResult,
            selectedCategory: _selectedCategory,
            onCategoryChanged: (category) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() {
                  _selectedCategory = category;
                });
              });
            },
            onViewAll: () {
              // close this dialog
              Navigator.pop(context);
              _onViewAllProducts();
            },
          ),
        );
      case LiveStep.makeup:
        return const SizedBox.shrink();
    }
  }

  void _onViewAllProducts() {
    setState(() {
      _isShowAnalysisResults = false;
      _isShowFullAnalysisResults = true;
    });
  }
}
