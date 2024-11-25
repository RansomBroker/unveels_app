import 'package:flutter/material.dart';
import 'package:test_new/unvells/constants/app_routes.dart';
import 'package:test_new/unvells/constants/arguments_map.dart';

class VaProductCard extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String itemName;
  final String brandName;
  final double currentPrice;
  final double? originalPrice;

  const VaProductCard({
    super.key,
    required this.id,
    required this.imageUrl,
    required this.itemName,
    required this.brandName,
    required this.currentPrice,
    this.originalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        AppRoutes.productPage,
        arguments: getProductDataAttributeMap(itemName, id),
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        width: 116,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 5),
            Text(
              itemName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w600,
                height: 1,
                fontFamily: 'Lato',
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  brandName,
                  style: const TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.6),
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    height: 1,
                    fontFamily: 'Lato',
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      'KWD $currentPrice',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        height: 1,
                        fontFamily: 'Lato',
                      ),
                    ),
                    originalPrice != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '\$$originalPrice',
                                style: const TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 0.5),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  height: 1,
                                  fontFamily: 'Lato',
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              const SizedBox(height: 4)
                            ],
                          )
                        : const SizedBox(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
