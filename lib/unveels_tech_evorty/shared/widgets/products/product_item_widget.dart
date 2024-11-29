import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_new/logic/get_product_utils/repository/product_repository.dart';
import 'package:test_new/unvells/constants/app_routes.dart';
import 'package:test_new/unvells/constants/arguments_map.dart';

import '../../configs/asset_path.dart';
import '../buttons/button_widget.dart';

class ProductItemWidget extends StatelessWidget {
  final double height, width;
  final Function() onAddToCart;
  final Function() onSelect;
  final ProductData product;

  const ProductItemWidget({
    super.key,
    this.height = 300,
    this.width = 195,
    required this.onAddToCart,
    required this.onSelect,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        AppRoutes.productPage,
        arguments:
            getProductDataAttributeMap(product.name, product.id.toString()),
      ),
      child: SizedBox(
        height: height,
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              width: width,
              height: width,
              child: Image.network(product.imageUrl,
                  width: width, height: width, fit: BoxFit.contain),
            ),
            const SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFE6E5E3),
                        ),
                      ),
                      Text(
                        product.brand,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 7,
                          color: const Color(0xFFE6E5E3).withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 60,
                  child: Text(
                    "KWD ${product.price}",
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFE6E5E3),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            SvgPicture.asset(
              IconPath.fourStarsExample,
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 30,
                    child: ButtonWidget(
                      text: "ADD TO CART",
                      backgroundColor: Colors.black,
                      borderColor: Colors.white,
                      style: const TextStyle(
                        fontSize: 8,
                        color: Colors.white,
                      ),
                      onTap: onAddToCart,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                Expanded(
                  child: SizedBox(
                    height: 30,
                    child: ButtonWidget(
                      text: "SELECT",
                      backgroundColor: Colors.white,
                      style: const TextStyle(
                        fontSize: 8,
                        color: Colors.black,
                      ),
                      onTap: onSelect,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
