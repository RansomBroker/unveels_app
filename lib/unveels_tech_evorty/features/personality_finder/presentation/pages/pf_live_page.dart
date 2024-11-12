import 'package:flutter/material.dart';

import '../../../../shared/extensions/context_parsing.dart';
import '../../../../shared/extensions/live_step_parsing.dart';
import '../../../../shared/widgets/buttons/button_widget.dart';
import '../../../../shared/widgets/clippers/face_clipper.dart';
import '../../../../shared/widgets/lives/bottom_copyright_widget.dart';
import '../../../../shared/widgets/lives/live_widget.dart';
import '../../../find_the_look/presentation/pages/ftl_live_page.dart';
import '../widgets/pf_analysis_results_widget.dart';

class PFLivePage extends StatefulWidget {
  const PFLivePage({
    super.key,
  });

  @override
  State<PFLivePage> createState() => _PFLivePageState();
}

class _PFLivePageState extends State<PFLivePage> {
  late LiveStep step;

  bool _isShowAnalysisResults = false;

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
    if (_isShowAnalysisResults) {
      screenRecordBackrgoundColor = Colors.black;
    }

    return Scaffold(
      body: LiveWidget(
        liveStep: step,
        liveType: LiveType.liveCamera,
        body: _buildBody,
        screenRecordBackrgoundColor: screenRecordBackrgoundColor,
        onLiveStepChanged: (value) {
          if (value != step) {
            if (mounted) {
              setState(() {
                step = value;
              });
            }
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
        return Center(
          child: ClipOval(
            clipper: FaceClipper(),
            child: Container(
              width: 330,
              height: 330,
              color: const Color(0xFF289900).withOpacity(0.5),
            ),
          ),
        );

      case LiveStep.scannedFace:
        if (_isShowAnalysisResults) {
          return const PFAnalysisResultsWidget();
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
