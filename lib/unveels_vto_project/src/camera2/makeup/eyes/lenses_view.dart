import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:test_new/unveels_vto_project/common/component/bottom_copyright.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_new/logic/get_product_utils/repository/product_repository.dart';
import 'package:test_new/unveels_vto_project//common/component/custom_navigator.dart';
import 'package:test_new/unveels_vto_project//common/helper/constant.dart';
import 'package:test_new/unveels_vto_project//generated/assets.dart';
import 'package:test_new/unveels_vto_project//src/camera2/camera_page2.dart';
import 'package:test_new/unveels_vto_project//src/camera2/camera_video_page.dart';
import 'package:test_new/unveels_vto_project/common/component/vto_product_item.dart';
import 'package:test_new/unveels_vto_project//utils/utils.dart';

const xHEdgeInsets12 = EdgeInsets.symmetric(horizontal: 12);

class LensesView extends StatefulWidget {
  const LensesView({super.key});

  @override
  State<LensesView> createState() => _LensesViewState();
}

class _LensesViewState extends State<LensesView> {
  InAppWebViewController? _webViewController;
  bool _showContent = true;
  Completer? isFlippingCamera;
  late List<Permission> permissions;
  bool isRearCamera = true;
  bool isFlipCameraSupported = false;
  File? file;
  double sliderValue = 0;
  bool onOffVisible = false;
  int? colorSelected = 0;
  int? lensesSelected = 0;

  final Dio dio = Dio();
  List<ProductData>? products;
  bool _isLoading = false;
  final ProductRepository productRepository = ProductRepository();

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
    });
    print("Fetching data");
    try {
      var dataResponse = await productRepository.fetchProducts(
          // texture: textures!.isEmpty ? null : textures.join(","),
          lenses: '');
      setState(() {
        products = dataResponse;
      });
    } catch (e) {
      print("err");
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<Color> colorMainList = [
    const Color(0xffFE3699),
    const Color(0xffE1E1A3),
    const Color(0xff3D0B0B),
    const Color(0xffFF0000),
    Colors.white,
  ];

  List<String> colorMainListString = [
    'Pink',
    'Beige',
    'Brown',
    'Red',
    'White',
  ];
  List<Color> colorList = [
    const Color(0xff3D2B1F),
    const Color(0xff5C4033),
    const Color(0xff6A4B3A),
    const Color(0xff8B4513),
    const Color(0xff7B3F00),
    const Color(0xff4F300D),
    const Color(0xff483C32),
    const Color(0xff342112),
    const Color(0xff4A2912),
  ];

  List<String> type1List = [
    'Sheer',
    'Matt',
    'Gloss',
  ];

  List<String> type2List = [
    'One',
    'Dual',
    'Tri',
    'Quadra',
    'Penta',
  ];

  List<Widget> typeLenses = [
    Image.asset(Assets.imagesImgLenses1),
    Image.asset(Assets.imagesImgLenses2),
    Image.asset(Assets.imagesImgLenses3),
    Image.asset(Assets.imagesImgLenses4),
    Image.asset(Assets.imagesImgLenses5),
  ];

  @override
  void initState() {
    super.initState();

    fetchData();
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

  Widget colorChip() {
    return SizedBox(
      height: 30,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: colorMainList.length,
        separatorBuilder: (_, __) => Constant.xSizedBox8,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                colorSelected = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: index == colorSelected
                        ? Colors.white
                        : Colors.transparent),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                      radius: 8, backgroundColor: colorMainList[index]),
                  Constant.xSizedBox4,
                  Text(
                    colorMainListString[index],
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget colorChoice() {
    return SizedBox(
      height: 30,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: colorList.length,
        separatorBuilder: (_, __) => Constant.xSizedBox12,
        itemBuilder: (context, index) {
          if (index == 0) {
            return InkWell(
              onTap: () async {},
              child: const Icon(Icons.do_not_disturb_alt_sharp,
                  color: Colors.white, size: 25),
            );
          }
          return InkWell(
              onTap: () async {},
              child:
                  CircleAvatar(radius: 12, backgroundColor: colorList[index]));
        },
      ),
    );
  }

  Widget separator() {
    return const Divider(thickness: 1, color: Colors.white);
  }

  Widget typeLensesChip() {
    return SizedBox(
      height: 30,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: typeLenses.length,
        separatorBuilder: (_, __) => Constant.xSizedBox8,
        itemBuilder: (context, index) {
          if (index == 0) {
            return InkWell(
              onTap: () async {
                setState(() {
                  onOffVisible = true;
                });
              },
              child: const Icon(Icons.do_not_disturb_alt_sharp,
                  color: Colors.white, size: 25),
            );
          }
          return InkWell(
            onTap: () async {
              setState(() {
                lensesSelected = index;
                onOffVisible = false;
              });
              fetchData();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                    color: index == lensesSelected && onOffVisible == false
                        ? Colors.white
                        : Colors.transparent),
              ),
              child: typeLenses[index],
            ),
          );
        },
      ),
    );
  }

  Widget lipstickChoice() {
    if (_isLoading) {
      return SizedBox(
          height: 130,
          child: Column(
            children: [
              Container(color: Colors.white, width: 100, height: 68),
            ],
          ));
    }

    if (products!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 130,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: products?.length ?? 0,
          separatorBuilder: (_, __) => Constant.xSizedBox12,
          itemBuilder: (context, index) {
            // if (index == 0)
            //   return InkWell(
            //     onTap: () async {},
            //     child: Icon(Icons.do_not_disturb_alt_sharp,
            //         color: Colors.white, size: 25),
            //   );
            var product = products?[index];
            if (product != null) {
              return VtoProductItem(product: product);
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  Widget slider() {
    return SizedBox(
      height: 60,
      child: Column(
        children: [
          Slider(
            thumbColor: const Color(0xffCA9C43),
            activeColor: const Color(0xffCA9C43),
            value: sliderValue,
            max: 10,
            min: 0,
            onChanged: (v) {
              setState(() {
                sliderValue = v;
              });
              fetchData();
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Light',
                    style: TextStyle(color: Colors.white, fontSize: 8)),
                Text('Dark',
                    style: TextStyle(color: Colors.white, fontSize: 8)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sheet() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_showContent) ...[
            Constant.xSizedBox8,
            colorChip(),
            Constant.xSizedBox8,
            separator(),
            Constant.xSizedBox4,
            typeLensesChip(),
            Constant.xSizedBox32,
            lipstickChoice(),
          ],
          BottomCopyright(
            showContent: _showContent,
            onTap: () {
              setState(() {
                _showContent = !_showContent;
              });
            },
          ),
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
          onTap: () {
            CusNav.nPop(context);
          },
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
                  // file != null ? pictureTaken() : noPictureTaken(),
                  // pictureTaken(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
