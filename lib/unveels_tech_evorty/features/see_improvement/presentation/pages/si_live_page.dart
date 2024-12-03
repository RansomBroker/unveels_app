import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:test_new/unvells/constants/app_constants.dart';

import '../../../../shared/configs/size_config.dart';
import '../../../../shared/extensions/context_parsing.dart';
import '../../../../shared/extensions/live_step_parsing.dart';
import '../../../../shared/widgets/buttons/button_widget.dart';
import '../../../../shared/widgets/lives/bottom_copyright_widget.dart';
import '../../../../shared/widgets/lives/live_widget.dart';
import '../../../find_the_look/presentation/pages/ftl_live_page.dart';
import '../widgets/see_improvement_results_widget.dart';

class SILivePage extends StatefulWidget {
  const SILivePage({
    super.key,
  });

  @override
  State<SILivePage> createState() => _SILivePageState();
}

class _SILivePageState extends State<SILivePage> {
  late LiveStep step;

  bool _isShowAnalysisResults = false;
  double _sliderValue = 0.1;
  InAppWebViewController? _webViewController;

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

    return Scaffold(
      body: LiveWidget(
        liveStep: step,
        liveType: LiveType.liveCamera,
        url: "${ApiConstant.techWebUrl}/see-improvement-web",
        body: _buildBody,
        screenRecordBackrgoundColor: screenRecordBackrgoundColor,
        onLiveStepChanged: (value, result) {
          if (value != step) {
            if (mounted) {
              // setState(() {
              //   step = value;
              // });
            }
          }
        },
        onConsoleMessage: (value) {
          if (value.message ==
                  "INFO: Created TensorFlow Lite XNNPACK delegate for CPU." &&
              value.messageLevel == ConsoleMessageLevel.ERROR) {
            setState(() {
              step = LiveStep.scannedFace;
            });
          }
        },
        onWebViewCreated: (controller) {
          _webViewController = controller;
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
          return const BottomCopyrightWidget(
            child: SizedBox.shrink(),
          );
        }

        return BottomCopyrightWidget(
          child: Column(
            children: [
              ButtonWidget(
                text: 'SEE IMPROVEMENT',
                width: context.width / 2,
                backgroundColor: Colors.black,
                onTap: _onAnalysisResults,
              ),
            ],
          ),
        );
      case LiveStep.makeup:
        return const SizedBox.shrink();
    }
  }

  Future<void> _onAnalysisResults() async {
    // show analysis results
    setState(() {
      _isShowAnalysisResults = true;
    });

    // show bottom sheet
    await showModalBottomSheet<bool?>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      elevation: 0,
      constraints: BoxConstraints(
        minHeight: context.height * 0.6,
        maxHeight: context.height * 0.8,
      ),
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(
            bottom: SizeConfig.bottomLiveMargin,
          ),
          child: SafeArea(
            bottom: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SeeImprovementResultsWidget(
                  onUpdateSmoothingStrength: (double value) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        _sliderValue = value;
                      });
                      _webViewController?.evaluateJavascript(
                        source: """
                        window.postMessage(JSON.stringify({ smoothingStrength: $value }), "*");
                        """,
                      );
                    });
                  },
                  sliderValue: _sliderValue,
                ),
              ],
            ),
          ),
        );
      },
    );

    // hide analysis results
    setState(() {
      _isShowAnalysisResults = false;
    });
  }

}
