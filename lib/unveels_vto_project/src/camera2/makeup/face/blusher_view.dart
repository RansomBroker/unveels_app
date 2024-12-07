import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:test_new/unveels_vto_project/common/component/bottom_copyright.dart';
import 'package:test_new/unveels_vto_project/utils/color_utils.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_new/logic/get_product_utils/get_product_types.dart';
import 'package:test_new/logic/get_product_utils/repository/product_repository.dart';
import 'package:test_new/unveels_vto_project//common/component/custom_navigator.dart';
import 'package:test_new/unveels_vto_project//common/helper/constant.dart';
import 'package:test_new/unveels_vto_project//generated/assets.dart';
import 'package:test_new/unveels_vto_project//src/camera2/camera_video_page.dart';
import 'package:test_new/unveels_vto_project/common/component/vto_product_item.dart';

const xHEdgeInsets12 = EdgeInsets.symmetric(horizontal: 12);

class BlusherView extends StatefulWidget {
  const BlusherView({super.key});

  @override
  State<BlusherView> createState() => _BlusherViewState();
}

class _BlusherViewState extends State<BlusherView> {
  InAppWebViewController? _webViewController;
  bool _showContent = true;
  Completer? isFlippingCamera;
  late List<Permission> permissions;
  bool isRearCamera = true;
  bool isFlipCameraSupported = false;
  File? file;
  bool makeupOrAccessories = false;
  bool onOffVisibel = false;
  int? skinSelected;
  int? colorSelected;
  int? typeSelected;
  int typeColor2Selected = 0;
  List<int> selectedColors = [];

  final Dio dio = Dio();
  List<ProductData>? products;
  bool _isLoading = false;
  final ProductRepository productRepository = ProductRepository();

  Future<void> fetchData() async {
    tryOn();
    setState(() {
      _isLoading = true;
    });
    print("Fetching data");
    try {
      List<String>? productTypes =
          getProductTypesByLabels("face_makeup_product_type", ["Blushes"]);
      print(productTypes);

      var dataResponse = await productRepository.fetchProducts(
          productType: "face_makeup_product_type",
          productTypes: productTypes?.join(","));
      setState(() {
        products = dataResponse;
        if (products != null) {
          colorChoiceList = getSelectableColorList(dataResponse, null) ?? [];
        }
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

  void tryOn() {
    final show = (typeColor2Selected == 0 && colorSelected != null) ||
        (typeColor2Selected != 0 && selectedColors.isNotEmpty);

    final colors = typeColor2Selected == 0
        ? [toWebHex(colorChoiceList[colorSelected!])]
        : selectedColors
            .map((index) => toWebHex(colorChoiceList[index]))
            .toList();

    final mode = chip2List[typeColor2Selected];

    _webViewController?.evaluateJavascript(
      source: """
    window.postMessage(JSON.stringify({
      "setShowBlush": $show,
      ${show ? '"blushColor": ${jsonEncode(colors)}, "blushMode": "$mode","blushPattern": "$skinSelected",' : ''}
    }), "*");
    """,
    );
  }

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  List<String> typeList = [
    "Shimmer",
    "Matt",
    "Gloss",
  ];
  List<Color> skinColorList = [
    const Color(0xFFFDD8B7),
    const Color(0xFFD08A59),
    const Color(0xFF45260D),
  ];
  List<Color> colorChoiceList = [
    const Color(0xFF3D2B1F),
    const Color(0xFF5C4033),
    const Color(0xFF694B3A),
    const Color(0xFF8A4513),
    const Color(0xFF7A3F00),
    const Color(0xFF4F300D),
    const Color(0xFF483C32),
    const Color(0xFF342112),
    const Color(0xFF4A2912),
  ];
  List<String> blusherList = [
    Assets.imagesImgBlusher1,
    Assets.imagesImgBlusher2,
    Assets.imagesImgBlusher3,
    Assets.imagesImgBlusher4,
    Assets.imagesImgBlusher5,
  ];

  List<String> chip2List = [
    'One',
    'Dual',
    'Tri',
  ];

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
                  onTap: () async {},
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

  Widget chip2Choice() {
    return SizedBox(
      height: 18,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: chip2List.length,
        separatorBuilder: (_, __) => Constant.xSizedBox12,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                typeColor2Selected = index;
              });
            },
            child: Text(
              chip2List[index],
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                shadows: typeColor2Selected != index
                    ? null
                    : [
                        const BoxShadow(
                          offset: Offset(0, 0),
                          color: Colors.white,
                          spreadRadius: 0,
                          blurRadius: 10,
                        ),
                      ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget typeChip() {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 20,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: typeList.length,
          separatorBuilder: (_, __) => Constant.xSizedBox8,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  typeSelected = index;
                });
                fetchData();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: index == typeSelected
                          ? Colors.white
                          : Colors.transparent),
                ),
                child: Center(
                  child: Text(
                    typeList[index],
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget colorChoice() {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 30,
        child: Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            height: 30,
            child: Row(
              children: [
                InkWell(
                  onTap: () async {
                    setState(() {
                      selectedColors.clear();
                    });
                    fetchData();
                  },
                  child: const Icon(
                    Icons.do_not_disturb_alt_sharp,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: colorChoiceList.length,
                    separatorBuilder: (_, __) => Constant.xSizedBox12,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return InkWell(
                          onTap: () async {
                            setState(() {
                              selectedColors.clear();
                            });
                            fetchData();
                          },
                          child: const Icon(
                            Icons.do_not_disturb_alt_sharp,
                            color: Colors.white,
                            size: 25,
                          ),
                        );
                      }
                      return InkWell(
                        onTap: () async {
                          setState(() {
                            setState(() {
                              if (selectedColors.contains(index)) {
                                selectedColors.remove(index);
                              } else {
                                if (selectedColors.length <
                                    typeColor2Selected + 1) {
                                  selectedColors.add(index);
                                } else {
                                  selectedColors.removeAt(0);
                                  selectedColors.add(index);
                                }
                              }
                            });
                          });
                          fetchData();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 1, vertical: 1),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: selectedColors.contains(index)
                                  ? Colors.white
                                  : Colors.transparent,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: colorChoiceList[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget highlighterChoice() {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 55,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: blusherList.length,
          separatorBuilder: (_, __) => Constant.xSizedBox12,
          itemBuilder: (context, index) {
            // if (index == 0)
            //   return InkWell(
            //     onTap: () async {},
            //     child: Icon(Icons.do_not_disturb_alt_sharp,
            //         color: Colors.white, size: 25),
            //   );
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: index == skinSelected
                        ? Colors.white
                        : Colors.transparent),
              ),
              child: InkWell(
                  onTap: () async {
                    setState(() {
                      skinSelected = index;
                    });
                    fetchData();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset(blusherList[index]),
                      ),
                    ],
                  )),
            );
          },
        ),
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

  Widget separator() {
    return const Divider(thickness: 1, color: Colors.white);
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
            // Constant.xSizedBox8,
            // colorChip(),
            colorChoice(),
            Constant.xSizedBox8,
            separator(),
            typeChip(),
            separator(),
            highlighterChoice(),
            Constant.xSizedBox4,
            separator(),
            chip2Choice(),
            separator(),
            lipstickChoice(),
            // Constant.xSizedBox8,
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
        titleSpacing: 0,
        leading: InkWell(
          onTap: () {
            CusNav.nPop(context);
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
                              makeupOrAccessories = true;
                            });
                          }, Assets.iconsIcCompareOff),
                          Constant.xSizedBox12,
                          iconSidebar(() async {}, Assets.iconsIcResetOff),
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
                  // ureTaken(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
