import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:test_new/unveels_vto_project/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:test_new/logic/get_product_utils/get_product_types.dart';
import 'package:test_new/logic/get_product_utils/repository/product_repository.dart';
import 'package:test_new/unveels_vto_project//common/helper/constant.dart';
import 'package:test_new/unveels_vto_project//generated/assets.dart';
import 'package:test_new/unveels_vto_project/common/component/vto_product_item.dart';

class EyeshadowView extends StatefulWidget {
  final InAppWebViewController? webViewController;
  const EyeshadowView({super.key, this.webViewController});

  @override
  State<EyeshadowView> createState() => _EyeshadowViewState();
}

class _EyeshadowViewState extends State<EyeshadowView> {
  int? eyebrowSelected = 0;
  List<int> colorSelected = [];
  int? colorTextSelected;
  int? typeSelected;
  int? typeComboSelected = 0;

  int get maxColorSelected => (typeComboSelected ?? 0) + 1;

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
        "Eyeshadows",
      ]);
      print(productTypes);

      var dataResponse = await productRepository.fetchProducts(
          // texture: textures!.isEmpty ? null : textures.join(","),
          productType: "eye_makeup_product_type",
          productTypes: productTypes?.join(","));
      setState(() {
        products = dataResponse;
        if (products != null) {
          colorList = getSelectableColorList(dataResponse, null) ?? [];
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

  List<String> type1List = ['Matte', 'Shimmer', 'Metallic'];

  List<String> typeComboList = [
    'One',
    'Dual',
    'Tri',
    'Quadra',
    'Penta',
  ];

  List<Widget> typeEyeShadow = [
    Image.asset(Assets.imagesImgEyeshadow),
    Image.asset(Assets.imagesImgEyeshadow),
    Image.asset(Assets.imagesImgEyeshadow),
    Image.asset(Assets.imagesImgEyeshadow),
  ];

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  Widget colorChip() {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
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
                colorSelected.clear();
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
                        if (colorSelected.length >= maxColorSelected) {
                          colorSelected.removeAt(0);
                        }

                        colorSelected.add(index);
                      });
                      fetchData();
                      tryOn();
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 1, vertical: 1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color:
                                colorSelected.indexWhere((e) => e == index) >= 0
                                    ? Colors.white
                                    : Colors.transparent,
                          ),
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

  Widget typeChip() {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 30,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: type1List.length,
          separatorBuilder: (_, __) => Constant.xSizedBox8,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () async {
                setState(() {
                  typeSelected = index;
                });
                fetchData();
                tryOn();
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
                    type1List[index],
                    textAlign: TextAlign.center,
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

  Widget typeComboChip() {
    return SizedBox(
      height: 20,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: typeComboList.length,
        separatorBuilder: (_, __) => Constant.xSizedBox8,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                typeComboSelected = index;
              });
              fetchData();
              tryOn();
            },
            child: Center(
              child: Text(
                typeComboList[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    shadows: index == typeComboSelected
                        ? [
                            const BoxShadow(
                              offset: Offset(0, 0),
                              color: Colors.white,
                              spreadRadius: 0,
                              blurRadius: 10,
                            ),
                          ]
                        : null),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget typeEyeShadowChip() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: typeEyeShadow.length,
        separatorBuilder: (_, __) => Constant.xSizedBox8,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                eyebrowSelected = index;
              });
              fetchData();
              tryOn();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color: index == eyebrowSelected
                        ? Colors.white
                        : Colors.transparent),
              ),
              child: typeEyeShadow[index],
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          colorChoice(),
          Constant.xSizedBox8,
          separator(),
          Constant.xSizedBox4,
          typeChip(),
          Constant.xSizedBox4,
          separator(),
          Constant.xSizedBox4,
          typeComboChip(),
          Constant.xSizedBox4,
          separator(),
          Constant.xSizedBox4,
          typeEyeShadowChip(),
          separator(),
          Constant.xSizedBox4,
          lipstickChoice(),
        ],
      ),
    );
  }

  void tryOn() {
    var colors = <Color>[];
    Color color = colorMainList[colorTextSelected ?? 0];

    if (colorSelected.length > maxColorSelected) {
      var tempColor = <int>[];
      for (var i = 0; i < maxColorSelected; i++) {
        tempColor.add(colorSelected[i]);
      }
      colorSelected = tempColor;
      setState(() {});
    }

    var json = jsonEncode({
      "showEyeShadow": true,
      "eyeShadowColor": colors.map((e) => toWebHex(color)).toList(),
      "eyeshadowMode ": typeComboList[typeComboSelected ?? 0],
      "eyeshadowPattern": eyebrowSelected,
      "eyeshadowMaterial": type1List[typeSelected ?? 0],
    });
    String source = 'window.postMessage(JSON.stringify($json),"*");';
    log(source, name: 'postMessage');
    widget.webViewController?.evaluateJavascript(
      source: source,
    );
  }

  void _voiceCommand(String text) {
    text = text.toLowerCase();

    // Metcallic, Shimmer, Matte
    int typeSelectedIndex =
        type1List.indexWhere((e) => text.contains(e.toLowerCase()));
    if (typeSelectedIndex >= 0) {
      typeSelected = typeSelectedIndex;

      setState(() {});

      fetchData();
      tryOn();

      log("typeSelected : $typeSelected", name: 'voice command proccess');

      return;
    }

    //   One, Dual, more
    int typeComboIndex =
        typeComboList.indexWhere((e) => text.contains(e.toLowerCase()));
    if (typeComboIndex >= 0) {
      typeComboSelected = typeComboIndex;

      setState(() {});

      fetchData();
      tryOn();

      log("typeSelected : $typeSelected", name: 'voice command proccess');

      return;
    }
  }
}
