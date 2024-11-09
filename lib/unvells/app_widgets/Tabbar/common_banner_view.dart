/*
 *


 *
 * /
 */

import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_new/unvells/helper/utils.dart';

import '../../configuration/unvells_theme.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_routes.dart';
import '../../constants/app_string_constant.dart';
import '../../helper/app_localizations.dart';
import '../../helper/app_storage_pref.dart';
import '../../models/dashboard/UserDataModel.dart';
import '../bottom_sheet.dart';
import '../image_view.dart';

class CommonBannerView extends StatefulWidget {
  Function(String, String)? addImageCallback;
  Function(String)? deleteImageCallBack;
  bool editProfile = false;
  bool isLoading = false;

  CommonBannerView(this.addImageCallback, this.editProfile,this.isLoading, {Key? key})
      : super(key: key);

  @override
  _CommonBannerViewState createState() => _CommonBannerViewState();
}

class _CommonBannerViewState extends State<CommonBannerView> {
  String? bannerImage;
  String? profileImage;
  String name = "";
  String email = "";
  File? pickedBannerImage;
  File? pickedProfileImage;
  final ImagePicker _picker = ImagePicker();
  AppLocalizations? _localizations;

  @override
  void initState() {
    UserDataModel? userModel = appStoragePref.getUserData();
    // bannerFromNetwork = true;
    // profileFromNetwork = true;
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
      print("TEST_LOG==> ${userModel?.profileImage}");
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
    return Container(
        width: AppSizes.deviceWidth,
        child: commonBannerView(bannerImage, profileImage, name, email, () {
          setState(() {
            _showChoiceBottomSheet(context, false);
          });
        }, () {
          setState(() {
            _showChoiceBottomSheet(context, true);
          });
        })
    );
  }

  Widget commonBannerView(
      String? bannerImage,
      String? profileImage,
      String name,
      String email,
      VoidCallback? changeBannerImage,
      VoidCallback changeProfileImage) {
    return Container(
      height: AppSizes.deviceHeight / 3,
      width: AppSizes.deviceWidth,
      child: Card(
          elevation: 0,
          child: Stack(
            children: [
              Container(
                child: CachedNetworkImage(
                  imageUrl: bannerImage ?? '',
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  placeholder: (context, url) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                          image: AssetImage(
                            AppImages.bannerImage,
                          ),
                          fit: BoxFit.fill
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(8),
                      image: const DecorationImage(
                          image: AssetImage(
                            AppImages.bannerImage,
                          ),
                          fit: BoxFit.fill
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: UnvellsTheme.accentColor,
                                    width: 2.0)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: CachedNetworkImage(
                                imageUrl: profileImage ?? '',
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                                placeholder: (context, url) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                          AppImages.placeholder,
                                        )
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(8),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                          AppImages.placeholder,
                                        )),
                                  ),
                                ),
                              ),

                            )
                        ),
                        if(widget.editProfile)
                          Positioned(
                              right: 2.0,
                              child: GestureDetector(
                                onTap: changeProfileImage,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    shape: BoxShape.circle,
                                  ),
                                  height: 25,
                                  width: 25,
                                  child: const Icon(
                                    Icons.edit,
                                    size: 20,
                                  ),
                                ),
                              ))
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: AppSizes.paddingMedium),
                        child: Column(
                          children: [
                            Text(
                              name,
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: AppSizes.textSizeMedium, color: Colors.white),
                            ),
                            const SizedBox(height: AppSizes.spacingTiny,),
                            Text(
                              email,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: AppSizes.textSizeMedium, color: Colors.white),
                            ),
                            const SizedBox(height: AppSizes.spacingGeneric,),
                            if(widget.editProfile)
                              GestureDetector(
                                onTap: (){
                                  Navigator.of(context).pushNamed(AppRoutes.accountInfo);
                                },
                                child: Container(
                                    decoration: const BoxDecoration(
                                        color: AppColors.transparentBackground,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.all(Radius.circular(20.0))
                                    ),
                                    // height: 25,
                                    // width: 25,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: AppSizes.paddingGeneric, horizontal: AppSizes.paddingGeneric,
                                      ),
                                      child: Text(
                                        "${_localizations?.translate(AppStringConstant.editInfo).toUpperCase()}",
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: AppSizes.textSizeSmall, color: Colors.white),
                                      ),
                                    )
                                ),
                              ),
                          ],
                        )
                    )
                  ],
                ),
              ),
              if(widget.editProfile)
                Positioned(
                  bottom: 10.0,
                  right: 10.0,
                  child: GestureDetector(
                    onTap: changeBannerImage,
                    child: Container(
                      height: 25.0,
                      width: 25.0,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.edit,
                        size: 23,
                      ),
                    ),
                  ),
                ),
            ],
          )),
    );
  }

  void _showChoiceBottomSheet(BuildContext context, bool uploadProfile) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(15, 17, 0, 10),
                child: Text(
                  Utils.getStringValue(context, AppStringConstant.chooseOption),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              ListTile(
                leading: const Icon(Icons.folder),
                title: Text(Utils.getStringValue(context, AppStringConstant.gallery),
                    style: Theme.of(context).textTheme.bodyLarge),
                onTap: () {

                  widget.isLoading = true;
                  Navigator.of(context).pop();
                  _openGallery(context, uploadProfile, widget.isLoading);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera),
                title: Text(
                  Utils.getStringValue(context, AppStringConstant.camera),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {
                  // _getFromCamera(context, uploadProfile);
                  widget.isLoading = true;
                  Navigator.of(context).pop();
                  _openCamera(context, uploadProfile, widget.isLoading);
                },
              )
            ],
          );
        });
    //Navigator.pop(context);
  }

  void _openCamera(BuildContext context, bool uploadProfile, bool isLoading) async {
    Navigator
        .of(context)
        .pop;
    final XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxWidth: uploadProfile ? 500 : 900,
        maxHeight: uploadProfile ? 500 : 600,
        imageQuality: 60,
        requestFullMetadata: true
    );
    if (image != null) {
      // Rotate the image to fix the wrong rotation coming from ImagePicker
      File rotatedImage = await FlutterExifRotation.rotateImage(
          path: image.path);


      // final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      setState(() {
        if (uploadProfile) {
          // profileFromNetwork = false;
          pickedProfileImage = File((rotatedImage.path) ?? "");
          final bytes = pickedProfileImage?.readAsBytesSync();
          String img64 = base64Encode(bytes!);
          widget.addImageCallback!(img64, AppConstant.profileImage);
        } else {
          // bannerFromNetwork = false;
          pickedBannerImage = File(rotatedImage?.path ?? "");
          final bytes = pickedBannerImage?.readAsBytesSync();
          String img64 = base64Encode(bytes!);
          widget.addImageCallback!(img64, AppConstant.userBannerImage);
        }
      });
    }
  }

  void _openGallery(BuildContext context, bool uploadProfile, bool isLoading) async {
    final XFile? image =
    await _picker.pickImage(
        source: ImageSource.gallery,
      maxWidth: uploadProfile ? 500 : 900,
      maxHeight: uploadProfile ? 500 : 600,
      imageQuality: 60
    );

    setState(() {
      if (uploadProfile) {
        pickedProfileImage =
            File(image?.path ?? "");
        final bytes = pickedProfileImage
            ?.readAsBytesSync();
        String img64 =
        base64Encode(bytes!);
        widget.addImageCallback!(img64,
            AppConstant.profileImage);
      } else {
        pickedBannerImage =
            File(image?.path ?? "");
        final bytes = pickedBannerImage
            ?.readAsBytesSync();
        String img64 =
        base64Encode(bytes!);
        widget.addImageCallback!(img64,
            AppConstant.userBannerImage);
      }

      // Navigator.of(context).pop();
    });
  }

  Widget optionTile(String title, VoidCallback? addAction) {
    return GestureDetector(
      onTap: addAction,
      child: SizedBox(
          height: AppSizes.itemHeight,
          width: AppSizes.deviceWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Divider()
            ],
          )),
    );
  }
}
