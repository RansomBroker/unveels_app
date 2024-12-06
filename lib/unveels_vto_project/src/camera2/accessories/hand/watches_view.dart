import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:test_new/unveels_vto_project/common/component/bottom_copyright.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_new/logic/get_product_utils/get_material.dart';
import 'package:test_new/logic/get_product_utils/get_product_types.dart';
import 'package:test_new/logic/get_product_utils/get_shape.dart';
import 'package:test_new/logic/get_product_utils/repository/product_repository.dart';
import 'package:test_new/unveels_vto_project//common/component/custom_navigator.dart';
import 'package:test_new/unveels_vto_project//common/helper/constant.dart';
import 'package:test_new/unveels_vto_project//generated/assets.dart';
import 'package:test_new/unveels_vto_project//src/camera2/camera_page2.dart';
import 'package:test_new/unveels_vto_project//src/camera2/camera_video_page.dart';
import 'package:test_new/unveels_vto_project/common/component/vto_product_item.dart';
import 'package:test_new/unveels_vto_project//utils/utils.dart';
import 'package:test_new/unvells/constants/app_constants.dart';

const xHEdgeInsets12 = EdgeInsets.symmetric(horizontal: 12);

class WatchesView extends StatefulWidget {
  const WatchesView({super.key});

  @override
  State<WatchesView> createState() => _WatchesViewState();
}

class _WatchesViewState extends State<WatchesView> {
  InAppWebViewController? _webViewController;
  bool _showContent = true;
  Completer? isFlippingCamera;
  late List<Permission> permissions;
  bool isRearCamera = true;
  bool isFlipCameraSupported = false;
  File? file;
  bool shapesOrdMaterial = false;
  bool onOffVisible = false;
  bool colorShapesOrMaterial = false;
  int? shapesSelected = 0;
  int? materialSelected = 0;
  int? colorSelected = 0;
  int? colorTextSelected = 0;

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
      List<String>? productTypes =
          getProductTypesByLabels("hand_accessories_product_type", ["Watches"]);
      print(productTypes);

      var dataResponse = await productRepository.fetchProducts(
          // texture: textures!.isEmpty ? null : textures.join(","),
          material: !shapesOrdMaterial
              ? null
              : getMaterialByLabel(materialList[materialSelected!]),
          shape: shapesOrdMaterial
              ? null
              : getShapeByLabel(shapesList[shapesSelected!]),
          productType: "hand_accessories_product_type",
          productTypes: productTypes?.join(","));

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

  @override
  void initState() {
    super.initState();
  }

  List<String> colorsTextList = [
    "Yellow",
    "Black",
    "Silver",
    "Gold",
    "Rose Gold",
  ];
  List<Color> circleColorList = [
    const Color(0xFFFFFF00),
    Colors.black,
    const Color(0xFFC0C0C0),
    const Color(0xFFCA9C43),
    const Color(0xFFB76E79),
  ];
  List<Color> colorChoiceList = [
    const Color(0xFF740039),
    const Color(0xFF8D0046),
    const Color(0xFFB20058),
    const Color(0xFFB51F69),
    const Color(0xFFDF1050),
    const Color(0xFFE31B7B),
    const Color(0xFFFE3699),
    const Color(0xFFE861A4),
    const Color(0xFFE0467C),
  ];

  List<String> materialList = [
    'Silver',
    'Silver Plated',
    'Gold Plated',
    'Brass',
    'Stair'
  ];

  List<String> shapesPath = [
    Assets.iconsIcCircle,
    Assets.iconsIcSquare,
    Assets.iconsIcOval,
    Assets.iconsIcRectangle,
  ];
  List<String> shapesList = ['Circle', 'Square', 'Oval', 'Rectangle'];

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

  Widget shapesOrdMaterialChoice() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  shapesOrdMaterial = false;
                  colorShapesOrMaterial = false;
                });
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Text(
                  'Shapes',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    shadows: colorShapesOrMaterial == false
                        ? [
                            const BoxShadow(
                              offset: Offset(0, 0),
                              color: Colors.yellow,
                              spreadRadius: 0,
                              blurRadius: 10,
                            )
                          ]
                        : null,
                  ),
                ),
              ),
            ),
          ),
          Constant.xSizedBox12,
          Container(
            height: 25,
            width: 1,
            color: Colors.white,
          ),
          Constant.xSizedBox12,
          Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  shapesOrdMaterial = true;
                  colorShapesOrMaterial = true;
                });
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Text(
                  'Material',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    shadows: colorShapesOrMaterial == true
                        ? [
                            const BoxShadow(
                              offset: Offset(0, 0),
                              color: Colors.yellow,
                              spreadRadius: 0,
                              blurRadius: 10,
                            )
                          ]
                        : null,
                  ),
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

  Widget colorChip() {
    return SizedBox(
      height: 30,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: colorsTextList.length,
        separatorBuilder: (_, __) => Constant.xSizedBox8,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                colorTextSelected = index;
              });
              fetchData();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: index == colorTextSelected
                        ? Colors.white
                        : Colors.transparent),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                      radius: 8, backgroundColor: circleColorList[index]),
                  Constant.xSizedBox4,
                  Text(
                    colorsTextList[index],
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
        itemCount: colorChoiceList.length,
        separatorBuilder: (_, __) => Constant.xSizedBox12,
        itemBuilder: (context, index) {
          if (index == 0) {
            return InkWell(
              onTap: () async {
                setState(() {
                  onOffVisible = true;
                });
                fetchData();
              },
              child: const Icon(Icons.do_not_disturb_alt_sharp,
                  color: Colors.white, size: 25),
            );
          }
          return InkWell(
              onTap: () async {
                setState(() {
                  colorSelected = index;
                  onOffVisible = false;
                });
                fetchData();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: index == colorSelected && onOffVisible == false
                          ? Colors.white
                          : Colors.transparent),
                ),
                child: CircleAvatar(
                    radius: 12, backgroundColor: colorChoiceList[index]),
              ));
        },
      ),
    );
  }

  Widget shapesChoice() {
    return SizedBox(
      height: 23,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: shapesList.length,
        separatorBuilder: (_, __) => Constant.xSizedBox12,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                shapesSelected = index;
              });
              fetchData();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              decoration: BoxDecoration(
                color: index == shapesSelected ? const Color(0xffCA9C43) : null,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white),
              ),
              child: Row(
                children: [
                  Image.asset(shapesPath[index]),
                  Constant.xSizedBox4,
                  Text(
                    shapesList[index],
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

  Widget materialChoice() {
    return SizedBox(
      height: 23,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: materialList.length,
        separatorBuilder: (_, __) => Constant.xSizedBox12,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                materialSelected = index;
              });
              fetchData();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              decoration: BoxDecoration(
                color:
                    index == materialSelected ? const Color(0xffCA9C43) : null,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white),
              ),
              child: Center(
                child: Text(
                  materialList[index],
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),
          );
        },
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
            Constant.xSizedBox8,
            colorChip(),
            Constant.xSizedBox8,
            colorChoice(),
            Constant.xSizedBox4,
            separator(),
            shapesOrdMaterialChoice(),
            Constant.xSizedBox4,
            shapesOrdMaterial == false ? shapesChoice() : materialChoice(),
            Constant.xSizedBox8,
            lipstickChoice(),
            Constant.xSizedBox8
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
                            setState(() {});
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
