/*
 *
  

 *
 * /
 */

import 'package:flutter/material.dart';

import '../../../constants/app_constants.dart';

class RatingContainer extends StatefulWidget {
  double rating;
  int? fontSize;
  RatingContainer(this.rating, {Key? key, this.fontSize}) : super(key: key);

  @override
  State<RatingContainer> createState() => _RatingContainerState();
}

class _RatingContainerState extends State<RatingContainer> {


  @override
  Widget build(BuildContext context) {

    print(widget.rating.toStringAsFixed(0));
    return  Container(
      color: containerColor(widget.rating.toStringAsFixed(0) ?? ''),
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.size8, vertical: AppSizes.size8 / 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("${widget.rating}",
            style: const TextStyle(color: AppColors.white, fontSize: 10),
          ),
          const SizedBox(
            width: 2.0,
          ),
          const Icon(
            Icons.star,
            color: AppColors.white,
            size: 10,
          )
        ],
      ),
    );
  }

  Color containerColor(String review){
    switch(review){
      case "1":
        return AppColors.red;
      case "2":
        return AppColors.lightRed;
      case "3":
        return AppColors.yellow;
      case "4":
        return AppColors.orange;
      case "5":
        return AppColors.green;
      default :
        return AppColors.black;
    }
  }

}
