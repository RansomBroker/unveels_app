import 'package:flutter/material.dart';

class BottomCopyrightWidget extends StatelessWidget {
  final double? topMargin;
  final Widget child;

  const BottomCopyrightWidget({
    super.key,
    this.topMargin,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Container(
        margin: EdgeInsets.only(
          top: topMargin ?? 0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            child,
            const SizedBox(
              height: 10,
              width: double.infinity,
            )
          ],
        ),
      ),
    );
  }
}
