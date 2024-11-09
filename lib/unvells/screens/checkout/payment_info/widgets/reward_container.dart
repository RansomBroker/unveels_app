import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../configuration/text_theme.dart';
import '../../../../helper/request_overlay.dart';
import '../../../login_signup/bloc/signin_signup_screen_bloc.dart';

class RewardContainer extends StatelessWidget {
  const RewardContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffE5EFE5),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle,
            color: Color(0xff006400),
          ),
          const SizedBox(
            width: 2,
          ),
          Expanded(
            child: BlocBuilder<AuthBloc, SigninSignupScreenState>(
              builder: (context, state) {
                final signInSignupScreenBloc =
                    context.read<AuthBloc>();
                return KRequestOverlay(
                  isLoading: signInSignupScreenBloc.customerCartLoading == true,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: "Checkout now and earn ",
                            style: KTextStyle.of(context)
                                .twelve
                                .copyWith(color: const Color(0xff006400))),
                        TextSpan(
                          text:
                              "${signInSignupScreenBloc.customerCartData?.mstRewardPoints?.earnPoints??''} Reward Points",
                          style: KTextStyle.of(context).boldTwelve.copyWith(
                                color: const Color(0xff006400),
                              ),
                        ),
                        TextSpan(
                            text: " for this order.",
                            style: KTextStyle.of(context)
                                .twelve
                                .copyWith(color: const Color(0xff006400))),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
