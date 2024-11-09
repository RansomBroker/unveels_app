/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/constants_helper.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/models/catalog/sorting_data.dart';

import '../../../app_widgets/image_view.dart';
import '../../../constants/app_constants.dart';
import '../../../helper/bottom_sheet_helper.dart';
import '../../../models/order_details/order_detail_model.dart';

class ProductListReviewScreen extends StatefulWidget {
  const ProductListReviewScreen(this.orderData, {Key? key}) : super(key: key);
  final OrderData? orderData;

  @override
  State<ProductListReviewScreen> createState() =>
      _ProductListReviewScreenState();
}

class _ProductListReviewScreenState extends State<ProductListReviewScreen> {
  String? groupValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(groupValue);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AppBar(
          elevation: 1,
          title: Text(
            Utils.getStringValue(
                    context, AppStringConstant.chooseAProductToReview)
                .toUpperCase(),
            style: Theme.of(context).textTheme.displaySmall,
          ),
          automaticallyImplyLeading: false,
          // Uncomment this if you require a close button
          // leeading: const CloseButton()
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.orderData?.itemList?.length,
            itemBuilder: (ctx, index) => Padding(
              padding: const EdgeInsets.all(AppSizes.size4),
              child: InkWell(
                onTap: () {
                  reviewBottomModalSheet(
                      context,
                      widget.orderData?.itemList?[index].name ?? '',
                      widget.orderData?.itemList?[index].image ?? '',
                      widget.orderData?.itemList?[index].productId ?? '', []);
                },
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Stack(children: <Widget>[
                              ImageView(
                                url: widget.orderData?.itemList?[index].image,
                                height: (AppSizes.deviceWidth / 3),
                                width: (AppSizes.deviceWidth / 3),
                              ),
                            ]),
                          ),
                          const SizedBox(
                            width: AppSizes.size8,
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: AppSizes.size8,
                              ),
                              child: Text(
                                  widget.orderData?.itemList?[index].name ?? '',
                                  maxLines: 10,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(
                                        fontSize: AppSizes.textSizeMedium,
                                        // color: AppColors.textColorPrimary
                                      )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
