import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:test_new/unveels_vto_project/common/component/vto_product_item.dart';
import 'package:test_new/unveels_vto_project/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:test_new/logic/get_product_utils/get_product_types.dart';
import 'package:test_new/logic/get_product_utils/repository/product_repository.dart';
import 'package:test_new/unveels_vto_project//common/helper/constant.dart';
import 'package:test_new/unveels_vto_project//generated/assets.dart';

const xHEdgeInsets12 = EdgeInsets.symmetric(horizontal: 12);

class LashesMascaraView extends StatefulWidget {
  final InAppWebViewController? webViewController;
  const LashesMascaraView(
      {super.key, this.lashes = true, this.webViewController});

  final bool lashes;

  @override
  State<LashesMascaraView> createState() => _LashesMascaraViewState();
}

class _LashesMascaraViewState extends State<LashesMascaraView> {
  bool lashes = true;
  bool onOffVisible = false;
  int? colorSelected;
  int? colorTextSelected;
  int? eyelashSelected;

  final Dio dio = Dio();
  List<ProductData>? products;
  bool _isLoading = false;
  final ProductRepository productRepository = ProductRepository();

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
    });
    print("Fetching data");
    List<String>? productTypes = getProductTypesByLabels(
        "lash_makeup_product_type",
        lashes
            ? [
                "Lash Curlers",
                "Individual False Lashes",
                "Full Line Lashes",
              ]
            : ["Mascaras"]);
    try {
      var dataResponse = await productRepository.fetchProducts(
        productType: "lash_makeup_product_type",
        productTypes: productTypes?.join(","),
      );
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

  List<Widget> typeLashes = [
    Image.asset(Assets.imagesImgEyelashes1),
    Image.asset(Assets.imagesImgEyelashes2),
    Image.asset(Assets.imagesImgEyelashes3),
    Image.asset(Assets.imagesImgEyelashes4),
    Image.asset(Assets.imagesImgEyelashes5),
    Image.asset(Assets.imagesImgEyelashes6),
    Image.asset(Assets.imagesImgEyelashes7),
  ];

  @override
  void initState() {
    super.initState();
    lashes = widget.lashes;

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
                colorTextSelected = index;
              });
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
    );
  }

  Widget separator() {
    return const Divider(thickness: 1, color: Colors.white);
  }

  Widget typeLashesChip() {
    return SizedBox(
      height: 30,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: typeLashes.length,
        separatorBuilder: (_, __) => Constant.xSizedBox8,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () async {
              setState(() {
                eyelashSelected = index;
                onOffVisible = true;
              });
              fetchData();
              tryOn();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                    color: index == eyelashSelected
                        ? Colors.white
                        : Colors.transparent),
              ),
              child: typeLashes[index],
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Constant.xSizedBox8,
          colorChip(),
          Constant.xSizedBox8,
          separator(),
          Constant.xSizedBox4,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      lashes = true;
                    });
                    fetchData();
                    tryOn();
                  },
                  child: Text(
                    'Lashes',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      shadows: !lashes
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
                ),
              ),
              Container(
                width: 1,
                height: 18,
                color: Colors.white,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      lashes = false;
                    });
                    fetchData();
                    tryOn();
                  },
                  child: Text(
                    'Mascara',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      shadows: lashes
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
                ),
              ),
            ],
          ),
          Constant.xSizedBox16,
          typeLashesChip(),
          Constant.xSizedBox32,
          lipstickChoice(),
        ],
      ),
    );
  }

  void tryOn() {
    Color color = colorMainList[colorSelected ?? 0];
    if (onOffVisible == true && colorSelected != null) {
      color = colorList[colorSelected ?? 0];
    }

    var json = jsonEncode({
      "showMascara": lashes == false,
      "mascaraColor": toWebHex(color),
    });
    String source = 'window.postMessage(JSON.stringify($json),"*");';
    log(source, name: 'postMessage');
    widget.webViewController?.evaluateJavascript(
      source: source,
    );

    var jsonMascara = jsonEncode({
      "showLashes": lashes,
      "lashesColor": toWebHex(color),
      "lashesPattern": eyelashSelected,
    });
    String sourceMascara =
        'window.postMessage(JSON.stringify($jsonMascara),"*");';
    log(source, name: 'postMessage');
    widget.webViewController?.evaluateJavascript(
      source: sourceMascara,
    );
  }
}
