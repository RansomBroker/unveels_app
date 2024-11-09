/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/configuration/unvells_theme.dart';
import 'package:test_new/unvells/constants/app_constants.dart';

class ActionContainer extends StatelessWidget {
  const ActionContainer({
    this.iconLeft,
    this.iconRight,
    this.leftCallback,
    this.rightCallback,
    required this.titleLeft,
    required this.titleRight,
    Key? key,
  }) : super(key: key);

  final IconData? iconLeft, iconRight;
  final String titleLeft, titleRight;
  final VoidCallback? leftCallback, rightCallback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            height: 40,
            width: MediaQuery.of(context).size.width / 2.5,
            child: OutlinedButton(
              onPressed: leftCallback,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    iconLeft ?? Icons.edit,
                    size: AppSizes.size16,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    titleLeft.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40,
            width: MediaQuery.of(context).size.width / 2.5,
            child: OutlinedButton(
              onPressed: rightCallback,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    iconRight ?? Icons.add,
                    size: AppSizes.size16,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    titleRight.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
