import 'dart:async';

import 'package:dio/dio.dart';
import 'package:test_new/unveels_vto_project/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:test_new/logic/get_product_utils/get_product_types.dart';
import 'package:test_new/logic/get_product_utils/get_skin_tone.dart';
import 'package:test_new/logic/get_product_utils/repository/product_repository.dart';
import 'package:test_new/unveels_vto_project//common/helper/constant.dart';
import 'package:test_new/unveels_vto_project/common/component/vto_product_item.dart';


class FoundationView extends StatefulWidget {
  final InAppWebViewController? webViewController;
  const FoundationView({super.key, this.webViewController});

  @override
  State<FoundationView> createState() => _FoundationViewState();
}

class _FoundationViewState extends State<FoundationView> {
  bool makeupOrAccessories = false;
  bool onOffVisibel = false;
  int? skinSelected;
  int? colorSelected;

  final Dio dio = Dio();
  List<ProductData>? products;
  bool _isLoading = false;
  final ProductRepository productRepository = ProductRepository();

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // print("Trying to fetch");
      // List<String>? textures =
      //     getTextureByLabel([chipList[typeColorSelected!]]);
      // print(textures);
      List<String>? productTypes =
          getProductTypesByLabels("face_makeup_product_type", ["Foundations"]);

      var dataResponse = await productRepository.fetchProducts(
          // texture: textures!.isEmpty ? null : textures.join(","),
          skinTone: skinSelected == null ? null : skinTones[skinSelected!].id,
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
    final show = colorSelected != 0;

    widget.webViewController?.evaluateJavascript(source: """
    window.postMessage(JSON.stringify({
      "showFoundation": $show,
      ${show ? '"foundationColor": "${toWebHex(colorChoiceList[colorSelected!])}",' : ''}
    }), "*");
    """);
  }

  List<String> skinList = skinTones.map((e) => e.name).toList();
  List<Color> skinColorList = skinTones.map((e) => e.color).toList();

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

  Widget colorChip() {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 30,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: skinList.length,
          separatorBuilder: (_, __) => Constant.xSizedBox8,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  skinSelected = index;
                });
                fetchData();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: index == skinSelected
                          ? Colors.white
                          : Colors.transparent),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                        radius: 8, backgroundColor: skinColorList[index]),
                    Constant.xSizedBox4,
                    Text(
                      skinList[index],
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
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 30,
        child: Row(
          children: [
            InkWell(
              onTap: () async {
                setState(() {
                  colorSelected = null; // Set value menjadi null
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
                        colorSelected =
                            index; // Pilih indeks dari colorChoiceList
                        onOffVisibel = false;
                      });
                      tryOn();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 1, vertical: 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: index == colorSelected && !onOffVisibel
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
          Constant.xSizedBox8,
          colorChip(),
          Constant.xSizedBox8,
          colorChoice(),
          Constant.xSizedBox8,
          separator(),
          Constant.xSizedBox4,
          lipstickChoice()
        ],
      ),
    );
  }
}
