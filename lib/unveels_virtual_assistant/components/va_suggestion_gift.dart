import 'package:flutter/material.dart';

import '../screen/text_connection/bloc/va_state.dart';
import 'va_product_card.dart';

class VaSuggestedGiftsWidget extends StatelessWidget {
  final List<ProductInfo> products;

  const VaSuggestedGiftsWidget({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 11),
      height: 200,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black, Color(0xFF47330A)],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Suggested Gifts',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w700,
              fontFamily: 'Lato',
              letterSpacing: -0.29,
              height: 2,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 200.0, // Atur tinggi sesuai kebutuhan
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return VaProductCard(
                  id: product.id.toString(),
                  imageUrl: product.imageUrl,
                  itemName: product.name,
                  brandName: product.brand,
                  currentPrice: product.price,
                  originalPrice: product.price
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
