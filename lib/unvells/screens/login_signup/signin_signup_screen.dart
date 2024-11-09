/*
 *
  

 *
 * /
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/app_widgets/app_bar.dart';
import 'package:test_new/unvells/app_widgets/app_outlined_button.dart';
import 'package:test_new/unvells/app_widgets/custom_button.dart';
import 'package:test_new/unvells/app_widgets/flux_image.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/bottom_sheet_helper.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:test_new/unvells/screens/login_signup/view/create_account_screen.dart';
import 'package:test_new/unvells/screens/login_signup/view/signin_screen.dart';
import 'package:video_player/video_player.dart';

import '../../app_widgets/app_alert_message.dart';
import '../../app_widgets/loader.dart';
import '../../constants/app_routes.dart';
import '../../helper/app_storage_pref.dart';
import '../../helper/navigation_helper.dart';
import '../../models/dashboard/UserDataModel.dart';
import 'bloc/signin_signup_screen_bloc.dart';
import 'bloc/signin_signup_screen_repository.dart';

class SignInSignUpScreen extends StatefulWidget {
  const SignInSignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignInSignUpScreen> createState() => _SignInSignUpScreenState();
}

class _SignInSignUpScreenState extends State<SignInSignUpScreen> {
  AuthBloc? bloc;
  late bool _loading;
  late VideoPlayerController _controller;
  bool _buttonReady = false;

  @override
  void initState() {
    _controller = VideoPlayerController.asset(
      AppImages.splashBgVideo,
    )..initialize().then((_) {
        _controller.play();
        // setState(() {});
      });
    bloc = context.read<AuthBloc>();
    _loading = false;
    Future.delayed(const Duration(seconds: 4)).then((value) {
      setState(() {});
      return _buttonReady = true;
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Opacity(opacity: .6, child: VideoPlayer(_controller)),
        _buildContent(),
      ],
    );
  }

  Widget _buildContent() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // appBar: commonAppBar(Utils.getStringValue(context, AppStringConstant.signInRegister), context),
      // appBar: commonAppBar(
      //     Utils.getStringValue(context, AppStringConstant.signInRegister),
      //     context,
      //     isLeadingEnable: false),

      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: AppSizes.paddingMedium, horizontal: 24),
        child: SafeArea(
          child: _buildUI(),
        ),
      ),
    );
  }

  Widget _buildUI() {
    // Future.delayed(const Duration(milliseconds: 500), () {
    //   if(widget.isFromCartForLogin){
    //     _openBottomModalSheet(ModalType.signin);
    //   }
    //
    //   if(widget.isFromCartForSignup){
    //     _openBottomModalSheet(ModalType.createAccount);
    //   }
    // });
    return Stack(
      children: <Widget>[
        Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            const Center(
                child: FluxImage(imageUrl: "assets/images/splashlogo.svg")),
            // Expanded(
            //     child: Center(
            //   child: Text(
            //     Utils.getStringValue(context, AppStringConstant.appName),
            //     style: Theme.of(context).textTheme.headline1,
            //   ),
            // )),
            // Padding(
            //   padding:
            //       const EdgeInsets.symmetric(vertical: AppSizes.spacingLarge),
            //   child: Text(
            //     Utils.getStringValue(context, AppStringConstant.signInRegister),
            //     style: Theme.of(context)
            //         .textTheme
            //         .titleSmall
            //         ?.copyWith(fontSize: AppSizes.paddingMedium),
            //   ),
            // ),
            const Spacer(),
            if (_buttonReady) ...[
              CustomButton(
                onPressed: () {
                  _controller.pause();

                  return NavigationHelper.navigateToLogin(context);
                },
                // signInSignUpBottomModalSheet(context, false, false);
                textColor: AppColors.gold,
                title: Utils.getStringValue(context, AppStringConstant.login)
                    .toUpperCase(),
                kFillColor: Colors.white,
              ),
              const SizedBox(height: AppSizes.paddingNormal),
              TextButton(
                  onPressed: () {
                    _controller.pause();
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.bottomTabBar, (route) => false);
                  },
                  child: Text(
                    Utils.getStringValue(
                        context, AppStringConstant.continueAsGuest),
                    style: KTextStyle.of(context)
                        .boldSixteen
                        .copyWith(color: Colors.white),
                  )),
            ],
            // Utils.getStringValue(
            //     context, AppStringConstant.createAnAccount)),
            const SizedBox(height: AppSizes.spacingLarge),
          ],
        ),
        Visibility(
          visible: _loading,
          child: const Loader(),
        ),
      ],
    );
  }
}
