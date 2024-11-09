

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/constants/app_routes.dart';
import 'package:test_new/unvells/screens/profile/views/profile_menu.dart';
import '../../app_widgets/app_alert_message.dart';
import '../../app_widgets/app_bar.dart';
import '../../app_widgets/dialog_helper.dart';
import '../../app_widgets/loader.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_string_constant.dart';
import '../../helper/app_localizations.dart';
import '../../helper/app_storage_pref.dart';
import '../../helper/utils.dart';
import '../../models/account_info/account_info_model.dart';
import '../../models/base_model.dart';
import 'bloc/profile_screen_bloc.dart';
import 'bloc/profile_screen_events.dart';
import 'bloc/profile_screen_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _profileState();
  }
}

class _profileState extends State<ProfileScreen> {
  bool isUserLogin = false;
  ProfileScreenBloc? profileScreenBloc;
  bool isLoading = false;
  BaseModel? model;
  AccountInfoModel? imageModel;
  bool isDarkMode = false;

  @override
  void initState() {
    profileScreenBloc = context.read<ProfileScreenBloc>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        Utils.getStringValue(context, AppStringConstant.account),
        context,
      ),
      body: BlocBuilder<ProfileScreenBloc, ProfileScreenState>(
          builder: (context, currentState) {
        if (currentState is LoadingState) {
          isLoading = true;
        } else if (currentState is LogOutSuccess) {
          isLoading = false;
          model = currentState.baseModel;
          appStoragePref.logoutUser();
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showSuccess(
                currentState.baseModel?.message != ''
                    ? currentState.baseModel?.message ?? ''
                    : Utils.getStringValue(
                        context, AppStringConstant.logOutMessage),
                context);
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.splash, (route) => false);
          });
        } else if (currentState is AddImageState) {
          isLoading = false;
          imageModel = currentState.model;
          if (currentState.model?.success ?? false) {
            var data = appStoragePref.getUserData();
            data?.profileImage = imageModel?.profileImage;
            data?.bannerImage = imageModel?.bannerImage;
            appStoragePref.setUserData(data);
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showSuccess(
                  currentState.model?.message ?? '', context);
            });
          } else {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(
                  currentState.model?.message ?? '', context);
            });
          }
        } else if (currentState is ProfileScreenError) {
          isLoading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showError(currentState.message ?? '', context);
          });
        }

        return buildUI();
      }),
    );
  }

  Widget buildUI() {
    return SingleChildScrollView(
      // physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Stack(children: [
            profileMenu(
                () {
                  profileScreenBloc?.add(LogOutDataFetchEvent());
                },
                AppLocalizations.of(context),
                () {
                  setState(() {});
                }),
            Visibility(visible: isLoading, child: const Loader())
          ]),
          const SizedBox(height: 15),
          if (appStoragePref.isLoggedIn())
            Padding(
              padding:  EdgeInsets.only(bottom: AppSizes.deviceHeight*.2),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    DialogHelper.confirmationDialog(
                      Utils.getStringValue(
                          context, AppStringConstant.logoutDescription),
                      context,
                      AppLocalizations.of(context),
                      title: Utils.getStringValue(
                          context, AppStringConstant.logoutTitle),
                      onConfirm: () {
                        profileScreenBloc?.add(LogOutDataFetchEvent());
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.logout,
                        color: Colors.redAccent,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        Utils.getStringValue(context, AppStringConstant.signOut)
                            .toUpperCase(),
                        style: KTextStyle.of(context)
                            .boldTwelve
                            .copyWith(color: Colors.redAccent),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          // const SizedBox(
          //   height: 100,
          // )
        ],
      ),
    );
  }
}
