/*
 *


 *
 * /
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:test_new/unvells/configuration/unvells_theme.dart';

import '../constants/app_constants.dart';

class LottieAnimation extends StatelessWidget {
  const LottieAnimation({
    required this.title,
    required this.buttonTitle,
    this.lottiePath,
    required this.onPressed,
    required this.subtitle,
    this.titleSmall,
    this.icon,
    Key? key,
  }) : super(key: key);

  final String? lottiePath, title, subtitle, buttonTitle;
  final String? titleSmall;
  final IconData? icon;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          height: AppSizes.deviceHeight / 5.3 + 180,
          width: AppSizes.deviceWidth - 50,
          // decoration: BoxDecoration(
          //   border: Border.all(
          //     width: 1.0,
          //     color: Theme.of(context).colorScheme.secondaryContainer,
          //   ),
          // ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              titleSmall != null
                  ? Icon(
                      icon,
                      size: AppSizes.deviceHeight / 5.3,
                      color: Colors.grey[400],
                    )
                  : Container(),
              titleSmall != null
                  ? const SizedBox(
                      height: AppSizes.size12,
                    )
                  : Container(),
              lottiePath != null
                  ? Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(AppSizes.size10)),
                      child: Lottie.asset(
                        lottiePath ?? "",
                        width: AppSizes.deviceWidth / 2,
                        height: AppSizes.deviceHeight / 5.3,
                        fit: BoxFit.fill,
                        repeat: true,
                      ),
                    )
                  : Container(),
              const SizedBox(
                height: AppSizes.size12,
              ),
              Text(title ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(fontSize: 18)),
              const Padding(padding: EdgeInsets.all(AppSizes.size6)),
              Text(
                subtitle ?? "",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.normal, fontSize: 16),
              ),
              titleSmall != null
                  ? const SizedBox(
                      height: AppSizes.size4,
                    )
                  : const SizedBox(
                      height: AppSizes.size0,
                    ),
              titleSmall != null
                  ? Text(
                      titleSmall ?? "",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.normal, fontSize: 16),
                    )
                  : Container(),
              const Padding(padding: EdgeInsets.all(AppSizes.size6)),
              ElevatedButton(
                onPressed: onPressed,
                child: Text(
                  buttonTitle ?? "",
                  style: const TextStyle(color: AppColors.white, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
