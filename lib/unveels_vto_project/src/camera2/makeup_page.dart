import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_new/unveels_vto_project//common/component/custom_navigator.dart';
import 'package:test_new/unveels_vto_project//common/helper/constant.dart';
import 'package:test_new/unveels_vto_project//generated/assets.dart';
import 'package:test_new/unveels_vto_project//src/camera2/camera_video_page.dart';
import 'package:test_new/unveels_vto_project//src/camera2/makeup/eyes/eyebrows_view.dart';
import 'package:test_new/unveels_vto_project//src/camera2/makeup/eyes/eyeliner_view.dart';
import 'package:test_new/unveels_vto_project//src/camera2/makeup/eyes/eyeshadow_view.dart';
import 'package:test_new/unveels_vto_project//src/camera2/makeup/eyes/lashes_mascara_view.dart';
import 'package:test_new/unveels_vto_project//src/camera2/makeup/eyes/lenses_view.dart';
import 'package:test_new/unveels_vto_project//src/camera2/makeup/face/blusher_view.dart';
import 'package:test_new/unveels_vto_project//src/camera2/makeup/face/bronzer_view.dart';
import 'package:test_new/unveels_vto_project//src/camera2/makeup/face/concealer_view.dart';
import 'package:test_new/unveels_vto_project//src/camera2/makeup/face/contour_view.dart';
import 'package:test_new/unveels_vto_project//src/camera2/makeup/face/foundation_view.dart';
import 'package:test_new/unveels_vto_project//src/camera2/makeup/face/highlighter_view.dart';
import 'package:test_new/unveels_vto_project//src/camera2/makeup/hair/hair_view.dart';
import 'package:test_new/unveels_vto_project//src/camera2/makeup/lips/lip_color_view.dart';
import 'package:test_new/unveels_vto_project//src/camera2/makeup/lips/lip_liner_view.dart';
import 'package:test_new/unveels_vto_project//src/camera2/makeup/lips/lip_plumber_view.dart';
import 'package:test_new/unveels_vto_project//src/camera2/makeup/nails/nail_polish_view.dart';
import 'package:test_new/unveels_vto_project//src/camera2/makeup/nails/presonnails_view.dart';

import 'package:test_new/unveels_vto_project//utils/utils.dart';
import 'package:test_new/unvells/constants/app_constants.dart';

const xHEdgeInsets12 = EdgeInsets.symmetric(horizontal: 12);

class MakeupPage extends StatefulWidget {
  const MakeupPage({super.key});

  @override
  State<MakeupPage> createState() => _MakeupPageState();
}

class _MakeupPageState extends State<MakeupPage> {
  InAppWebViewController? _webViewController;
  Completer<String?> cameraSetupCompleter = Completer();
  Completer? isFlippingCamera;
  late List<Permission> permissions;
  bool isRearCamera = true;
  bool isFlipCameraSupported = false;
  File? file;
  bool lipsClick = false;
  bool eyesClick = false;
  bool faceClick = false;
  bool nailsClick = false;
  bool hairClick = false;

  List<String> lipsType = ['Lip Color', 'Lip Liner', 'Lip Plumper'];
  List<String> eyesType = [
    'Eyebrows',
    'Eye Shadow',
    'Eye Liner',
    'Lenses',
    'EyeLashes'
  ];

  List<String> faceType = [
    'Foundation',
    'Concealar',
    'Contour',
    'Blusher',
    'Bronzer',
    'Highlighter'
  ];
  List<String> nailsType = [
    'Nail Polish',
    'Press-on Nails',
  ];
  List<String> hairType = [
    'Hair Color',
  ];

  @override
  void initState() {
    super.initState();
  }

  Future<bool> checkPermissionStatuses() async {
    for (var permission in permissions) {
      if (await permission.status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  clearAll() {
    lipsClick = false;
    eyesClick = false;
    faceClick = false;
    nailsClick = false;
    hairClick = false;
  }

  Widget makeupOrAccessoriesChoice() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Text(
                  'Make Up',
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
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Text(
                  'Accessories',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
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

  Widget itemMakeup(String path, GestureTapCallback? onTap) {
    return InkWell(
      onTap: onTap,
      child: Image.asset(path, width: 42, height: 56),
    );
  }

  Widget lipsItem(String type, GestureTapCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white),
        ),
        child: Text(
          type,
          style: const TextStyle(color: Colors.white, fontSize: 10),
        ),
      ),
    );
  }

  Widget lipsList() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        height: 30,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: lipsType.length,
          separatorBuilder: (_, __) => Constant.xSizedBox8,
          itemBuilder: (context, index) {
            return lipsItem(lipsType[index], () {
              if (index == 0) CusNav.nPush(context, const LipColorView());
              if (index == 1) CusNav.nPush(context, const LipLinerView());
              if (index == 2) CusNav.nPush(context, const LipPlumberView());
            });
          },
        ),
      ),
    );
  }

  Widget eyesItem(String type, GestureTapCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white),
        ),
        child: Text(
          type,
          style: const TextStyle(color: Colors.white, fontSize: 10),
        ),
      ),
    );
  }

  Widget eyesList() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: 30,
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: eyesType.length,
          separatorBuilder: (_, __) => Constant.xSizedBox8,
          itemBuilder: (context, index) {
            return eyesItem(eyesType[index], () {
              if (index == 0) CusNav.nPush(context, const EyebrowsView());
              if (index == 1) CusNav.nPush(context, const EyeshadowView());
              if (index == 2) CusNav.nPush(context, const EyelinerView());
              if (index == 3) CusNav.nPush(context, const LensesView());
              if (index == 4) {
                CusNav.nPush(context, LashesMascaraView(lashes: false));
              }
            });
          },
        ),
      ),
    );
  }

  Widget faceItem(String type, GestureTapCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white),
        ),
        child: Text(
          type,
          style: const TextStyle(color: Colors.white, fontSize: 10),
        ),
      ),
    );
  }

  Widget faceList() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        height: 30,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: faceType.length,
          separatorBuilder: (_, __) => Constant.xSizedBox8,
          itemBuilder: (context, index) {
            return faceItem(faceType[index], () {
              if (index == 0) CusNav.nPush(context, const FoundationView());
              if (index == 1) CusNav.nPush(context, const ConcealerView());
              if (index == 2) CusNav.nPush(context, const ContourView());
              if (index == 3) CusNav.nPush(context, const BlusherView());
              if (index == 4) CusNav.nPush(context, const BronzerView());
              if (index == 5) CusNav.nPush(context, const HighlighterView());
            });
          },
        ),
      ),
    );
  }

  Widget nailsItem(String type, GestureTapCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white),
        ),
        child: Text(
          type,
          style: const TextStyle(color: Colors.white, fontSize: 10),
        ),
      ),
    );
  }

  Widget nailsList() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        height: 30,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: nailsType.length,
          separatorBuilder: (_, __) => Constant.xSizedBox8,
          itemBuilder: (context, index) {
            return nailsItem(nailsType[index], () {
              if (index == 0) CusNav.nPush(context, const NailPolishView());
              if (index == 1) CusNav.nPush(context, const PresOnNailsView());
            });
          },
        ),
      ),
    );
  }

  Widget hairItem(String type, GestureTapCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white),
        ),
        child: Text(
          type,
          style: const TextStyle(color: Colors.white, fontSize: 10),
        ),
      ),
    );
  }

  Widget hairList() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        height: 30,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: hairType.length,
          separatorBuilder: (_, __) => Constant.xSizedBox8,
          itemBuilder: (context, index) {
            return hairItem(hairType[index], () {
              if (index == 0) CusNav.nPush(context, const HairView());
            });
          },
        ),
      ),
    );
  }

  Widget sheet() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black,
          ],
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 55,
            height: 3,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(22),
            ),
          ),
          Constant.xSizedBox24,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              itemMakeup(
                  (lipsClick == false
                      ? Assets.iconsIcLips
                      : Assets.iconsIcLipsOn), () {
                setState(() {
                  clearAll();
                  lipsClick = !lipsClick;
                });
              }),
              itemMakeup(
                  eyesClick == false
                      ? Assets.iconsIcEyes
                      : Assets.iconsIcEyesOn, () {
                setState(() {
                  clearAll();
                  eyesClick = !eyesClick;
                });
              }),
              itemMakeup(
                  faceClick == false
                      ? Assets.iconsIcFace
                      : Assets.iconsIcFaceOn, () {
                setState(() {
                  clearAll();
                  faceClick = !faceClick;
                });
              }),
              itemMakeup(
                  nailsClick == false
                      ? Assets.iconsIcNails
                      : Assets.iconsIcNailsOn, () {
                setState(() {
                  clearAll();
                  nailsClick = !nailsClick;
                });
              }),
              itemMakeup(
                  hairClick == false
                      ? Assets.iconsIcHair
                      : Assets.iconsIcHairOn, () {
                setState(() {
                  clearAll();
                  hairClick = !hairClick;
                });
              }),
            ],
          ),
          Constant.xSizedBox8,
          Constant.xSizedBox8,
          if (lipsClick) lipsList(),
          if (eyesClick) eyesList(),
          if (faceClick) faceList(),
          if (nailsClick) nailsList(),
          if (hairClick) hairList(),
          Constant.xSizedBox12,
        ],
      ),
    );
  }

  Widget cameraPreview() {
    return InAppWebView(
      initialUrlRequest: URLRequest(
          url: WebUri('${ApiConstant.techWebUrl}/virtual-try-on-web')),
      onWebViewCreated: (controller) async {
        _webViewController = controller;
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
        // toolbarHeight: 0,
        leadingWidth: 84,
        titleSpacing: 0,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.only(top: 8),
            // padding: EdgeInsets.all(8),
            // width: 64,
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
              // padding: EdgeInsets.only(right: 16, left: 16),
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
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
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
                          iconSidebar(() async {}, Assets.iconsIcFlipCamera),
                          Constant.xSizedBox12,
                          iconSidebar(() async {}, Assets.iconsIcScale),
                          Constant.xSizedBox12,
                          iconSidebar(() async {
                            setState(() {
                              // makeupOrAccessories = true;
                            });
                          }, Assets.iconsIcCompare),
                          Constant.xSizedBox12,
                          iconSidebar(() async {}, Assets.iconsIcReset),
                          Constant.xSizedBox12,
                          iconSidebar(() async {}, Assets.iconsIcChoose),
                          Constant.xSizedBox12,
                          iconSidebar(() async {}, Assets.iconsIcShare),
                        ],
                      ),
                    ),
                  ),
                  Constant.xSizedBox16,
                  sheet(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
