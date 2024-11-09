
/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/constants/app_routes.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/app_string_constant.dart';
import '../../../helper/app_localizations.dart';

Widget contactInfo(BuildContext context, AppLocalizations? _localizations, String title, String name, String email) {
  return Wrap(children: [
    Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.paddingGeneric, vertical: AppSizes.paddingGeneric),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: AppColors.lightGray),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.accountInfo);
                      },
                      child: Text(
                        _localizations?.translate(AppStringConstant.edit) ?? '',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ))
                ],
              ),
              const Divider(
                thickness: 1,
                height: 1,
              ),
              const SizedBox(
                height: AppSizes.paddingNormal,
              ),
              Text(name),
              Text(email),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: AppSizes.paddingGeneric),
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.accountInfo);
                    },
                    child: Text(
                      _localizations
                          ?.translate(AppStringConstant.changePassword) ??
                          '',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary),
                    )),
              )
            ],
          ),
        )),
  ]);
}
