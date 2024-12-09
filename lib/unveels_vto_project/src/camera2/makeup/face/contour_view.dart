import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:test_new/unveels_vto_project/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:test_new/logic/get_product_utils/get_product_types.dart';
import 'package:test_new/logic/get_product_utils/repository/product_repository.dart';
import 'package:test_new/unveels_vto_project//common/helper/constant.dart';
import 'package:test_new/unveels_vto_project//generated/assets.dart';
import 'package:test_new/unveels_vto_project/common/component/vto_product_item.dart';

const xHEdgeInsets12 = EdgeInsets.symmetric(horizontal: 12);

class ContourView extends StatefulWidget {
  final InAppWebViewController? webViewController;

  const ContourView({super.key, this.webViewController});

  @override
  State<ContourView> createState() => _ContourViewState();
}

class _ContourViewState extends State<ContourView> {
  bool oneOrDual = false;
  bool onOffVisibel = false;
  bool onOffVisibel1 = false;
  int? skinSelected;
  int? colorSelected = 0;
  List<int>? selectedColors;

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
      // print(textures);
      List<String>? productTypes =
          getProductTypesByLabels("face_makeup_product_type", ["Contouring"]);
      print(productTypes);

      var dataResponse = await productRepository.fetchProducts(
          // texture: textures!.isEmpty ? null : textures.join(","),
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

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  void tryOn() {
    final show = (oneOrDual == true && colorSelected != null) ||
        (!oneOrDual && selectedColors != null && selectedColors!.isNotEmpty);

    final colors = oneOrDual
        ? [toWebHex(colorChoiceList[colorSelected!])]
        : selectedColors!
            .map((index) => toWebHex(colorChoiceList[index]))
            .toList();

    final colorMode = oneOrDual ? 'One' : "Dual";

    widget.webViewController?.evaluateJavascript(
      source: """
    window.postMessage(JSON.stringify({
      "showContour": $show,
      ${show ? '"contourColors": ${jsonEncode(colors)}, "contourColorMode": "$colorMode",' : ''}
    }), "*");
    """,
    );
  }

  List<String> skinList = [
    "Light skin",
    "Medium skin",
    "Dark skin",
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
  List<String> contourList = [
    Assets.contour1,
    Assets.contour2,
    Assets.contour3,
    Assets.contour4,
    Assets.contour5,
    Assets.contour6,
  ];

  Widget colorChip() {
    return SizedBox(
      height: 30,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: skinList.length,
        separatorBuilder: (_, __) => Constant.xSizedBox8,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: index == 0 ? Colors.white : Colors.transparent),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(radius: 8, backgroundColor: skinColorList[index]),
                Constant.xSizedBox4,
                Text(
                  skinList[index],
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ],
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
                        if (oneOrDual == true) {
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
                          color: (oneOrDual == true
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

  Widget bronzerChoice() {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 55,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: contourList.length,
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
                    color: index == skinSelected && onOffVisibel1 == false
                        ? Colors.white
                        : Colors.transparent),
              ),
              child: InkWell(
                  onTap: () async {
                    setState(() {
                      skinSelected = index;
                      onOffVisibel1 = false;
                    });
                    fetchData();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset(contourList[index]),
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
          height: 135,
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
        height: 135,
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Constant.xSizedBox8,
          // colorChip(),
          colorChoice(),
          Constant.xSizedBox8,
          separator(),
          Row(
            children: [
              InkWell(
                  onTap: () {
                    setState(() {
                      oneOrDual = true;
                    });
                    fetchData();
                  },
                  child: Text(
                    "One",
                    style: oneOrDual == true
                        ? Constant.whiteBold16.copyWith(fontSize: 12)
                        : Constant.whiteRegular12,
                  )),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      oneOrDual = false;
                    });
                    fetchData();
                  },
                  child: Text(
                    "Dual",
                    style: oneOrDual == false
                        ? Constant.whiteBold16.copyWith(fontSize: 12)
                        : Constant.whiteRegular12,
                  )),
            ],
          ),
          separator(),
          bronzerChoice(),
          Constant.xSizedBox4,
          separator(),
          const Align(
              alignment: Alignment.centerRight,
              child: Text(
                "View All",
                style: TextStyle(color: Colors.white, fontSize: 12),
              )),
          Constant.xSizedBox4,
          lipstickChoice(),
          // Constant.xSizedBox8,
        ],
      ),
    );
  }
}
