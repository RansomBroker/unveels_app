import 'dart:async';
import 'dart:convert';
import 'dart:developer';
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

class EyelinerView extends StatefulWidget {
  const EyelinerView({super.key});

  @override
  State<EyelinerView> createState() => _EyelinerViewState();
}

class _EyelinerViewState extends State<EyelinerView> {
  InAppWebViewController? _webViewController;
  bool _showContent = true;
  Completer? isFlippingCamera;
  late List<Permission> permissions;
  bool isRearCamera = true;
  bool isFlipCameraSupported = false;
  File? file;
  double sliderValue = 0;
  bool onOffVisible = false;
  int? eyebrowSelected = 0;
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
      // print("Trying to fetch");
      // List<String>? textures =
      //     getTextureByLabel([chipList[typeColorSelected!]]);
      List<String>? productTypes =
          getProductTypesByLabels("eye_makeup_product_type", [
        "Eyeliners",
      ]);
      print(productTypes);

      var dataResponse = await productRepository.fetchProducts(
          // texture: textures!.isEmpty ? null : textures.join(","),
          productType: "eye_makeup_product_type",
          productTypes: productTypes?.join(","));
      setState(() {
        products = dataResponse;
        if (products != null) {
          if (colorTextSelected == null) {
            colorList = getSelectableColorList(dataResponse, null) ?? [];
          } else {
            colorList = getSelectableColorList(
                    products!, vtoColors[colorTextSelected!].value) ??
                [];
            products = dataResponse
                .where((e) => e.color == vtoColors[colorTextSelected!].value)
                .toList();
            print(vtoColors[colorTextSelected!].value);
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

  List<Widget> typeEyeLiner = [
    Image.asset(Assets.imagesImgEyeliner1),
    Image.asset(Assets.imagesImgEyeliner2),
    Image.asset(Assets.imagesImgEyeliner3),
    Image.asset(Assets.imagesImgEyeliner4),
    Image.asset(Assets.imagesImgEyeliner5),
    Image.asset(Assets.imagesImgEyeliner6),
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
        itemCount: vtoColors.length,
        separatorBuilder: (_, __) => Constant.xSizedBox8,
        itemBuilder: (context, index) {
          var color = vtoColors[index];
          return InkWell(
            onTap: () {
              setState(() {
                colorTextSelected = index;
              });
              fetchData();
              tryOn();
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
                    vtoColors[index].label,
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
      child: Row(
        children: [
          InkWell(
            onTap: () async {
              setState(() {
                colorSelected = null;
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
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: colorList.length,
              separatorBuilder: (_, __) => Constant.xSizedBox12,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () async {
                      setState(() {
                        colorSelected = index;
                        onOffVisible = true;
                      });
                      fetchData();
                      tryOn();
                    },
                    child: Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: index == colorSelected && onOffVisible == true
                                  ? Colors.white
                                  : Colors.transparent),
                        ),
                        child: CircleAvatar(
                            radius: 12, backgroundColor: colorList[index])));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget separator() {
    return const Divider(thickness: 1, color: Colors.white);
  }

  Widget typeEyeLinerChip() {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: typeEyeLiner.length,
        separatorBuilder: (_, __) => Constant.xSizedBox8,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () async {
              setState(() {
                eyebrowSelected = index;
              });
              fetchData();
              tryOn();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                    color: index == eyebrowSelected
                        ? Colors.white
                        : Colors.transparent),
              ),
              child: typeEyeLiner[index],
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
              tryOn();
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
            colorChoice(),
            Constant.xSizedBox8,
            separator(),
            Constant.xSizedBox4,
            typeEyeLinerChip(),
            Constant.xSizedBox8,
            separator(),
            Constant.xSizedBox4,
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

  void tryOn() {
    Color color = colorMainList[colorTextSelected ?? 0];
    if (onOffVisible == true && colorSelected != null) {
      color = colorList[colorSelected ?? 0];
    }

    var json = jsonEncode({
      "showEyeliner": true,
      "eyelinerColor": toWebHex(color),
      "eyelinerPattern": eyebrowSelected,
      // "eyelinerPattern": "cat-eye",
    });
    String source = 'window.postMessage(JSON.stringify($json),"*");';
    log(source, name: 'postMessage');
    _webViewController?.evaluateJavascript(
      source: source,
    );
  }
}
