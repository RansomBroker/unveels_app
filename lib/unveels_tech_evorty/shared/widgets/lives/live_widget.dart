import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_new/unveels_tech_evorty/shared/extensions/context_parsing.dart';
import 'package:test_new/unveels_tech_evorty/shared/widgets/lives/play_video_widget.dart';

import '../../../features/find_the_look/presentation/pages/ftl_live_page.dart';
import '../../configs/size_config.dart';
import '../../extensions/live_configuration_step_parsing.dart';
import '../../extensions/live_step_parsing.dart';
import '../app_bars/app_bar_widget.dart';
import '../buttons/recording_controllers_widget.dart';
import 'live_configuration_step_widget.dart';

class LiveWidget extends StatefulWidget {
  final LiveStep liveStep;
  final LiveType liveType;
  final XFile? file;
  final Function(LiveStep value, String? result) onLiveStepChanged;
  final Widget body;
  final Color? screenRecordBackrgoundColor;
  final String? url;
  final Function(ConsoleMessage message)? onConsoleMessage;

  const LiveWidget(
      {super.key,
      required this.liveStep,
      required this.liveType,
      this.file,
      required this.onLiveStepChanged,
      required this.body,
      this.screenRecordBackrgoundColor,
      this.url,
      this.onConsoleMessage});
  @override
  State<LiveWidget> createState() => _LiveWidgetState();
}

class _LiveWidgetState extends State<LiveWidget> {
  LiveConfigurationStep? _liveConfigurationStep;
  int? _countdownFaceScanning;
  InAppWebViewController? webViewController;
  String? resultData;
  @override
  void initState() {
    super.initState();

    _init();
  }

  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
  }

  void _init() async {
    requestCameraPermission();
    if (widget.liveStep == LiveStep.photoSettings) {
      // _startLiveConfiguration();
    }
  }

  // Future<void> _startLiveConfiguration() async {
  //   // for testing, loop auto increment step every 3 seconds
  //   for (final step in LiveConfigurationStep.values) {
  //     await Future.delayed(const Duration(seconds: 3));

  //     if (mounted) {
  //       setState(() {
  //         _liveConfigurationStep = step;
  //       });
  //     }
  //   }

  //   // start scanning countdown
  //   for (var i = 3; i >= 0; i--) {
  //     await Future.delayed(const Duration(seconds: 1));

  //     if (mounted) {
  //       setState(() {
  //         _countdownFaceScanning = i;
  //       });
  //     }
  //   }

  //   // reset countdown
  //   if (mounted) {
  //     setState(() {
  //       _countdownFaceScanning = null;
  //     });
  //   }

  //   // change step to scanning face
  //   widget.onLiveStepChanged(LiveStep.scanningFace);

  //   // delayed scanning for 1 second
  //   await Future.delayed(const Duration(seconds: 1));

  //   // change step to scanned face
  //   widget.onLiveStepChanged(LiveStep.scannedFace);
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildImage,
        // linear gradient
        // Container(
        //   margin: const EdgeInsets.only(
        //     top: SizeConfig.appBarMargin,
        //   ),
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       begin: Alignment.topCenter,
        //       end: Alignment.bottomCenter,
        //       colors: [
        //         const Color(0xFF000000).withOpacity(0.0),
        //         const Color(0xFF000000).withOpacity(0.9),
        //       ],
        //     ),
        //   ),
        // ),
        // body
        _buildBody,
      ],
    );
  }

  Widget get _buildImage {
    switch (widget.liveType) {
      case LiveType.importPhoto:
        // TODO: Recording screen
        // show image
        return Image.file(
          File(widget.file!.path),
          fit: BoxFit.cover,
          width: context.width,
          height: context.height,
        );
      case LiveType.importVideo:
        // TODO: Recording screen
        // show video
        return PlayVideoWidget(
          file: File(widget.file!.path),
          isShowScreenRecording: true,
          screenRecordBackrgoundColor: widget.screenRecordBackrgoundColor,
        );
      case LiveType.liveCamera:
        // show live camera
        return Scaffold(
          appBar: AppBarWidget(
            iconBackgroundColor: const Color(0xFF000000).withOpacity(0.24),
            backgroundColor:
                widget.screenRecordBackrgoundColor ?? Colors.transparent,
            showCloseButton: true,
          ),
          extendBodyBehindAppBar: true,
          body: Stack(
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(
                    url: WebUri(widget.url ??
                        'https://unveels-webview.netlify.app/skin-tone-finder-web')),
                //test-js.cibportofolio.com
                // initialUrlRequest:
                // URLRequest(url: WebUri(Uri.base.toString().replaceFirst("/#/", "/") + 'page.html')),
                // initialFile: "assets/index.html",
                onWebViewCreated: (controller) async {
                  webViewController = controller;
                  // Listen to JavaScript handler 'flutterDataHandler'
                  webViewController?.addJavaScriptHandler(
                    handlerName: 'detectionRun',
                    callback: (args) {
                      // Handle data sent from JavaScript here
                      setState(() {
                        widget.onLiveStepChanged(LiveStep.scanningFace, null);
                      });
                    },
                  );
                  webViewController?.addJavaScriptHandler(
                    handlerName: 'detectionResult',
                    callback: (args) {
                      // Handle data sent from JavaScript here
                      setState(() {
                        resultData =
                            args.isNotEmpty ? args[0] : "No data received";
                        widget.onLiveStepChanged(
                            LiveStep.scannedFace, resultData);

                        print(resultData);
                      });
                    },
                  );
                  webViewController?.addJavaScriptHandler(
                    handlerName: 'detectionError',
                    callback: (args) {
                      // Handle data sent from JavaScript here
                      setState(() {
                        resultData =
                            args.isNotEmpty ? args[0] : "No data received";
                      });
                    },
                  );
                },
                onLoadStart: (controller, url) async {
                  log('loading : $url');
                },
                onPermissionRequest: (controller, permissionRequest) async {
                  return PermissionResponse(
                      resources: permissionRequest.resources,
                      action: PermissionResponseAction.GRANT);
                },
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  var uri = navigationAction.request.url!;

                  if (![
                    "http",
                    "https",
                    "file",
                    "chrome",
                    "data",
                    "javascript",
                    "about"
                  ].contains(uri.scheme)) {
                    // if (await canLaunchUrl(uri)) {
                    //   // Launch the App
                    //   await launchUrl(
                    //     uri,
                    //   );
                    //   // and cancel the request
                    //   return NavigationActionPolicy.CANCEL;
                    // }
                  }

                  return NavigationActionPolicy.ALLOW;
                },

                onLoadStop: (controller, url) async {},
                onProgressChanged: (controller, progress) {},
                onUpdateVisitedHistory: (controller, url, isReload) {},
                onConsoleMessage: (controller, consoleMessage) {
                  print(consoleMessage);
                  if (widget.onConsoleMessage != null) {
                      widget.onConsoleMessage!(consoleMessage);
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                ),
                child: RecordingControllersWidget(
                  screenRecordingStatus: null,
                  backgroundColor: widget.screenRecordBackrgoundColor,
                  onStartRecording: () {},
                  onStopRecording: () {},
                  onPauseRecording: () {},
                  onResumeRecording: () {},
                ),
              )
            ],
          ),
        );
    }
  }

  Widget get _buildBody {
    if (_countdownFaceScanning != null) {
      // show countdown for prepare start scanning
      return Center(
        child: Text(
          _countdownFaceScanning?.toString() ?? "",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 128,
          ),
        ),
      );
    }

    switch (widget.liveStep) {
      case LiveStep.photoSettings:
      // return LiveConfigurationStepWidget(
      //   liveConfigurationStep: _liveConfigurationStep,
      // );
      case LiveStep.scanningFace:
      case LiveStep.scannedFace:
      case LiveStep.makeup:
        return widget.body;
    }
  }
}
