import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:test_new/logic/get_product_utils/repository/product_repository.dart';
import 'package:test_new/unveels_vto_project//common/helper/constant.dart';
import 'package:test_new/unveels_vto_project//generated/assets.dart';
import 'package:test_new/unveels_vto_project/common/component/vto_color_category_chooser.dart';
import 'package:test_new/unveels_vto_project/common/component/vto_poroduct_list_view.dart';
import 'package:test_new/unveels_vto_project/utils/color_utils.dart';

class HairView extends StatefulWidget {
  final InAppWebViewController? webViewController;
  const HairView({super.key, this.webViewController});

  @override
  State<HairView> createState() => _HairViewState();
}

class _HairViewState extends State<HairView> {
  bool makeupOrAccessories = false;
  int? mainColorSelected;
  int? hairSelected;

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
      var dataResponse = await productRepository.fetchProducts(
          hairProductType: "hair_color_product_type");

      setState(() {
        _products = dataResponse;
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

  List<String> hairList = [
    Assets.imagesImgHair1,
    Assets.imagesImgHair2,
    Assets.imagesImgHair3,
    Assets.imagesImgHair4,
    Assets.imagesImgHair5,
    Assets.imagesImgHair6,
    Assets.imagesImgHair7,
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

  Widget hairChoice() {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 55,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: hairList.length,
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
                    color: index == hairSelected
                        ? Colors.white
                        : Colors.transparent),
              ),
              child: InkWell(
                  onTap: () async {
                    setState(() {
                      hairSelected = index;
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset(hairList[index]),
                      ),
                    ],
                  )),
            );
          },
        ),
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
    });
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
          hairChoice(),
          Constant.xSizedBox8,
          separator(),
          Constant.xSizedBox4,
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
