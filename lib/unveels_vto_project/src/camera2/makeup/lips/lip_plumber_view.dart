import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:test_new/logic/get_product_utils/get_product_types.dart';
import 'package:test_new/logic/get_product_utils/repository/product_repository.dart';
import 'package:test_new/unveels_vto_project//common/helper/constant.dart';
import 'package:test_new/unveels_vto_project/common/component/vto_poroduct_list_view.dart';
import 'package:test_new/unveels_vto_project/utils/color_utils.dart';

const xHEdgeInsets12 = EdgeInsets.symmetric(horizontal: 12);

class LipPlumberView extends StatefulWidget {
  final InAppWebViewController? webViewController;
  const LipPlumberView({super.key, this.webViewController});

  @override
  State<LipPlumberView> createState() => _LipPlumberViewState();
}

class _LipPlumberViewState extends State<LipPlumberView> {
  int? colorSelected;

  int? _selectedProductId;
  final Dio dio = Dio();
  List<ProductData>? _products;
  bool _isLoading = false;
  final ProductRepository productRepository = ProductRepository();

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
    });
    log("Fetching data");
    try {
      // print("Trying to fetch");
      // List<String>? textures =
      //     getTextureByLabel([chipList[typeColorSelected!]]);
      // print(textures);
      List<String>? productTypes = getProductTypesByLabels(
          "lips_makeup_product_type", ["Lip Plumpers", "Lip Glosses"]);
      log(productTypes.toString());

      var dataResponse = await productRepository.fetchProducts(
          // texture: textures!.isEmpty ? null : textures.join(","),
          productType: "lips_makeup_product_type",
          productTypes: productTypes?.join(","));
      setState(() {
        _products = dataResponse;
        if (_products != null) {
          colorChoiceList = getSelectableColorList(dataResponse, null) ?? [];
        }
      });
    } catch (e) {
      log("err");
      log(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void tryOn() {
    final showLipplumper = colorSelected != null;

    final lipColors = [toWebHex(colorChoiceList[colorSelected!])];

    widget.webViewController?.evaluateJavascript(
      source: """
    window.postMessage(JSON.stringify({
      "showLipplumper": $showLipplumper,
      ${showLipplumper ? '"lipplumperColor": ${jsonEncode(lipColors)},' : ''}
    }), "*");
    """,
    );
  }

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  List<String> lipPlumberList = [
    "Yellow",
    "Black",
    "Silver",
    "Gold",
    "Rose Gold",
  ];
  List<Color> lipPlumberColorList = [
    const Color(0xFFFFFF00),
    Colors.black,
    const Color(0xFFC0C0C0),
    const Color(0xFFCA9C43),
    const Color(0xFFB76E79),
  ];
  List<Color> colorChoiceList = [
    const Color(0xFF740039),
    const Color(0xFF8D0046),
    const Color(0xFFB20058),
    const Color(0xFFB51F69),
    const Color(0xFFDF1050),
    const Color(0xFFE31B7B),
    const Color(0xFFFE3699),
    const Color(0xFFE861A4),
    const Color(0xFFE0467C),
  ];

  List<String> chipList = ['Gloss', 'Matt', 'Shimmer'];

  Widget colorChip() {
    return SizedBox(
      height: 30,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: lipPlumberList.length,
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
                CircleAvatar(
                    radius: 8, backgroundColor: lipPlumberColorList[index]),
                Constant.xSizedBox4,
                Text(
                  lipPlumberList[index],
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
                      });
                      tryOn();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 1, vertical: 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: index == colorSelected
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


  Widget chipChoice() {
    return SizedBox(
      height: 18,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: chipList.length,
        separatorBuilder: (_, __) => Constant.xSizedBox12,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: index == 0 ? Colors.white : Colors.transparent),
            ),
            child: Text(
              lipPlumberList[index],
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
          );
        },
      ),
    );
  }

  Widget item(String path, GestureTapCallback? onTap) {
    return InkWell(onTap: onTap, child: Image.asset(path));
  }

  Widget separator() {
    return const Divider(thickness: 1, color: Colors.white);
  }

  void _selectProduct(ProductData product) {
    setState(() {
      _selectedProductId = product.id;
      colorSelected = colorChoiceList.indexWhere(
          (p) => product.hexacode?.split(",").contains(p.toWebHex()) == true);
      // if (product.textureId != null) {
      //   textureSelected = getTextureIndexByValue(product.textureId!);
      // }
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
          colorChoice(),
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
