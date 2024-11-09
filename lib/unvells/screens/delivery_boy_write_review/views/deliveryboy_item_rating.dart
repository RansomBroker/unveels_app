/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/helper/app_localizations.dart';
import '../../../app_widgets/rating_bar.dart';
import '../../../models/deliveryBoyDetails/delivery_boy_details_model.dart';
import '../../../models/productDetail/product_detail_page_model.dart';

class DeliveryboyItemRating extends StatelessWidget {
  const DeliveryboyItemRating(this.selectedRating,this.deliveryBoyId,this.customerId, this.name, this.localizations, this.assignedDeliveryBoyDetails,  {Key? key})
      : super(key: key);

  final double? selectedRating;
  final String? deliveryBoyId;
  final String? customerId;
  final String? name;
  final AssignedDeliveryBoyDetails? assignedDeliveryBoyDetails;
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: AppSizes.spacingTiny, top: AppSizes.spacingGeneric),
                child: Text(
                    /*product!.*/name!.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyLarge),
              ),
              const SizedBox(
                height: AppSizes.spacingGeneric,
              ),
              Padding(
                padding: const EdgeInsets.only(left: AppSizes.spacingTiny, top: AppSizes.spacingGeneric),
                child: Text(":", style: Theme.of(context).textTheme.bodyLarge),
              ),
              const SizedBox(
                height: AppSizes.spacingGeneric,
              ),
              Padding(
                padding: const EdgeInsets.only(left: AppSizes.spacingTiny, top: 0),
                child: RatingBar(
                  // starCount: product!.values!.length,
                  starCount: 5,
                  color: AppColors.yellow,
                  // rating: product!.selectedRating,
                  rating: selectedRating,
                  onRatingChanged: (_rating) {
                    assignedDeliveryBoyDetails!.selectedRating = _rating;
                    // product!.selectedRating = _rating;
                    // print("Changed Rating:: ${product!.selectedRating}");
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
