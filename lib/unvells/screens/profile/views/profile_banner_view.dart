/*
 *
  

 *
 * /
 */

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_new/unvells/app_widgets/flux_image.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import '../../../app_widgets/image_view.dart';
import '../../../configuration/unvells_theme.dart';
import '../../../constants/app_constants.dart';
import '../../../helper/app_localizations.dart';
import '../../../helper/app_storage_pref.dart';
import '../../../models/dashboard/UserDataModel.dart';

class ProfileBannerView extends StatefulWidget {
  Function(String, String)? addImageCallback;
  Function(String)? deleteImageCallBack;

  ProfileBannerView(this.addImageCallback, {Key? key}) : super(key: key);

  @override
  _ProfileBannerViewState createState() => _ProfileBannerViewState();
}

class _ProfileBannerViewState extends State<ProfileBannerView> {
  String? bannerImage;
  String? profileImage;
  String name = "";
  String email = "";
  AppLocalizations? _localizations;

  @override
  void initState() {
    UserDataModel? userModel = appStoragePref.getUserData();
    bannerImage = userModel?.bannerImage;
    profileImage = userModel?.profileImage;
    name = userModel?.name ?? "";
    super.initState();
  }

  void getDetails() {
    setState(() {
      UserDataModel? userModel = appStoragePref.getUserData();
      bannerImage = userModel?.bannerImage;
      profileImage = userModel?.profileImage;
      name = userModel?.name ?? "";
      email = userModel?.email ?? "";
    });
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    getDetails();
    return commonBannerView(bannerImage, profileImage, name, email);
  }

  Widget commonBannerView(
      String? bannerImage, String? profileImage, String name, String email) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 65.80,
            height: 65.80,
            decoration: const ShapeDecoration(
              color: Colors.white,
              shape: OvalBorder(),
            ),
            child: Center(
                child: ClipOval(
                    child:
                    FluxImage(
                      imageUrl: profileImage ??
                          "assets/icons/profile-header.svg",
                      fit: BoxFit.contain,
                      color: AppColors.gold,
                      height: 40,
                      width: 40,
                    )

                )),
          ),
          const SizedBox(width: AppSizes.spacingGeneric),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: KTextStyle.of(context).boldSixteen,
              ),
              const SizedBox(
                height: AppSizes.spacingTiny,
              ),
              Text(
                email,
                style: KTextStyle.of(context).twelve,
              ),
            ],
          )
        ],
      ),
    );
  }
}
