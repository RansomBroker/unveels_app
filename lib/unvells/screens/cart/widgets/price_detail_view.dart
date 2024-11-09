/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/app_localizations.dart';
import 'package:test_new/unvells/helper/app_storage_pref.dart';

import '../../../models/cart/price_details.dart';

class PriceDetailView extends StatefulWidget {
  const PriceDetailView(
    this.totalData,
    this.localizations, {
    super.key,
    this.fromCheckout = false,
    // this.rewardDiscount,
  });

  final List<PriceDetails>? totalData;
  final bool fromCheckout;
  // final String? rewardDiscount;
  final AppLocalizations? localizations;

  @override
  State<PriceDetailView> createState() => _PriceDetailViewState();
}

class _PriceDetailViewState extends State<PriceDetailView> {
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.fromCheckout ? Colors.transparent : const Color(0xFFFFFCF7),
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: widget.fromCheckout
              ? const EdgeInsets.symmetric(horizontal: 6)
              : const EdgeInsets.all(16),
          itemCount: widget.totalData?.length ?? 0,
          itemBuilder: (context, index) {
            return _priceItem(widget.totalData?[index], context);
          }),
    );
  }

  Widget _priceItem(PriceDetails? data, BuildContext context) => Padding(
        padding: const EdgeInsets.only(
            left: AppSizes.linePadding,
            right: AppSizes.linePadding,
            bottom: AppSizes.spacingGeneric),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Text(data?.title ?? '',
                  style: KTextStyle.of(context).semiTwelve),
            ),
            const Spacer(),
            Text(data?.value ?? '',
                style: KTextStyle.of(context).semiBoldSixteen),
          ],
        ),
      );
}
