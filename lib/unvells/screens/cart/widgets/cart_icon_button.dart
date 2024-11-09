/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/constants/app_constants.dart';

import '../../../configuration/unvells_theme.dart';

class CartIconButton extends StatelessWidget {
  const CartIconButton({
    required this.leadingIcon,
    required this.title,
    required this.onClick,
    Key? key,
  }) : super(key: key);

  final IconData leadingIcon;
  final String title;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: SizedBox(
        height: 40,
        child: OutlinedButton(
          onPressed: onClick,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                leadingIcon,
                color:  Theme.of(context).colorScheme.outline,
                size: 22,
              ),
              const SizedBox(
                width: AppSizes.size15,
              ),
              Text(
                title.toUpperCase(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.outline),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: AppSizes.size8),
  //     child: GestureDetector(
  //       onTap: onClick,
  //       child: Container(
  //         height: AppSizes.size44,
  //         color: Theme.of(context).cardColor,
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: AppSizes.size8),
  //               child: Icon(leadingIcon,color: Theme.of(context).iconTheme.color,size: 22,),
  //             ),
  //         Text(
  //               title,
  //               style:Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 13, fontWeight: FontWeight.bold))
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
