import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:test_new/logic/get_product_utils/repository/product_repository.dart';
import 'package:test_new/unveels_vto_project//common/helper/constant.dart';
import 'package:test_new/unveels_vto_project//generated/assets.dart';
import 'package:test_new/unveels_vto_project/common/component/vto_color_chooser.dart';
import 'package:test_new/unveels_vto_project/common/component/vto_poroduct_list_view.dart';

import '../../../../utils/color_utils.dart';

class EyebrowsView extends StatefulWidget {
  final InAppWebViewController? webViewController;
  const EyebrowsView({super.key, this.webViewController});

  @override
  State<EyebrowsView> createState() => _EyebrowsViewState();
}

class _EyebrowsViewState extends State<EyebrowsView> {
  double sliderValue = 3;
  bool onOffVisibel = false;
  int? eyebrowSelected;
  List<Color> selectedColors = [];
  int? typeSelected;

  int? _selectedProductId;

  final Dio dio = Dio();
  List<ProductData>? _products;
  bool _isLoading = false;
  final ProductRepository productRepository = ProductRepository();

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
    });
    print("Fetching data");
    try {
      var dataResponse = await productRepository.fetchProducts(browMakeup: '');
      setState(() {
        _products = dataResponse;
        if (_products != null) {
          if (typeSelected == null) {
            colorChoiceList = getSelectableColorList(dataResponse, null) ?? [];
          } else {
            colorChoiceList = getSelectableColorList(
                    _products!,
                    vtoColors
                        .where((e) =>
                            e.label == colorMainListString[typeSelected!])
                        .first
                        .value) ??
                [];
            _products = dataResponse
                .where((e) =>
                    e.color ==
                    vtoColors
                        .where((e) =>
                            e.label == colorMainListString[typeSelected!])
                        .first
                        .value)
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

  List<Color> colorMainList = [
    const Color(0xff3D2B1F),
    Colors.black,
  ];

  List<String> colorMainListString = [
    'Brown',
    'Black',
  ];
  List<Color> colorChoiceList = [
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

  List<Widget> typeEyeBrows = [
    Image.asset(Assets.imagesImgEyebrow1),
    Image.asset(Assets.imagesImgEyebrow2),
    Image.asset(Assets.imagesImgEyebrow3),
    Image.asset(Assets.imagesImgEyebrow4),
    Image.asset(Assets.imagesImgEyebrow5),
    Image.asset(Assets.imagesImgEyebrow6),
  ];

  @override
  void initState() {
    super.initState();

    fetchData();
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

  Widget separator() {
    return const Divider(thickness: 1, color: Colors.white);
  }

  Widget typeEyeBrowsChip() {
    return Container(
      height: 30,
      padding: const EdgeInsets.all(1),
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: typeEyeBrows.length,
        separatorBuilder: (_, __) => const SizedBox(),
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
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color: index == eyebrowSelected
                        ? Colors.white
                        : Colors.transparent),
              ),
              child: SizedBox(height: 29, child: typeEyeBrows[index]),
            ),
          );
        },
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

  void _selectProduct(ProductData product) {
    setState(() {
      _selectedProductId = product.id;
      List<Color>? productColors = colorChoiceList
          .where((p) =>
              product.hexacode?.split(",").contains(p.toWebHex()) == true)
          .toList();
      if (productColors.isNotEmpty) {
        selectedColors = [productColors.first];
      }
      eyebrowSelected ??= 0;
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
          colorChip(),
          Constant.xSizedBox8,
          colorChoice(),
          Constant.xSizedBox8,
          separator(),
          Constant.xSizedBox4,
          typeEyeBrowsChip(),
          Constant.xSizedBox4,
          separator(),
          slider(),
          Constant.xSizedBox4,
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

  void tryOn() {
    bool show = eyebrowSelected != null;
    Color color = colorMainList[typeSelected ?? 0];
    if (onOffVisibel == true && selectedColors.isNotEmpty) {
      color = selectedColors.first;
    }

    var json = jsonEncode({
      "showEyebrows": show,
      "eyebrowsColor": [toWebHex(color)],
      "eyebrowsPattern": eyebrowSelected,
      "eyebrowsVisibility": sliderValue / 10,
    });
    String source = 'window.postMessage(JSON.stringify($json),"*");';
    log(source, name: 'postMessage');
    widget.webViewController?.evaluateJavascript(
      source: source,
    );
  }
}
