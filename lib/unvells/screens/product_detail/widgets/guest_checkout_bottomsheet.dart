

/*
 *


 *
 * /
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/bottom_sheet_helper.dart';
import '../../../helper/generic_methods.dart';
import '../../login_signup/bloc/signin_signup_screen_bloc.dart';
import '../../login_signup/bloc/signin_signup_screen_repository.dart';
import '../../login_signup/view/signin_screen.dart';


Future<dynamic> guestCheckoutBottomSheet(BuildContext context, String cartTotal, bool isVirtual) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder:
            (BuildContext context, void Function(void Function()) setState) {
          return Container(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
            height: MediaQuery.of(context).size.height / 2.9,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: AppSizes.buttonRadius),
                  Text(
                    GenericMethods.getStringValue(context, AppStringConstant.checkoutAs),
                    style: const TextStyle(
                        fontSize: AppSizes.textSizeMedium,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: AppSizes.spacingGeneric),

                  ElevatedButton(
                    onPressed: () {
                      // Navigator.of(context).pop();
                      signInSignUpBottomModalSheet(context, false, false);
                      // Navigator.of(context).pushNamed(AppRoutes.signInSignUp);
                    },
                    child: Text(GenericMethods.getStringValue(context, AppStringConstant.login),style:Theme.of(context).textTheme.titleLarge?.copyWith(color:  Theme.of(context).colorScheme.surface),),
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        minimumSize: Size(AppSizes.deviceWidth,AppSizes.deviceHeight/18),
                        backgroundColor: Theme.of(context).colorScheme.onPrimary),
                    ),


                  const SizedBox(height: AppSizes.spacingGeneric),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (isVirtual) {
                        Navigator.pushNamed(context, AppRoutes.paymentInfo, arguments: getCheckoutMap("", null));
                      } else {
                        Navigator.of(context).pushNamed(AppRoutes.shippingIfo, arguments: cartTotal);
                      }
                    },
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        minimumSize: Size(AppSizes.deviceWidth,AppSizes.deviceHeight/18),
                        backgroundColor: Theme.of(context).colorScheme.onPrimary),
                    child: Text(GenericMethods.getStringValue(context, AppStringConstant.checkoutAsGuest),style:Theme.of(context).textTheme.titleLarge?.copyWith(color:  Theme.of(context).colorScheme.surface),),
                    ),


                  const SizedBox(height: AppSizes.spacingGeneric),

                  ElevatedButton(
                    onPressed: () {
                      // Navigator.of(context).pop();
                      // Navigator.of(context).pushNamed(AppRoutes.signInSignUp);
                      signInSignUpBottomModalSheet(context, true, false);

                    },
                    child: Text(GenericMethods.getStringValue(context, AppStringConstant.registerAndCheckout),style:Theme.of(context).textTheme.titleLarge?.copyWith(color:  Theme.of(context).colorScheme.surface),),
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        minimumSize: Size(AppSizes.deviceWidth,AppSizes.deviceHeight/18),
                        backgroundColor: Theme.of(context).colorScheme.onPrimary),
                    ),


                ],
              ),
            ),
          );
        });
      });
}