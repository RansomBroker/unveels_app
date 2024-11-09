import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/screens/checkout/payment_info/bloc/Payment_info_bloc.dart';
import 'package:test_new/unvells/screens/checkout/payment_info/bloc/payment_info_events.dart';
import 'package:test_new/unvells/screens/login_signup/bloc/signin_signup_screen_bloc.dart';
import 'package:test_new/unvells/screens/login_signup/bloc/signin_signup_screen_bloc.dart';

import '../../../../constants/app_string_constant.dart';
import '../../../cart/widgets/discount_view.dart';

class ApplyReward extends StatelessWidget {
  const ApplyReward({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, SigninSignupScreenState>(
      builder: (context, state) {
        final paymentInfoScreenBloc = context.read<PaymentInfoScreenBloc>();
        final mstRewardPoints =
            context.read<AuthBloc>().customerCartData?.mstRewardPoints;

        return DiscountView(
          expanded: mstRewardPoints?.isApplied ?? false,
          maxNumber: mstRewardPoints?.spendMaxPoints.toString(),
          discountApplied: mstRewardPoints?.isApplied ?? false,
          discountCode: mstRewardPoints?.spendPoints.toString() ?? "",
          onClickApply: (discountCode) {
            paymentInfoScreenBloc
                .add(ApplyRewardPointEvent(discountCode.toString() ?? "", 0));
          },
          keybordType: TextInputType.number,
          onClickRemove: (discountCode) {
            paymentInfoScreenBloc.add(ApplyRewardPointEvent(
                mstRewardPoints?.spendPoints.toString() ?? "", 1));
          },
          title: AppStringConstant.rewardPoint,
          hint: AppStringConstant.enterAmountOfPoint,
          warning: " (${mstRewardPoints?.spendMaxPoints} Reward Max)",
        );
      },
    );
  }
}
