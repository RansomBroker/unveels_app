/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/app_widgets/flux_image.dart';

import '../../constants/app_constants.dart';
import '../badge_icon.dart';
import 'bottom_tabbar.dart';

class BadgeIconUpdate extends StatefulWidget {
  const BadgeIconUpdate({super.key, required this.iconColor});
  final Color iconColor;

  @override
  State<BadgeIconUpdate> createState() => _BadgeIconUpdateState();
}

class _BadgeIconUpdateState extends State<BadgeIconUpdate> {
  late int _badgeCount;

  @override
  void initState() {
    _badgeCount = 0;
    _registerStreamListener();
    super.initState();
  }

  void _registerStreamListener() {
    if (mounted) {
      TabBarController.countController.stream.listen((event) {
        if (mounted) {
          setState(() {});
        }
        _badgeCount = event;
        print("badge count $event");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BadgeIcon(
      icon:  FluxImage(imageUrl: "assets/icons/cart.svg", color:widget.iconColor,),
      badgeColor: AppColors.gold,
    );
  }
}
