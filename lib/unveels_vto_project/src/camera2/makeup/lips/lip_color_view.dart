import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:test_new/logic/get_product_utils/get_product_types.dart';
import 'package:test_new/logic/get_product_utils/get_textures.dart';
import 'package:test_new/logic/get_product_utils/repository/product_repository.dart';
import 'package:test_new/unveels_vto_project//common/helper/constant.dart';
import 'package:test_new/unveels_vto_project/common/component/vto_color_category_chooser.dart';
import 'package:test_new/unveels_vto_project/common/component/vto_product_item.dart';
import 'package:test_new/unveels_vto_project/utils/color_utils.dart';

class LipColorView extends StatefulWidget {
  final InAppWebViewController? webViewController;
  const LipColorView({super.key, this.webViewController});

  @override
  State<LipColorView> createState() => _LipColorViewState();
}

class _LipColorViewState extends State<LipColorView> {
  int? selectedProductIndex;
  int? mainColorSelected;
  int? colorSelected;
  int? textureSelected;
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
      if (textureSelected != null) {
        textures = getTextureByLabel([chipList[textureSelected!]]);
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

    widget.webViewController?.evaluateJavascript(
      source: """
    window.postMessage(JSON.stringify({
      "showLipColor": $showLipColor,
      ${showLipColor ? '"lipColor": ${jsonEncode(lipColors)}, "lipColorMode": "$lipColorMode",' : ''}
    }), "*");
    """,
    );
  }

  List<Color> colorChoiceList = [];
  List<String> chipList = texturesLabel;
  List<String> chip2List = [
    'One',
    'Dual',
    'Ombre',
  ];

  Widget colorChip() {
    return VtoColorCategoryChooser(
      onColorSelected: (index, l, v) {
        setState(() {
          mainColorSelected = index;
          fetchData();
        });
      },
      selectedColor: mainColorSelected,
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
                                  ? index == colorSelected
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

  Widget textureChoice() {
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
                textureSelected = index;
                fetchData();
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              decoration: BoxDecoration(
                color:
                    textureSelected == index ? const Color(0xffCA9C43) : null,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: textureSelected == index
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

  void selectProduct(int index) {
    var product = products?[index];
    if (product != null) {
      setState(() {
        selectedProductIndex = index;

        mainColorSelected =
            vtoColors.indexWhere((p) => p.value == product.color);
        colorSelected = colorChoiceList.indexWhere(
            (p) => product.hexacode?.split(",").contains(p.toWebHex()) == true);
        if (product.textureId != null) {
          textureSelected = getTextureIndexByValue(product.textureId!);
        }
      });
      tryOn();
    }
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
              return GestureDetector(
                onTap: () {
                  selectProduct(index);
                },
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: selectedProductIndex == index
                              ? const Color(0xFFFFD700)
                              : Colors.transparent),
                    ),
                    child: VtoProductItem(product: product)),
              );
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
          Constant.xSizedBox8,
          colorChip(),
          Constant.xSizedBox8,
          colorChoice(),
          Constant.xSizedBox8,
          separator(),
          Constant.xSizedBox4,
          textureChoice(),
          Constant.xSizedBox4,
          separator(),
          chip2Choice(),
          separator(),
          lipstickChoice()
        ],
      ),
    );
  }
}
