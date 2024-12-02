import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/constants/app_routes.dart';
import 'package:test_new/unvells/constants/arguments_map.dart';

import '../../skin_tone_product_model.dart';

class STFProductItemWidget extends StatelessWidget {
  const STFProductItemWidget({super.key, this.data});
  final SkinToneProductData? data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        AppRoutes.productPage,
        arguments: getProductDataAttributeMap(
          data?.name ?? '',
          data?.id.toString() ?? '',
        ),
      ),
      child: SizedBox(
        height: 120,
        width: 115,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            data == null
                ? Container(
                    color: Colors.white,
                    child: const Center(
                        child: SizedBox(
                            height: 25, width: 25, child: Icon(Icons.error))),
                  )
                : CachedNetworkImage(
                    imageUrl:
                        "${ApiConstant.webUrl}/media/catalog/product${data?.customAttributes?.where((e) => e.attributeCode == 'small_image').first.value ?? ''}",
                    placeholder: (context, url) {
                      return Container(
                        color: Colors.white,
                        child: const Center(
                            child: SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator())),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Container(
                        color: Colors.white,
                        child: const Center(
                            child: SizedBox(
                                height: 25, width: 25, child: Icon(Icons.error))),
                      );
                    },
                    width: 115,
                    height: 120 * 0.65,
                    fit: BoxFit.cover,
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
                        data?.name ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.lora(
                          fontSize: 8,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Brand name",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.lora(
                          fontSize: 8,
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "KWD ${data?.price ?? 0}",
                  style: GoogleFonts.lora(
                    fontSize: 8,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                // Text(
                //   "\$15",
                //   style: GoogleFonts.lora(
                //     fontSize: 8,
                //     fontWeight: FontWeight.w500,
                //     color: Colors.white.withOpacity(0.5),
                //     textStyle: TextStyle(
                //       decoration: TextDecoration.lineThrough,
                //       color: Colors.white.withOpacity(0.5),
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
