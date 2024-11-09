/*
 *
  

 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/configuration/unvells_theme.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/models/checkout/payment_info/payment_info_model.dart';
import 'package:test_new/unvells/models/checkout/shipping_info/shipping_methods_model.dart';

class ShippingMethodsView extends StatefulWidget {
  List<ShippingMethods>? shippingMethodList;
  ValueChanged<String>? callBack;
  List<PaymentMethods>? paymentMethods;
  VoidCallback? paymentcallback;

  ShippingMethodsView(
      {Key? key,
      this.shippingMethodList,
      this.callBack,
      this.paymentMethods,
      this.paymentcallback})
      : super(key: key);

  @override
  _ShippingMethodsState createState() => _ShippingMethodsState();
}

class _ShippingMethodsState extends State<ShippingMethodsView> {
  String selectedShippingMethod = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        widget.shippingMethodList?.length ?? 0,
        (index) {
          ShippingMethods? item;
          if ((widget.shippingMethodList ?? []).isNotEmpty) {
            item = widget.shippingMethodList?[index];
          } else {
            // item = widget.paymentMethods?[index];
          }
          return Padding(
            padding: const EdgeInsets.only(
              top: AppSizes.size8,
              left: AppSizes.size16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item?.title ?? "",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: item?.method?.length ?? 0,
                        itemBuilder: (context, index) {
                          return RadioListTile<String>(
                            activeColor: Theme.of(context).iconTheme.color,
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            selected: selectedShippingMethod ==
                                item?.method?[index].code,
                            title: Text(
                              "${item?.method?[index].label} - ${item?.method?[index].price}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.normal),
                            ),
                            value: (item?.method?[index].code ?? "").toString(),
                            groupValue: (selectedShippingMethod ==
                                    item?.method?[index].code)
                                ? (item?.method?[index].code)
                                : "",
                            onChanged: (value) {
                              // debugPrint();
                              setState(() {
                                // if((widget.shippingMethodList ?? []).isEmpty){
                                // }
                                if (widget.paymentcallback != null) {
                                  widget.paymentcallback!();
                                }

                                selectedShippingMethod =
                                    item?.method?[index].code ?? '';
                                if (widget.callBack != null) {
                                  widget.callBack!(selectedShippingMethod);
                                }
                              });
                            },
                          );
                        }),
                  ],
                ),
                const Divider(
                  thickness: 0.5,
                  height: 0.5,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
