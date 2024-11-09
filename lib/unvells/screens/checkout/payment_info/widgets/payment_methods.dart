/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/configuration/unvells_theme.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/models/checkout/payment_info/payment_info_model.dart';
import 'package:test_new/unvells/models/checkout/shipping_info/shipping_methods_model.dart';

import '../../../../models/wallet_extension_models/wallet_dashboard_model.dart';

class PaymentMethodsView extends StatefulWidget {
  ValueChanged<String>? callBack;
  List<PaymentMethods>? paymentMethods;
  List<PaymentMethods>? allPaymentMethod;
  VoidCallback? paymentCallback;
  WalletData? walletData;
  String? selectedPaymentCode;

  PaymentMethodsView(
      {Key? key,
        this.callBack,
        this.paymentMethods,
        this.paymentCallback,
      this.walletData,
      this.selectedPaymentCode})
      : super(key: key);

  @override
  _ShippingMethodsState createState() => _ShippingMethodsState();
}

class _ShippingMethodsState extends State<PaymentMethodsView> {
  // String widget?.selectedPaymentCode = '';
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
             widget.paymentMethods?.length ?? 0,
            (index) {
              PaymentMethods? item;
          if ((widget.paymentMethods ?? []).isNotEmpty) {
            item = widget.paymentMethods?[index];
          } else {
            item = widget.paymentMethods?[index];
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
              decoration: ShapeDecoration(
                color: const Color(0xFFF5F5F5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: RadioListTile<String>(
                activeColor: AppColors.gold,
                contentPadding: EdgeInsets.zero,
                dense: true,
                selected: widget.selectedPaymentCode == item?.code,
                subtitle: Text("${item?.extraInformation} " ,
                  style: KTextStyle.of(context).twelve.copyWith(color: Colors.grey),
                ),
                title: Text("${item?.title} " ,
                  style: KTextStyle.of(context).semiBoldSixteen,
                ),
                value: (item?.code ?? "").toString(),
                groupValue:
                (widget.selectedPaymentCode == item?.code) ? (item?.code) : "",
                onChanged: (value) {
                  setState(() {
                    if (widget.paymentCallback != null) {
                      widget.paymentCallback!();
                    }
                    widget.selectedPaymentCode = item?.code ?? '';
                    if (widget.callBack != null) {
                      widget.callBack!(widget.selectedPaymentCode ?? "");
                    }
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}