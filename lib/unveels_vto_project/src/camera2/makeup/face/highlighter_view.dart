import 'dart:async';

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

class HighlighterView extends StatefulWidget {
  final InAppWebViewController? webViewController;
  const HighlighterView({super.key, this.webViewController});

  @override
  State<HighlighterView> createState() => _HighlighterViewState();
}

class _HighlighterViewState extends State<HighlighterView> {
  bool makeupOrAccessories = false;
  bool onOffVisibel = false;
  int? skinSelected;
  int? colorSelected;
  int? typeSelected;

  final Dio dio = Dio();
  List<ProductData>? products;
  bool _isLoading = false;
  final ProductRepository productRepository = ProductRepository();

  Future<void> fetchData() async {
    tryOn();
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
          getProductTypesByLabels("face_makeup_product_type", ["Highlighters"]);
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
    print("TRYING TO TRY ON");
    final show = skinSelected != null;

    String? color = colorSelected != null
        ? toWebHex(colorChoiceList[colorSelected!])
        : null;

    widget.webViewController?.evaluateJavascript(
      source: """
    window.postMessage(JSON.stringify({
      "showHighlighter": $show,
      ${show ? '"highlighterColor": "$color", "highlighterPattern": $skinSelected,' : ''}
    }), "*");
    """,
    );
  }

  List<String> typeList = [
    "Matte",
    "Shimmer",
    "Metallic",
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
  List<String> blusherList = [
    Assets.imagesImgBlusher1,
    Assets.imagesImgBlusher2,
    Assets.imagesImgBlusher3,
    Assets.imagesImgBlusher4,
    Assets.imagesImgBlusher5,
  ];

  Widget typeChip() {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 20,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: typeList.length,
          separatorBuilder: (_, __) => Constant.xSizedBox8,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  typeSelected = index;
                });
                fetchData();
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
                    typeList[index],
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

  Widget colorChoice() {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 30,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: colorChoiceList.length,
          separatorBuilder: (_, __) => Constant.xSizedBox12,
          itemBuilder: (context, index) {
            if (index == 0) {
              return InkWell(
                onTap: () async {
                  setState(() {
                    colorSelected = 0;
                    onOffVisibel = true;
                  });
                  fetchData();
                },
                child: const Icon(Icons.do_not_disturb_alt_sharp,
                    color: Colors.white, size: 25),
              );
            }
            return InkWell(
                onTap: () async {
                  setState(() {
                    colorSelected = index;
                    onOffVisibel = false;
                  });
                  fetchData();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: index == colorSelected && onOffVisibel == false
                            ? Colors.white
                            : Colors.transparent),
                  ),
                  child: CircleAvatar(
                      radius: 12, backgroundColor: colorChoiceList[index]),
                ));
          },
        ),
      ),
    );
  }

  Widget highlighterChoice() {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 55,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: blusherList.length,
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
                    color: index == skinSelected
                        ? Colors.white
                        : Colors.transparent),
              ),
              child: InkWell(
                  onTap: () async {
                    setState(() {
                      skinSelected = index;
                    });
                    fetchData();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset(blusherList[index]),
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Constant.xSizedBox8,
          // colorChip(),
          colorChoice(),
          Constant.xSizedBox8,
          separator(),
          typeChip(),
          separator(),
          highlighterChoice(),
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
