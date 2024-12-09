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

const xHEdgeInsets12 = EdgeInsets.symmetric(horizontal: 12);

class EyelinerView extends StatefulWidget {
  final InAppWebViewController? webViewController;
  const EyelinerView({super.key, this.webViewController});

  @override
  State<EyelinerView> createState() => _EyelinerViewState();
}

class _EyelinerViewState extends State<EyelinerView> {
  double sliderValue = 0;
  bool onOffVisible = false;
  int? eyebrowSelected;
  int? colorSelected;
  int? colorTextSelected;

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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 1, vertical: 1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color:
                                  index == colorSelected && onOffVisible == true
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
          typeEyeLinerChip(),
          Constant.xSizedBox8,
          separator(),
          Constant.xSizedBox4,
          lipstickChoice(),
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
    widget.webViewController?.evaluateJavascript(
      source: source,
    );
  }
}
