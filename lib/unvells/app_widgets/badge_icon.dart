/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/helper/app_storage_pref.dart';

import '../helper/preferences.dart';

class BadgeIcon extends StatefulWidget {
  BadgeIcon(
      {Key? key,
        this.icon,
        this.showIfZero = false,
        this.badgeColor = Colors.red,
        TextStyle? badgeTextStyle})
      : badgeTextStyle = badgeTextStyle ??
      const TextStyle(
        color: Colors.white,
        fontSize: 8,
      ),
        super(key: key);
  final Widget? icon;
  final bool showIfZero;
  final Color badgeColor;
  final TextStyle badgeTextStyle;

  @override
  State<BadgeIcon> createState() => _BadgeIconState();
}

class _BadgeIconState extends State<BadgeIcon> {
  int badgeCount = 0;

  @override
  Widget build(BuildContext context) {
    registerBadgeCountListener();
    return Stack(clipBehavior: Clip.none,children: <Widget>[
      widget.icon!,
      if (badgeCount > 0 || widget.showIfZero) badge(badgeCount),
    ]);
  }

  Widget badge(int count) => Positioned(
    right: -3,
    top: -3,
    child: Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color:AppColors.gold,
        borderRadius: BorderRadius.circular(8.5),
      ),
      constraints: const BoxConstraints(
        minWidth: 18,
        minHeight: 15,
      ),
      child: Center(
        child: Text(
          (count < 100) ? count.toString() : "99+",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 8,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );

  //=============================User to handle badge count=======/
  void registerBadgeCountListener() {
    appStoragePref.customerStorage.listenKey(Preferences.CART_COUNT, (value) {
      if (badgeCount != (appStoragePref.getCartCount() ?? 0)) {
        Future.delayed(Duration.zero).then((value) {
          try {
            if(mounted){
              setState(() {
                badgeCount = appStoragePref.getCartCount() ?? 0;
              });
            }
          } catch (e) {
            print("Badge Error--$e");
          }
        });
      }
    });
  }
}
