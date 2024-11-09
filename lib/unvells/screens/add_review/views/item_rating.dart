/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/helper/app_localizations.dart';
import '../../../app_widgets/rating_bar.dart';
import '../../../models/productDetail/product_detail_page_model.dart';

class ItemRating extends StatelessWidget {
  const ItemRating(this.product, this.localizations,  {Key? key})
      : super(key: key);

  final RatingFormData? product;
  final AppLocalizations? localizations;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.size12),
      child: InkWell(
        onTap: () {

        },
        child: Container(
          color: Theme.of(context).cardColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: AppSizes.spacingTiny),
                child: Text(
                    product!.name!,
                    style: Theme.of(context).textTheme.bodyLarge),
              ),
              const SizedBox(
                height: AppSizes.spacingGeneric,
              ),
              Padding(
                padding: const EdgeInsets.only(top: AppSizes.spacingTiny),
                child: RatingBar(
                  starCount: product!.values!.length ?? 0,
                  color: AppColors.yellow,
                  rating: product!.selectedRating ?? 0.0,
                  onRatingChanged: (_rating) {
                    // product!.selectedRating = _rating;
                    product!.selectedRating = _rating;
                    print("Changed Rating:: ${product!.selectedRating}");
                    // rating = _rating;
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

}
