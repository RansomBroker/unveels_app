import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_new/unveels_tech_evorty/shared/configs/asset_path.dart';

class BottomCopyright extends StatelessWidget {
  final void Function()? onTap;
  final bool showContent;
  final Widget? child;

  const BottomCopyright(
      {super.key, this.onTap, this.showContent = false, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black,
          ],
        ),
      ),
      child: Column(
        children: [
          showContent ? child ?? const SizedBox() : const SizedBox(),
          GestureDetector(
            onTap: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  showContent == false
                      ? CupertinoIcons.chevron_compact_up
                      : CupertinoIcons.chevron_compact_down,
                  color: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Powered by",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    SvgPicture.asset(
                      IconPath.unveelsLogo,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
