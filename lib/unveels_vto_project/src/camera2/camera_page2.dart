import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_new/unveels_vto_project//common/component/custom_dialog.dart';
import 'package:test_new/unveels_vto_project//common/component/custom_navigator.dart';
import 'package:test_new/unveels_vto_project//common/helper/constant.dart';
import 'package:test_new/unveels_vto_project//generated/assets.dart';
import 'package:test_new/unveels_vto_project//src/camera2/camera_video_page.dart';
import 'package:test_new/unveels_vto_project//utils/utils.dart';
import 'package:test_new/unveels_vto_project/common/component/bottom_copyright.dart';
import 'package:test_new/unveels_vto_project/common/component/vto_type_selector.dart';
import 'package:test_new/unveels_vto_project/common/component/vto_type_sheet.dart';
import 'package:test_new/unveels_vto_project/utils/vto_types.dart';
import 'package:test_new/unvells/constants/app_constants.dart';

class OcrCameraPage2 extends StatefulWidget {
  const OcrCameraPage2({
    super.key,
    this.makeUpOn,
    this.accessoriesOn,
    this.showChoices,
  });

  final bool? makeUpOn;
  final bool? accessoriesOn;
  final bool? showChoices;

  @override
  State<OcrCameraPage2> createState() => _OcrCameraPage2State();
}

class _OcrCameraPage2State extends State<OcrCameraPage2>
    with WidgetsBindingObserver {
  InAppWebViewController? webViewController;
  late List<Permission> permissions;
  bool isRearCamera = true;
  bool isFlipCameraSupported = false;
  File? file;
  bool makeUpOn = false;
  bool accessoriesOn = true;
  String? _currentSubType;
  bool _showSheet = true;

  @override
  void initState() {
    super.initState();
    makeUpOn = widget.makeUpOn ?? makeUpOn;
    accessoriesOn = widget.accessoriesOn ?? accessoriesOn;
    WidgetsBinding.instance.addObserver(this);
    if (Platform.isAndroid) {
      DeviceInfoPlugin().androidInfo.then((value) {
        if (value.version.sdkInt >= 32) {
          permissions = [
            Permission.camera,
            Permission.microphone,
          ];
        } else {
          permissions = [
            Permission.camera,
            Permission.microphone,
            // Permission.storage
          ];
        }
      }).then((value) {
        // _initCamera();
        checkPermissionStatuses().then((allclear) {
          if (allclear) {
          } else {
            permissions.request().then((value) {
              checkPermissionStatuses().then((allclear) {
                if (allclear) {
                } else {
                  Utils.showToast(
                      'Please allow access to Camera and Microphone');
                  Navigator.of(context).pop();
                }
              });
            });
          }
        });
      });
    } else {
      // permissions = [
      //   Permission.camera,
      //   Permission.microphone,
      //   // Permission.storage
      // ];
      // checkPermissionStatuses().then((allclear) {
      //   if (allclear) {
      //     _initCamera();
      //   } else {
      //     permissions.request().then((value) {
      //       checkPermissionStatuses().then((allclear) {
      //         if (allclear) {
      //           _initCamera();
      //         } else {
      //           Utils.showToast(
      //               'Mohon izinkan untuk mengakses Kamera dan Mikrofon');
      //           Navigator.of(context).pop();
      //         }
      //       });
      //     });
      //   }
      // });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<bool> checkPermissionStatuses() async {
    for (var permission in permissions) {
      if (await permission.status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  Widget pictureTaken() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Edit',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          Constant.xSizedBox24,
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xffCA9C43),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Share',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Constant.xSizedBox16,
                    Icon(Icons.share_outlined, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void changeModel(BuildContext context) {
    CustomDialog.newDialog(
        context: context,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.white,
                size: 24,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Text(
              "How would you like to try on the makeup?",
              style: Constant.whiteRegular12,
            ),
          ],
        ),
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        content: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  Assets.imagesImgUpPhoto,
                  scale: 3,
                ),
                Image.asset(
                  Assets.imagesImgUpVideo,
                  scale: 3,
                ),
                Image.asset(
                  Assets.imagesImgModel,
                  scale: 3,
                ),
              ],
            ),
          ),
        ));
  }

  Widget makeupOrAccessoriesChoice() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          widget.showChoices == true
              ? Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            makeUpOn = true;
                            accessoriesOn = false;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: Text(
                            'Make Up',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                shadows: makeUpOn == true
                                    ? [
                                        const BoxShadow(
                                          offset: Offset(0, 0),
                                          color: Colors.yellow,
                                          spreadRadius: 0,
                                          blurRadius: 10,
                                        )
                                      ]
                                    : null),
                          ),
                        ),
                      ),
                    ),
                    Constant.xSizedBox12,
                    Container(
                      height: 20,
                      width: 1,
                      color: Colors.white,
                    ),
                    Constant.xSizedBox12,
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            accessoriesOn = true;
                            makeUpOn = false;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: Text(
                            'Accessories',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                shadows: accessoriesOn == true
                                    ? [
                                        const BoxShadow(
                                          offset: Offset(0, 0),
                                          color: Colors.yellow,
                                          spreadRadius: 0,
                                          blurRadius: 10,
                                        )
                                      ]
                                    : null),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
          widget.showChoices == true ? separator() : const SizedBox(),
          if (makeUpOn == true)
            VtoTypeSelector(
                menu: MenuVto.makeup, onSubTypeChange: _changeSubType),
          if (accessoriesOn == true)
            VtoTypeSelector(
                menu: MenuVto.accesories, onSubTypeChange: _changeSubType),
        ],
      ),
    );
  }

  void _changeSubType(String type) {
    setState(() {
      _currentSubType = type;
    });
  }

  Widget noPictureTaken() {
    return SizedBox(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 6,
            child: Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {},
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      width: 60,
                      height: 60,
                    ),
                    const Icon(
                      Icons.circle,
                      color: Colors.white,
                      size: 60,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Align(
              alignment: Alignment.centerRight,
              child: Visibility(
                visible: isFlipCameraSupported,
                child: InkWell(
                  onTap: () async {
                    // ///[Flip Camera]
                    // if (isFlippingCamera == null ||
                    //     isFlippingCamera!.isCompleted) {
                    //   isFlippingCamera = Completer();
                    //   isFlippingCamera!.complete(
                    //       await availableCameras().then((value) async {
                    //     for (var camera in value) {
                    //       if (camera.lensDirection ==
                    //           (controller.description.lensDirection ==
                    //                   CameraLensDirection.front
                    //               ? CameraLensDirection.back
                    //               : CameraLensDirection.front)) {
                    //         await controller.dispose();
                    //         cameraSetupCompleter = Completer();

                    //         await _initCamera(camera: camera);
                    //         setState(() {});
                    //         break;
                    //       }
                    //     }

                    //     await Future.delayed(
                    //         const Duration(seconds: 1, milliseconds: 500));
                    //   }));
                    // } else {
                    //   print('Not completed!');
                    // }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 16),
                    width: 35,
                    height: 35,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black26),
                    child: const Icon(Icons.autorenew_rounded,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget separator() {
    return const Divider(thickness: 1, color: Colors.white);
  }

  Widget cameraPreview() {
    return InAppWebView(
      initialUrlRequest: URLRequest(
          url: WebUri('${ApiConstant.techWebUrl}/virtual-try-on-web')),
      onWebViewCreated: (controller) async {
        webViewController = controller;
      },
      onPermissionRequest: (controller, permissionRequest) async {
        return PermissionResponse(
            resources: permissionRequest.resources,
            action: PermissionResponseAction.GRANT);
      },
      shouldOverrideUrlLoading: (controller, navigationAction) async {
        return NavigationActionPolicy.ALLOW;
      },
    );
  }

  Widget iconSidebar(GestureTapCallback? onTap, String path) {
    return InkWell(
      onTap: onTap,
      child: Image.asset(
        path,
        width: 18,
        height: 18,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        titleSpacing: 0,
        leading: InkWell(
          onTap: () {
            if (_currentSubType != null) {
              setState(() {
                _currentSubType = null;
              });
            } else {
              CusNav.nPop(context);
            }
          },
          child: Center(
            child: Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.black26),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white, size: 18),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Center(
                  child: Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.black26),
                child: const SizedBox(
                    width: 32,
                    height: 32,
                    child: Icon(Icons.close, color: Colors.white, size: 18)),
              )),
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      ),
      extendBodyBehindAppBar: true,
      body: LayoutBuilder(
        builder: (p0, p1) {
          return Stack(
            children: [
              cameraPreview(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  // margin: xHEdgeInsets12
                  //     .add(const EdgeInsets.only(bottom: 12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          margin: const EdgeInsets.only(right: 16),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 10),
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              iconSidebar(() async {
                                CusNav.nPush(context, const CameraVideoPage());
                              }, Assets.iconsIcCamera),
                              Constant.xSizedBox12,
                              iconSidebar(() async {
                                ///[Flip Camera]
                              }, Assets.iconsIcFlipCamera),
                              Constant.xSizedBox12,
                              iconSidebar(() async {}, Assets.iconsIcScale),
                              Constant.xSizedBox12,
                              iconSidebar(() async {
                                setState(() {
                                  // makeupOrAccessories =
                                  //     !makeupOrAccessories;
                                });
                              }, Assets.iconsIcCompare),
                              Constant.xSizedBox12,
                              iconSidebar(() async {}, Assets.iconsIcReset),
                              Constant.xSizedBox12,
                              iconSidebar(() async {
                                changeModel(context);
                              }, Assets.iconsIcChoose),
                              Constant.xSizedBox12,
                              iconSidebar(() async {}, Assets.iconsIcShare),
                            ],
                          ),
                        ),
                      ),
                      Constant.xSizedBox16,
                      _currentSubType == null
                          ? makeupOrAccessoriesChoice()
                          : BottomCopyright(
                              showContent: _showSheet,
                              child: VtoTypeSheet(
                                  subType: _currentSubType!,
                                  webViewController: webViewController),
                              onTap: () {
                                setState(() {
                                  _showSheet = !_showSheet;
                                });
                              },
                            ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}