/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import '../../../constants/app_constants.dart';

Widget collapseAppBar(BuildContext context,Widget background,  Widget body, double expandedHeight,
    {TabBar? tabBar}) {
  return NestedScrollView(
      floatHeaderSlivers: false,
      physics: const BouncingScrollPhysics(),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            pinned: true,
            floating: false,
            elevation: 0,
            toolbarHeight: 0,
            collapsedHeight: null,
            automaticallyImplyLeading: false,
            expandedHeight: expandedHeight,
            flexibleSpace:
            FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: background),
            titleSpacing: 0,
            primary: false,
          ),
        ];
      },
      body: Scaffold(appBar: tabBar, body: body));
}

