import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_new/logic/get_product_utils/get_product_types.dart';
import 'package:test_new/logic/get_product_utils/get_textures.dart';
import 'package:test_new/logic/get_product_utils/repository/product_repository.dart';
import 'package:test_new/unveels_vto_project//common/component/custom_navigator.dart';
import 'package:test_new/unveels_vto_project//common/helper/constant.dart';
import 'package:test_new/unveels_vto_project//generated/assets.dart';
import 'package:test_new/unveels_vto_project//src/camera2/camera_video_page.dart';
import 'package:test_new/unveels_vto_project/common/component/bottom_copyright.dart';
import 'package:test_new/unveels_vto_project/common/component/vto_product_item.dart';
import 'package:test_new/unveels_vto_project/utils/color_utils.dart';
import 'package:test_new/unvells/constants/app_constants.dart';

const xHEdgeInsets12 = EdgeInsets.symmetric(horizontal: 12);

class LipColorView extends StatefulWidget {
  const LipColorView({super.key});

  @override
  State<LipColorView> createState() => _LipColorViewState();
}

class _LipColorViewState extends State<LipColorView> {
  InAppWebViewController? _webViewController;
  bool _showContent = true;
  Completer<String?> cameraSetupCompleter = Completer();
  Completer? isFlippingCamera;
  late List<Permission> permissions;
  bool isRearCamera = true;
  bool isFlipCameraSupported = false;
  File? file;
  bool onOffVisibel = false;
  int? mainColorSelected;
  int? colorSelected;
  int? typeColorSelected;
  int? typeColor2Selected = 0;
  List<int>? selectedColors;

  final Dio dio = Dio();
  List<ProductData>? productsData;
  List<ProductData>? products;
  bool _isLoading = false;
  final ProductRepository productRepository = ProductRepository();

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      List<String>? textures;
      if (typeColorSelected != null) {
        textures = getTextureByLabel([chipList[typeColorSelected!]]);
      }

      List<String>? productTypes =
          getProductTypesByLabels("lips_makeup_product_type", [
        "Lipsticks",
        "Lip Stains",
        "Lip Tints",
        "Lip Balms",
      ]);

      var dataResponse = await productRepository.fetchProducts(
          texture: textures?.join(","),
          productType: "lips_makeup_product_type",
          productTypes: productTypes?.join(","));

      setState(() {
        products = dataResponse;
        if (products != null) {
          if (mainColorSelected == null) {
            colorChoiceList = getSelectableColorList(dataResponse, null) ?? [];
          } else {
            colorChoiceList = getSelectableColorList(
                    products!, vtoColors[mainColorSelected!].value) ??
                [];
            products = dataResponse
                .where((e) => e.color == vtoColors[mainColorSelected!].value)
                .toList();
            print(vtoColors[mainColorSelected!].value);
          }
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

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  void tryOn() {
    final showLipColor = (typeColor2Selected == 0 && colorSelected != null) ||
        (typeColor2Selected != 0 &&
            selectedColors != null &&
            selectedColors!.isNotEmpty);

    final lipColors = typeColor2Selected == 0
        ? [toWebHex(colorChoiceList[colorSelected!])]
        : selectedColors!
            .map((index) => toWebHex(colorChoiceList[index]))
            .toList();

    final lipColorMode =
        typeColor2Selected == 0 ? 'One' : chip2List[typeColor2Selected!];

    _webViewController?.evaluateJavascript(
      source: """
    window.postMessage(JSON.stringify({
      "showLipColor": $showLipColor,
      ${showLipColor ? '"lipColor": ${jsonEncode(lipColors)}, "lipColorMode": "$lipColorMode",' : ''}
    }), "*");
    """,
    );
  }

  List<String> lipList = [
    "Yellow",
    "Black",
    "Silver",
    "Gold",
    "Rose Gold",
  ];
  List<Color> lipColorList = [
    const Color(0xFFFFFF00),
    Colors.black,
    const Color(0xffC0C0C0),
    const Color(0xffCA9C43),
    const Color(0xffB76E79),
  ];
  List<Color> colorChoiceList = [];
  List<String> chipList = texturesLabel;
  List<String> chip2List = [
    'One',
    'Dual',
    'Ombre',
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

  Widget colorChip() {
    return SizedBox(
      height: 30,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: vtoColors.length,
        separatorBuilder: (_, __) => Constant.xSizedBox8,
        itemBuilder: (context, index) {
          ColorModel color = vtoColors[index];
          return InkWell(
            onTap: () {
              setState(() {
                mainColorSelected = index;
                fetchData();
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: mainColorSelected == index
                        ? Colors.white
                        : Colors.transparent),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      gradient: color.hex.startsWith('linear-gradient')
                          ? getLinearGradient(color.hex)
                          : null,
                      color: (color.hex == 'none' ||
                              color.hex.startsWith('linear-gradient'))
                          ? null
                          : Color(int.parse('0xFF${color.hex.substring(1)}')),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Constant.xSizedBox4,
                  Text(
                    color.label,
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
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 30,
        child: Row(
          children: [
            InkWell(
              onTap: () async {
                setState(() {
                  colorSelected = null;
                  onOffVisibel = true;
                });
                tryOn();
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
                scrollDirection: Axis.horizontal,
                itemCount: colorChoiceList.length,
                separatorBuilder: (_, __) => Constant.xSizedBox12,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      setState(() {
                        if (typeColor2Selected == 0) {
                          colorSelected = index;
                          onOffVisibel = false;
                        } else {
                          if (selectedColors == null) {
                            selectedColors = [index];
                          } else {
                            if (selectedColors!.contains(index)) {
                              selectedColors!.remove(index);
                            } else {
                              if (selectedColors!.length < 2) {
                                selectedColors!.add(index);
                              } else {
                                selectedColors![1] = index;
                              }
                            }
                          }
                          colorSelected = selectedColors?.isNotEmpty == true
                              ? selectedColors!.last
                              : null;
                        }
                        fetchData();
                      });
                      tryOn();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 1, vertical: 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: (typeColor2Selected == 0
                                  ? (index == colorSelected &&
                                      onOffVisibel == false)
                                  : (selectedColors?.contains(index) == true))
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
    );
  }

  Widget chipChoice() {
    return SizedBox(
      height: 18,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: chipList.length,
        separatorBuilder: (_, __) => Constant.xSizedBox12,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                typeColorSelected = index;
                fetchData();
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              decoration: BoxDecoration(
                color:
                    typeColorSelected == index ? const Color(0xffCA9C43) : null,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: typeColorSelected == index
                        ? Colors.white
                        : Colors.transparent),
              ),
              child: Text(
                chipList[index],
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          );
        },
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

  Widget typeChip() {
    return SizedBox(
      height: 30,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        separatorBuilder: (_, __) => Constant.xSizedBox8,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white),
            ),
            child: const Center(
              child: Text(
                'Sheer',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget typeText() {
    return SizedBox(
      height: 30,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        separatorBuilder: (_, __) => Constant.xSizedBox8,
        itemBuilder: (context, index) {
          return Center(
            child: Text(
              'Ombre',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                shadows: index != 0
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
            Constant.xSizedBox8,
            separator(),
            Constant.xSizedBox4,
            chipChoice(),
            Constant.xSizedBox4,
            separator(),
            chip2Choice(),
            separator(),
            lipstickChoice()
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: const EdgeInsets.only(right: 16),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
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
          )
        ],
      ),
    );
  }
}
