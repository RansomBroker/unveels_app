import 'dart:async';

import 'package:dio/dio.dart';
import 'package:test_new/unveels_vto_project/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:test_new/logic/get_product_utils/get_product_types.dart';
import 'package:test_new/logic/get_product_utils/get_shape.dart';
import 'package:test_new/logic/get_product_utils/repository/product_repository.dart';
import 'package:test_new/unveels_vto_project//common/helper/constant.dart';
import 'package:test_new/unveels_vto_project//generated/assets.dart';
import 'package:test_new/unveels_vto_project/common/component/vto_product_item.dart';

const xHEdgeInsets12 = EdgeInsets.symmetric(horizontal: 12);

class HeadEarringsView extends StatefulWidget {
  final InAppWebViewController? webViewController;
  const HeadEarringsView({super.key, this.webViewController});

  @override
  State<HeadEarringsView> createState() => _HeadEarringsViewState();
}

class _HeadEarringsViewState extends State<HeadEarringsView> {
  bool onOffVisibel = false;
  int? mainColorSelected;
  int? colorSelected;
  int? shapesSelected;
  int? materialSelected;

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
      List<String>? productTypes = getProductTypesByLabels(
          "head_accessories_product_type", ["Earrings"]);
      print(productTypes);

      var dataResponse = await productRepository.fetchProducts(
          // texture: textures!.isEmpty ? null : textures.join(","),
          shape: shapesSelected == null
              ? null
              : getShapeByLabel(earringsList[shapesSelected!]),
          productType: "head_accessories_product_type",
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

  List<String> lipList = [
    "Yellow",
    "Black",
    "Silver",
    "Gold",
    "Rose Gold",
  ];
  List<Color> lipColorList = [
    const Color(0xFFFFFF00),
    Colors.black,
    const Color(0xffC0C0C0),
    const Color(0xffCA9C43),
    const Color(0xffB76E79),
  ];
  List<Color> colorChoiceList = [];
  List<String> earringsList = ['Studs', 'Cuffs', 'Hoops', 'Dangling'];

  List<String> earringsAssetsList = [
    Assets.iconsIcStuds,
    Assets.iconsIcCuffs,
    Assets.iconsIcHoops,
    Assets.iconsIcDanglings,
  ];

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
    return SizedBox(
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
              padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: index == colorSelected && onOffVisibel == false
                        ? Colors.white
                        : Colors.transparent),
              ),
              child: CircleAvatar(
                  radius: 12, backgroundColor: colorChoiceList[index]),
            ),
          );
        },
      ),
    );
  }

  Widget shapesChoice() {
    return SizedBox(
      height: 18,
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemCount: earringsList.length,
        separatorBuilder: (_, __) => Constant.xSizedBox12,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                shapesSelected = index;
              });
              fetchData();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: shapesSelected == index ? const Color(0xffCA9C43) : null,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: shapesSelected == index
                        ? Colors.white
                        : Colors.transparent),
              ),
              child: Row(
                children: [
                  Image.asset(earringsAssetsList[index]),
                  Constant.xSizedBox4,
                  Text(
                    earringsList[index],
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
          shapesChoice(),
          Constant.xSizedBox4,
          separator(),
          lipstickChoice()
        ],
      ),
    );
  }
}
