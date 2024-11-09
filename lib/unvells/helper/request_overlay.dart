import 'package:flutter/material.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/helper/skeleton_widget.dart';

class KRequestOverlay extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final String? error;
  final Widget? loadingWidget;
  final void Function()? onTryAgain;
  const KRequestOverlay(
      {Key? key,
      required this.child,
      required this.isLoading,
      this.error,
      this.onTryAgain,
      this.loadingWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        if (isLoading)
          loadingWidget ??  Skeleton(width: AppSizes.deviceWidth,)
        else if (error != null)
          Text(error ?? '')
        // KErrorView(error: error, onTryAgain: onTryAgain)
        else
          child
      ],
    );
  }
}
