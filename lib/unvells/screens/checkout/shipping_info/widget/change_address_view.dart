/*
 *
  

 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';

import 'package:test_new/unvells/models/checkout/shipping_info/shipping_address_model.dart';
import 'package:test_new/unvells/screens/checkout/shipping_info/widget/address_item_card.dart';

import '../../../../app_widgets/app_bar.dart';
import '../../../../configuration/text_theme.dart';
import '../../../../helper/app_localizations.dart';
import '../../../../helper/utils.dart';

class ShowAddressList extends StatefulWidget {
  Function(String) onTap;
  ShippingAddressModel? addresses;
  VoidCallback? callback;

  ShowAddressList(this.onTap, this.addresses, {Key? key, this.callback})
      : super(key: key);

  @override
  _ShowAddressListState createState() => _ShowAddressListState();
}

class _ShowAddressListState extends State<ShowAddressList> {
  AppLocalizations? _localizations;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _localizations?.translate(AppStringConstant.shippingAddress) ?? '',
          style: KTextStyle.of(context).boldSixteen,
        ),
        const SizedBox(
          height: 16,
        ),
        ListView.separated(
          itemCount: widget.addresses?.address?.length ?? 0,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var item = widget.addresses?.address?[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.size8),
              child: InkWell(
                  onTap: () {
                    widget.addresses?.selectedAddressData = item;
                    widget.onTap(item?.id ?? "0");

                    // Navigator.pop(context);
                  },
                  child: addressItemCard(
                    item?.value ?? "",
                    context,
                    callback: widget.callback,
                    isSelected: widget.addresses?.selectedAddressData == item,
                  )),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 12,
            );
          },
        ),
      ],
    );
  }
}
