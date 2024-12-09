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
import 'package:test_new/unveels_vto_project/common/component/vto_color_chooser.dart';
import 'package:test_new/unveels_vto_project/common/component/vto_poroduct_list_view.dart';
import 'package:test_new/unveels_vto_project/utils/color_utils.dart';

class LipColorView extends StatefulWidget {
  final InAppWebViewController? webViewController;
  const LipColorView({super.key, this.webViewController});

  @override
  State<LipColorView> createState() => _LipColorViewState();
}

class _LipColorViewState extends State<LipColorView> {
  int? mainColorSelected;
  int? textureSelected;
  int? typeColor2Selected = 0;
  List<Color>? selectedColors;

  int? _selectedProductId;

  final Dio dio = Dio();
  List<ProductData>? _products;
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
        _products = dataResponse;
        if (_products != null) {
          if (mainColorSelected == null) {
            colorChoiceList = getSelectableColorList(dataResponse, null) ?? [];
          } else {
            colorChoiceList = getSelectableColorList(
                    _products!, vtoColors[mainColorSelected!].value) ??
                [];
            _products = dataResponse
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
    final showLipColor = selectedColors != null && selectedColors!.isNotEmpty;

    final lipColors = selectedColors!.map((color) => toWebHex(color)).toList();

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
    return VtoColorChooser(
      selectedColors: selectedColors,
      colorChoiceList: colorChoiceList,
      onColorSelected: (color) {
        setState(() {
          if (typeColor2Selected == 0) {
            selectedColors = [color];
          } else {
            if (selectedColors == null) {
              selectedColors = [color];
            } else {
              if (selectedColors!.contains(color)) {
                selectedColors!.remove(color);
              } else {
                if (selectedColors!.length < 2) {
                  selectedColors!.add(color);
                } else {
                  selectedColors![1] = color;
                }
              }
            }
          }
          fetchData();
        });
        tryOn();
      },
      onClear: () {
        setState(() {
          selectedColors?.clear();
        });
        tryOn();
      },
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

  Widget separator() {
    return const Divider(thickness: 1, color: Colors.white);
  }

  void _selectProduct(ProductData product) {
    setState(() {
      _selectedProductId = product.id;
      mainColorSelected = vtoColors.indexWhere((p) => p.value == product.color);
      List<Color>? productColors = colorChoiceList
          .where((p) =>
              product.hexacode?.split(",").contains(p.toWebHex()) == true)
          .toList();
      if (productColors.isNotEmpty) {
        selectedColors = [productColors.first];
      }
      if (product.textureId != null) {
        textureSelected = getTextureIndexByValue(product.textureId!);
      }
    });
    tryOn();
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
          VtoProductListView(
            products: _products,
            selectedProductId: _selectedProductId,
            onSelectedProduct: _selectProduct,
            isLoading: _isLoading,
          )
        ],
      ),
    );
  }
}
