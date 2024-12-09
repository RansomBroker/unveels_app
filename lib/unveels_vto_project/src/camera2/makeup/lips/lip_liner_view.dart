import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:test_new/logic/get_product_utils/get_product_types.dart';
import 'package:test_new/logic/get_product_utils/repository/product_repository.dart';
import 'package:test_new/unveels_vto_project//common/helper/constant.dart';
import 'package:test_new/unveels_vto_project//generated/assets.dart';
import 'package:test_new/unveels_vto_project/common/component/vto_color_chooser.dart';
import 'package:test_new/unveels_vto_project/common/component/vto_poroduct_list_view.dart';
import 'package:test_new/unveels_vto_project/utils/color_utils.dart';

const xHEdgeInsets12 = EdgeInsets.symmetric(horizontal: 12);

class LipLinerView extends StatefulWidget {
  final InAppWebViewController? webViewController;
  const LipLinerView({super.key, this.webViewController});

  @override
  State<LipLinerView> createState() => _LipLinerViewState();
}

class _LipLinerViewState extends State<LipLinerView> {
  int? mainColorSelected;
  int? typeColorSelected;
  int? patternSelected;
  List<Color> selectedColors = [];

  int? _selectedProductId;
  final Dio dio = Dio();
  List<ProductData>? _products;
  bool _isLoading = false;
  final ProductRepository productRepository = ProductRepository();

  Future<void> fetchData() async {
    tryOn();

    setState(() {
      _isLoading = true;
    });
    try {
      List<String>? productTypes =
          getProductTypesByLabels("lips_makeup_product_type", ["Lip Liners"]);

      var dataResponse = await productRepository.fetchProducts(
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

  List<Color> colorChoiceList = [];

  List<String> lipLinerPath = [
    Assets.imagesImgLipliner,
    Assets.imagesImgLipliner2,
    Assets.imagesImgLipliner3,
    Assets.imagesImgLipliner4,
    Assets.imagesImgLipliner5,
    Assets.imagesImgLipliner5,
    Assets.imagesImgLipliner4,
    Assets.imagesImgLipliner3,
    Assets.imagesImgLipliner2,
  ];

  List<String> chipList = ['Gloss', 'Matte', 'Shimmer'];

  void tryOn() {
    final show = patternSelected != null;

    final color =
        selectedColors.isNotEmpty ? toWebHex(selectedColors.first) : null;

    widget.webViewController?.evaluateJavascript(
      source: """
    window.postMessage(JSON.stringify({
      "showLipliner": $show,
      ${show ? '"liplinerColor": "$color", "liplinerPattern": $patternSelected,' : ''}
    }), "*");
    """,
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
    return VtoColorChooser(
      colorChoiceList: colorChoiceList,
      selectedColors: selectedColors,
      onColorSelected: (color) {
        setState(() {
          selectedColors = [color];
        });
        fetchData();
      },
      onClear: () {
        setState(() {
          selectedColors.clear();
        });
        fetchData();
      },
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
              });
              fetchData();
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

  Widget item(int index) {
    return InkWell(
      onTap: () {
        setState(() {
          if (patternSelected == index) {
            patternSelected = null;
          } else {
            patternSelected = index;
          }
        });
        fetchData();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: patternSelected == index ? Colors.white : Colors.transparent,
          ),
        ),
        child: Image.asset(lipLinerPath[index]),
      ),
    );
  }

  Widget itemChoice() {
    return SizedBox(
      height: 60,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: lipLinerPath.length,
        separatorBuilder: (_, __) => Constant.xSizedBox12,
        itemBuilder: (context, index) {
          return item(index);
        },
      ),
    );
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
    });
    tryOn();
  }

  Widget separator() {
    return const Divider(thickness: 1, color: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Constant.xSizedBox8,
        colorChip(),
        Constant.xSizedBox8,
        colorChoice(),
        Constant.xSizedBox8,
        separator(),
        itemChoice(),
        Constant.xSizedBox8,
        separator(),
        VtoProductListView(
          products: _products,
          selectedProductId: _selectedProductId,
          onSelectedProduct: _selectProduct,
          isLoading: _isLoading,
        )
      ]),
    );
  }
}
