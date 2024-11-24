import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_new/unvells/constants/app_routes.dart';
import 'package:test_new/unvells/constants/arguments_map.dart';

import '../../../../shared/configs/asset_path.dart';
import '../../../../shared/widgets/buttons/button_widget.dart';
import '../../../skin_tone_finder/skin_tone_product_model.dart';
import '../../look_product_model.dart';

class PFProductItemWidget extends StatelessWidget {
  const PFProductItemWidget({super.key, this.productData, this.lookData});

  final SkinToneProductData? productData;
  final LookProfiles? lookData;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        AppRoutes.productPage,
        arguments: getProductDataAttributeMap(
          productData?.name ?? '',
          productData?.id.toString() ?? '',
        )
      ),
      child: SizedBox(
        height: 242,
        width: 151,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            lookData == null
                ? CachedNetworkImage(
                    imageUrl:
                        "https://magento-1231949-4398885.cloudwaysapps.com/media/catalog/product${productData?.customAttributes.where((e) => e.attributeCode == 'small_image').first.value}",
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
                    height: 242 * 0.65,
                    fit: BoxFit.cover,
                  )
                : CachedNetworkImage(
                    imageUrl:
                        "https://magento-1231949-4398885.cloudwaysapps.com/media/${lookData?.image}",
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
                    height: 242 * 0.65,
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
                        lookData?.name ?? productData?.name ?? '-',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Brand name",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 8,
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                if (lookData == null)
                  Text(
                    "\$${productData?.price}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ButtonWidget(
                    text: "ADD TO CART",
                    backgroundColor: Colors.transparent,
                    borderColor: Colors.white,
                    height: 27,
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: ButtonWidget(
                    text: "SEE\nIMPROVEMENT",
                    backgroundColor: Colors.white,
                    height: 27,
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 0,
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
