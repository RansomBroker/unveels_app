import 'package:flutter/material.dart';
import '../../../../configuration/text_theme.dart';
import '../../../../constants/app_constants.dart';
import '../../../../models/checkout/payment_info/payment_info_model.dart';
import '../../../../models/wallet_extension_models/wallet_dashboard_model.dart';

Widget showWalletView(
    BuildContext context,
    List<PaymentMethods>? paymentMethods,
    WalletData? wallet,
    bool walletSelected,
    Function(String, bool) updatePaymentMethod,
    String? selectedPaymentMethodCode) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: List.generate(paymentMethods?.length ?? 0, (index) {
      var item = paymentMethods?[index];
      if (item?.code == AppConstant.m2Wallet) {
        return Container(
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
            value: item?.code ?? "",
            groupValue: selectedPaymentMethodCode,
            selected: selectedPaymentMethodCode == item?.code,
            title: Text(
              item?.title ?? "",
              style: KTextStyle.of(context).semiBoldSixteen,
            ),
            subtitle: wallet != null
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                showWalletData(
                    context, "Available Balance", wallet.formattedAmountInWallet ?? ""),
                showWalletData(
                    context, "Remaining Balance", wallet.formattedLeftInWallet ?? ""),
                showWalletData(
                    context, "Payment To Be Made", wallet.formattedPaymentToMade ?? ""),
                showWalletData(
                    context, "Left Amount To Be Paid", wallet.formattedLeftAmountToPay ?? ""),
              ],
            )
                : null,
            onChanged: (value) {
              // Update the selected payment method and toggle the wallet selection state.
              updatePaymentMethod(item?.code ?? "", !(item?.code == selectedPaymentMethodCode));
            },
          ),
        );
      }
      return const SizedBox();
    }),
  );
}

Widget showWalletData(BuildContext context, String title, String body) {
  return Padding(
    padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12),
        ),
        Text(
          body,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12),
        ),
      ],
    ),
  );
}
