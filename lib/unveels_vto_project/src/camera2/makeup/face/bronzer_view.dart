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

class BronzerView extends StatefulWidget {
  final InAppWebViewController? webViewController;
  const BronzerView({super.key, this.webViewController});

  @override
  State<BronzerView> createState() => _BronzerViewState();
}

class _BronzerViewState extends State<BronzerView> {
  bool makeupOrAccessories = false;
  int? skinSelected;
  int? colorSelected;
  bool onOffVisibel = false;

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
          getProductTypesByLabels("face_makeup_product_type", ["Bronzers"]);
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
    final show = colorSelected != null;

    widget.webViewController?.evaluateJavascript(source: """
    window.postMessage(JSON.stringify({
      "showBronzer": $show,
      ${show ? '"bronzerColor": "${toWebHex(colorChoiceList[colorSelected!])}",' : ''}
    }), "*");
    """);
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
  List<Color> colorChoiceList = [];
  List<String> bronzerList = [
    Assets.imagesImgBronzer,
    Assets.imagesImgBronzer1,
    Assets.imagesImgBronzer2,
    Assets.imagesImgBronzer3,
    Assets.imagesImgBronzer4,
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
                        colorSelected = index;
                        onOffVisibel = false;
                      });
                      tryOn();
                      fetchData();
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

  Widget bronzerChoice() {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 55,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: bronzerList.length,
          separatorBuilder: (_, __) => Constant.xSizedBox12,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              decoration: BoxDecoration(
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
                        child: Image.asset(bronzerList[index]),
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
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Constant.xSizedBox8,
          colorChoice(),
          Constant.xSizedBox8,
          separator(),
          Constant.xSizedBox4,
          bronzerChoice(),
          Constant.xSizedBox4,
          separator(),
          Constant.xSizedBox4,

          lipstickChoice(),
          // Constant.xSizedBox8,
        ],
      ),
    );
  }
}
