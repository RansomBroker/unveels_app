import 'dart:developer';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:test_new/unvells/app_widgets/app_dialog_helper.dart';
import 'package:test_new/unvells/app_widgets/app_text_field.dart';
import 'package:test_new/unvells/app_widgets/custom_button.dart';
import 'package:test_new/unvells/app_widgets/flux_image.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/constants/app_routes.dart';
import 'package:test_new/unvells/helper/app_storage_pref.dart';
import '../../../app_widgets/app_alert_message.dart';
import '../../../app_widgets/app_bar.dart';
import '../../../app_widgets/app_outlined_button.dart';
import '../../../app_widgets/dialog_helper.dart';
import '../../../app_widgets/loader.dart';
import '../../../app_widgets/old_text_field.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_string_constant.dart';
import '../../../helper/app_localizations.dart';
import '../../../helper/utils.dart';
import '../../../models/dashboard/UserDataModel.dart';
import '../../../models/login_signup/login_response_model.dart';
import '../../login_signup/bloc/signin_signup_screen_bloc.dart';
import '../bloc/signin_signup_screen_repository.dart';
import 'create_account_screen.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen(this.isComingFromCartPage, {Key? key}) : super(key: key);
  final bool isComingFromCartPage;

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController _emailController, _passwordController;
  AuthBloc? bloc;
  late bool _obscureText, _loading;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _emailController = TextEditingController(text: kDebugMode ? AppConstant.demoEmail : '');
    _passwordController = TextEditingController(text: kDebugMode ? AppConstant.demoPassword : "");
    bloc = context.read<AuthBloc>();
    _loading = false;
    _formKey = GlobalKey();
    super.initState();
  }

  void _validateForm() async {
    if (kDebugMode) {
      print('Logging in...');
    }
    if (_formKey.currentState?.validate() == true) {
      Utils.hideSoftKeyBoard();
      bloc?.add(LoginEvent(_emailController.text.trim(), _passwordController.text));
      bloc?.emit(LoadingState());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, SigninSignupScreenState>(
      builder: (context, state) {
        if (state is LoadingState) {
          _loading = true;
        } else if (state is ForgotPasswordState) {
          _loading = false;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AlertMessage.showSuccess(state.data.message ?? "", context);
          });
        } else if (state is LoginState) {
          _loading = false;
          var model = state.data;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            updateUserPreference(model);
            checkFingerprint();
            AlertMessage.showSuccess(model.message ?? "", context);
          });
          bloc?.add(const GetCustomerCartEvent());
        } else if (state is SigninSignupScreenError) {
          _loading = false;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AlertMessage.showError(state.message ?? "", context);
          });
        }
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: <Widget>[
              _buildContent(),
              Visibility(
                visible: _loading,
                child: const Loader(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContent() {
    return Stack(
      children: [
        const SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: FluxImage(
              imageUrl: "assets/images/login_bg.png",
              fit: BoxFit.cover,
            )),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(backgroundColor: Colors.transparent),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 50),
                    const Center(
                      child: FluxImage(imageUrl: AppImages.loginLogo),
                    ),
                    const SizedBox(height: 44),
                    Text(
                      Utils.getStringValue(context, AppStringConstant.login),
                      style: KTextStyle.of(context).bold32,
                    ),
                    const SizedBox(height: 27),
                    OldAppTextField(
                      controller: _emailController,
                      isRequired: true,
                      isPassword: false,
                      validationType: AppStringConstant.email,
                      inputType: TextInputType.emailAddress,
                      hintText: Utils.getStringValue(context, AppStringConstant.emailAddress),
                    ),
                    const SizedBox(height: AppSizes.size24),
                    OldAppTextField(
                      controller: _passwordController,
                      isRequired: true,
                      isPassword: true,
                      validationType: AppStringConstant.password,
                      hintText: Utils.getStringValue(context, AppStringConstant.password),
                    ),
                    const SizedBox(height: AppSizes.size30),

                    /** Forgot password **/
                    GestureDetector(
                      child: Text(
                        Utils.getStringValue(context, AppStringConstant.forgotPassword),
                        style: KTextStyle.of(context).sixteen.copyWith(color: const Color(0xffFF0000)),
                      ),
                      onTap: () {
                        DialogHelper.forgotPasswordDialog(
                          context,
                          AppLocalizations.of(context),
                          Utils.getStringValue(context, AppStringConstant.forgotPasswordTitle),
                          Utils.getStringValue(context, AppStringConstant.forgotPasswordMessage),
                          _emailController.text,
                          onConfirm: (email) {
                            bloc?.add(ForgotPasswordEvent(email));
                            bloc?.emit(LoadingState());
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 48),
                    SizedBox(
                      child: CustomButton(
                        onPressed: () {
                          _validateForm();
                        },
                        title: Utils.getStringValue(context, AppStringConstant.signIn).toUpperCase(),
                      ),
                    ),
                    const SizedBox(height: AppSizes.size10),

                    /** Create account **/
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => AuthBloc(repository: SigninSignupScreenRepositoryImp()),
                                child: CreateAnAccount(false),
                              ),
                            ),
                          );
                        },
                        child: Text(
                          Utils.getStringValue(context, AppStringConstant.createAnAccount).toUpperCase(),
                          style: KTextStyle.of(context).boldSixteen,
                        ),
                      ),
                    ),

                    // // Social login buttons
                    // const SizedBox(height: AppSizes.size20),
                    // Center(
                    //   child: Text(
                    //     'Sign in with',
                    //     style: KTextStyle.of(context).boldSixteen,
                    //   ),
                    // ),
                    // const SizedBox(height: AppSizes.size20),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //     _buildSocialButton(
                    //       iconPath: 'assets/images/google_icon.png',
                    //       onTap: () => _socialLogin(SocialLogins.google),
                    //     ),
                    //     _buildSocialButton(
                    //       iconPath: 'assets/images/facebook_icon.png',
                    //       onTap: () => _socialLogin(SocialLogins.facebook),
                    //     ),
                    //     _buildSocialButton(
                    //       iconPath: 'assets/images/apple_icon.png',
                    //       onTap: () => _socialLogin(SocialLogins.apple),
                    //     ),
                    //   ],
                    // ),

                    const SizedBox(height: AppSizes.size16),
                    if ((appStoragePref.getFingerPrintUser() ?? "").isNotEmpty)
                      Center(
                        child: InkWell(
                          child: Lottie.asset(
                            AppImages.fingerPrintLottie,
                            width: AppSizes.deviceWidth / 6,
                            height: AppSizes.deviceWidth / 6,
                            fit: BoxFit.fill,
                            repeat: true,
                          ),
                          onTap: () {
                            startAuthentication(false);
                          },
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton({required String iconPath, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        iconPath,
        width: 48, // Adjust size as necessary
        height: 48,
      ),
    );
  }

  void _socialLogin(SocialLogins loginType) async {
    try {
      // var socialLoginRequest = SocialLoginModel(/* Fill with required fields */);

      if(loginType==SocialLogins.google){
        bloc?.add(const GoogleSignInEvent());

      }else{
        bloc?.add(const AppleSignInEvent());

      }

      // Handle loading state here if needed
      bloc?.emit(LoadingState());
    } catch (e) {
      AlertMessage.showError(e.toString(), context);
    }
  }

  //==========Update Session==========//
  void updateUserPreference(LoginResponseModel model) {
    appStoragePref.setIsLoggedIn(true);
    appStoragePref.setCustomerToken(model.customerToken);
    appStoragePref.setBearerToken(model.bearerToken);
    appStoragePref.setQuoteId(0);

    appStoragePref.setUserData(UserDataModel(
      isEmailVerified: true,
      customerId: model.customerId,
      name: model.customerName,
      email: model.customerEmail,
      bannerImage: model.bannerImage,
      profileImage: model.profileImage,
      cartCount: model.cartCount,
    ));
  }

  /// ================Handle Fingerprint Login==============
  final LocalAuthentication auth = LocalAuthentication(); //----Initialization
  void checkFingerprint() {
    auth.isDeviceSupported().then((value) {
      debugPrint('isDeviceSupported: ${value}');
      if (value &&
          ((appStoragePref.getFingerPrintUser() ?? "").isEmpty ||
              (_emailController.text ?? "").toString() !=
                  (appStoragePref.getFingerPrintUser() ?? ""))) {
        showFingerprintDialog();
      } else {
        if (widget.isComingFromCartPage == true) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRoutes.cart, (route) => false);
        } else {
          Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.bottomTabBar, (route) => false);
        }
      }
    });
  }

  void showFingerprintDialog() async {
    DialogHelper.forgotPasswordDialog(
        context,
        AppLocalizations.of(context),
        Utils.getStringValue(context, AppStringConstant.fingerprintLogin),
        Utils.getStringValue(context, AppStringConstant.fingerprintMessage),
        _emailController.text, onConfirm: (data) {
      startAuthentication(true);
    }, onCancel: (value) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(AppRoutes.bottomTabBar, (route) => false);
    }, isForgotPassword: false);
  }

  void startAuthentication(bool alreadyLogin) async {
    auth.isDeviceSupported().then((value) async {
      if (value) {
        bool didAuthenticate = await auth.authenticate(
          localizedReason: Utils.getStringValue(
              context, AppStringConstant.fingerprintLogin) ??
              '',
        );
        if (didAuthenticate) {
          if (alreadyLogin) {
            appStoragePref.setFingerPrintUser(_emailController.text);
            appStoragePref.setFingerPrintPassword(_passwordController.text);

            Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.bottomTabBar, (route) => false);
          } else {
            bloc?.add(LoginEvent(appStoragePref.getFingerPrintUser() ?? "",
                appStoragePref.getFingerPrintPassword() ?? ""));
            bloc?.emit(LoadingState());
          }
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AlertMessage.showError(
                Utils.getStringValue(
                    context, AppStringConstant.authenticationFailed) ??
                    '',
                context);
          });
        }
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          AlertMessage.showError(
              Utils.getStringValue(
                  context, AppStringConstant.authenticationFailed) ??
                  '',
              context);
        });
      }
    });
  }
}
