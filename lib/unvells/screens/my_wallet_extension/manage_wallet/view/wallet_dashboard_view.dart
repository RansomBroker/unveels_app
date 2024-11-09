import 'package:flutter/material.dart';
import 'package:test_new/unvells/app_widgets/app_text_field.dart';
import 'package:test_new/unvells/app_widgets/custom_button.dart';
import 'package:test_new/unvells/app_widgets/flux_image.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/app_storage_pref.dart';
import 'package:test_new/unvells/helper/utils.dart';

import '../../../../models/wallet_extension_models/wallet_dashboard_model.dart';

Widget walletDashboardView(BuildContext context, WalletDashboardModel? walletDetails, bool showAddAmount, {Function(String)? onTextEditing, Function ()? onTap, controller}) {
  return Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color:
    Colors.white),
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffFCEAC8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FluxImage(
             imageUrl:    "assets/icons/wallet-icon.png" ?? "",
           height: AppSizes.deviceHeight*.1,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(Utils.getStringValue(context, AppStringConstant.walletDetails),
                  style: KTextStyle.of(context).semiBoldSixteen),

                  const SizedBox(
                    width: 10,
                  ),
                  Text("${walletDetails?.walletAmount ?? "\$0.00"}",
                  style: KTextStyle.of(context).bold24),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(Utils.getStringValue(context, AppStringConstant.walletBalanceDesc),
                    style: KTextStyle.of(context).sixteen),

                ],
              ),
            ],
          ),
        ),
        if(showAddAmount)...[
          const SizedBox(
            height: 25,
          ),
          Text(
            Utils.getStringValue(context, AppStringConstant.enterAmountDesc,),
            style: KTextStyle.of(context).twelve.copyWith(fontSize: 14),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller,
                  onChanged: onTextEditing,
                  decoration: InputDecoration(
                      hintText: "${Utils.getStringValue(context, AppStringConstant.amount)} (${appStoragePref.getCurrencyCode() ?? ""})"
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: CustomButton(
                  onPressed: onTap!,
                  hieght: 44,

                  title: Utils.getStringValue(context, AppStringConstant.addAmountToWallet),
                  // child: Text(Utils.getStringValue(context, AppStringConstant.addAmountToWallet),
                  //   style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  //       fontSize: 14
                  //   ),),
                ),
              )
            ],
          )
        ]
      ],
    ),
  );
}