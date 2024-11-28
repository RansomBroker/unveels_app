import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_new/logic/get_product_utils/repository/product_repository.dart';
import 'package:test_new/unvells/constants/app_routes.dart';
import 'package:test_new/unvells/constants/arguments_map.dart';

import '../../configs/asset_path.dart';
import '../buttons/button_widget.dart';

class SmallProductItemWidget extends StatelessWidget {
  final Function()? onAddToCart;
  final ProductData? product;

  const SmallProductItemWidget({
    super.key,
    this.onAddToCart,
    this.product,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        AppRoutes.productPage,
        arguments:
            getProductDataAttributeMap(product?.name, product?.id.toString()),
      ),
      child: SizedBox(
        height: 130,
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              width: 100,
              height: 68,
              child: Image.network(product?.imageUrl ?? "",
                  width: 100, height: 68, fit: BoxFit.contain),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              product?.name ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.lato(
                fontSize: 8,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Text(
              product?.brand ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.lora(
                fontSize: 8,
                color: Colors.white.withOpacity(0.6),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  "KWD ${product?.price ?? ""}",
                  style: GoogleFonts.lora(
                    fontSize: 8,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: 20,
                  width: 50,
                  child: ButtonWidget(
                    text: "Add to cart",
                    backgroundGradient: const LinearGradient(
                      colors: [
                        Color(0xFFCA9C43),
                        Color(0xFF92702D),
                      ],
                    ),
                    style: GoogleFonts.lato(
                      fontSize: 8,
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 0,
                    ),
                    onTap: onAddToCart,
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
