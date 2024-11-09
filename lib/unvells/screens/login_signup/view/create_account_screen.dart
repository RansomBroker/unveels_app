/*
 *
  

 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/app_widgets/app_date_picker.dart';
import 'package:test_new/unvells/app_widgets/app_outlined_button.dart';
import 'package:test_new/unvells/app_widgets/custom_button.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/constants/app_routes.dart';
import 'package:test_new/unvells/helper/app_storage_pref.dart';
import '../../../app_widgets/app_alert_message.dart';
import '../../../app_widgets/app_bar.dart';
import '../../../app_widgets/app_text_field.dart';
import '../../../app_widgets/flux_image.dart';
import '../../../app_widgets/loader.dart';
import '../../../constants/app_string_constant.dart';
import '../../../helper/bottom_sheet_helper.dart';
import '../../../helper/utils.dart';
import '../../../helper/validator.dart';
import '../../../models/dashboard/UserDataModel.dart';
import '../../../models/login_signup/sign_up_screen_model.dart';
import '../../login_signup/bloc/signin_signup_screen_bloc.dart';

class CreateAnAccount extends StatefulWidget {
  CreateAnAccount(this.isComingFromCartPage, {Key? key}) : super(key: key);
  final bool isComingFromCartPage;

  @override
  _CreateAnAccountState createState() => _CreateAnAccountState();
}

class _CreateAnAccountState extends State<CreateAnAccount> {
  AuthBloc? bloc;

  SignUpScreenModel? _signUpScreenModel;

  final TextEditingController _namePrefixController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _nameSuffixController = TextEditingController();
  final TextEditingController _taxVatNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final TextEditingController _dobController = TextEditingController();
  late FocusNode _passwordFocusNode,
      _firstnameFocusNode,
      _lastnameFocusNode,
      _emailFocusNode,
      _confirmPasswordFocusNode,
      _telephoneFocusNode;

  late bool _loading = true;
  String isNewsletter = "0";
  bool isPrivacyAccepted = false;
  late GlobalKey<FormState> _formKey;
  String? emailErrorMessage;

  List<String> genderOption = ["Male", "Female"];

  void _validateForm() async {
    if (_formKey.currentState?.validate() == true) {
      Utils.hideSoftKeyBoard();
      bloc?.add(SignUpEvent(
        (_signUpScreenModel?.prefixHasOptions ?? false)
            ? _signUpScreenModel?.prefix ?? ""
            : _namePrefixController.text,
        _firstNameController.text,
        _middleNameController.text,
        _lastNameController.text,
        (_signUpScreenModel?.suffixHasOptions ?? false)
            ? _signUpScreenModel?.suffix ?? ""
            : _nameSuffixController.text,
        _dobController.text,
        _taxVatNumberController.text,
        _signUpScreenModel?.gender ?? "",
        _emailController.text,
        _passwordController.text,
        _telephoneController.text,
      ));
      bloc?.emit(LoadingState());
    } else {
      _focusErrorNode();
    }
  }

  void _focusErrorNode() {
    if (_firstNameController.text.isEmpty) {
      FocusScope.of(context).requestFocus(_firstnameFocusNode);
    } else if (_lastNameController.text.isEmpty) {
      FocusScope.of(context).requestFocus(_lastnameFocusNode);
    } else if (_emailController.text.isEmpty) {
      FocusScope.of(context).requestFocus(_emailFocusNode);
    } else if (_telephoneController.text.isEmpty && emailErrorMessage != null) {
      FocusScope.of(context).requestFocus(_telephoneFocusNode);
    } else if (_passwordController.text.isEmpty) {
      FocusScope.of(context).requestFocus(_passwordFocusNode);
    } else if (_confirmPasswordController.text.isEmpty ||
        _confirmPasswordController.text != _passwordController.text) {
      FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _loading = false;
    _formKey = GlobalKey();
    bloc = context.read<AuthBloc>();
    bloc?.add(const SignupScreenFormDataEvent());

    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _lastnameFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
    _firstnameFocusNode = FocusNode();
    _telephoneFocusNode = FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, SigninSignupScreenState>(
      builder: (context, state) {
        print(state);
        if (state is LoadingState) {
          _loading = true;
        } else if (state is SigninSignupScreenError) {
          _loading = false;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AlertMessage.showError(state.message ?? "", context);
          });
        } else if (state is SignupScreenFormDataState) {
          _loading = false;
          _signUpScreenModel = state.data;
        } else if (state is SignupScreenFormSuccess) {
          _loading = false;
          var model = state.data;
          bloc?.add(const GetCustomerCartEvent());

          WidgetsBinding.instance.addPostFrameCallback((_) {
            AlertMessage.showSuccess(model.message ?? "", context);
            appStoragePref.setIsLoggedIn(model.success);
            appStoragePref.setCustomerToken(model.customerToken);
            appStoragePref.setBearerToken(model.bearerToken);
            appStoragePref.setQuoteId(0);
            appStoragePref.setUserData(UserDataModel(
                cartCount: model.cartCount,
                name: model.customerName,
                email: model.customerEmail,
                bannerImage: model.bannerImage,
                profileImage: model.profileImage));
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.bottomTabBar, (route) => false);
          });
        }
        return Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          body: Stack(
            children: <Widget>[
              _buildContent(),
              Visibility(
                visible: _loading,
                child: const Loader(),
              ),
            ],
          )
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
          appBar: commonAppBar(
              Utils.getStringValue(context, AppStringConstant.createAnAccount),
              context,
              isLeadingEnable: true, onPressed: () {
            Navigator.pop(context);
          }),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24,),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: AppSizes.size34,
                    ),

                    Text(
                      Utils.getStringValue(
                          context, AppStringConstant.createAnAccount),
                      style: KTextStyle.of(context).bold32,
                    ),

                    /// user account details

                    /// Name prefix selection
                    if ((_signUpScreenModel?.isPrefixVisible ?? false) &&
                        (_signUpScreenModel?.prefixHasOptions ?? false))
                      Column(
                        children: [
                          const SizedBox(
                            height: AppSizes.size16,
                          ),
                          DropdownButtonFormField<String>(
                            elevation: 0,
                            menuMaxHeight: AppSizes.deviceHeight / 2,
                            decoration: formFieldDecoration(
                                context,
                                "",
                                Utils.getStringValue(
                                    context, AppStringConstant.namePrefix),
                                isDense: true,
                                isRequired: true),
                            items: (_signUpScreenModel?.prefixOptions ?? [])
                                .map((String optionData) {
                              return DropdownMenuItem(
                                value: optionData,
                                child: Text(
                                  optionData ?? "",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              // this will call once the value changes
                              _signUpScreenModel?.prefix = value.toString();
                              setState(() {});
                            },
                            validator: (value) {
                              if (value == null) {
                                if ((_signUpScreenModel?.isPrefixVisible ??
                                        false) &&
                                    (_signUpScreenModel?.prefixHasOptions ??
                                        false) &&
                                    (_signUpScreenModel?.isPrefixRequired ??
                                        false)) {
                                  return Utils.getStringValue(
                                      context, AppStringConstant.required);
                                }
                                // add validation with return statement
                              }
                            },
                          ),
                        ],
                      ),

                    /// Name prefix custom
                    if ((_signUpScreenModel?.isPrefixVisible ?? false) &&
                        !(_signUpScreenModel?.prefixHasOptions ?? false))
                      Column(

                        children: [
                          const SizedBox(height: AppSizes.size16),
                          AppTextField(
                            controller: _namePrefixController,
                            isRequired:
                                _signUpScreenModel?.isPrefixRequired ?? false,
                            isPassword: false,
                            hintText: Utils.getStringValue(
                                context, AppStringConstant.namePrefix),
                            inputType: TextInputType.name,
                          ),
                        ],
                      ),

                    /// First name
                    const SizedBox(height: AppSizes.size16),
                    Row(
                      children: [
                        Expanded(
                          child: AppTextField(
                            focusNode: _firstnameFocusNode,
                            controller: _firstNameController,
                            isRequired: true,
                            isPassword: false,
                            hintText: Utils.getStringValue(
                                context, AppStringConstant.firstName),
                            inputType: TextInputType.name,
                          ),
                        ),
                        const SizedBox(width: AppSizes.size16),

                        Expanded(
                          child: AppTextField(
                            focusNode: _lastnameFocusNode,
                            controller: _lastNameController,
                            isRequired: true,
                            isPassword: false,
                            hintText: Utils.getStringValue(
                                context, AppStringConstant.lastName),
                            inputType: TextInputType.name,
                          ),
                        ),
                      ],
                    ),

                    ///Middle name
                    if (_signUpScreenModel?.isMiddlenameVisible ?? false)
                      Column(
                        children: [
                          const SizedBox(height: AppSizes.size16),
                          AppTextField(
                            controller: _middleNameController,
                            isRequired: false,
                            isPassword: false,
                            hintText: Utils.getStringValue(
                                context, AppStringConstant.middleName),
                            inputType: TextInputType.name,
                          ),
                        ],
                      ),

                    /// Last name
                    const SizedBox(height: AppSizes.size16),

                    /// Name suffix selection
                    if ((_signUpScreenModel?.isSuffixVisible ?? false) &&
                        (_signUpScreenModel?.suffixHasOptions ?? false))
                      Column(
                        children: [
                          const SizedBox(height: AppSizes.size16),
                          DropdownButtonFormField<String>(
                            elevation: 0,
                            menuMaxHeight: AppSizes.deviceHeight / 2,
                            decoration: formFieldDecoration(
                                context,
                                "",
                                Utils.getStringValue(
                                    context, AppStringConstant.nameSuffix),
                                isDense: true,
                                isRequired: true),
                            items: (_signUpScreenModel?.suffixOptions ?? [])
                                .map((String optionData) {
                              return DropdownMenuItem(
                                value: optionData,
                                child: Text(
                                  optionData ?? "",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              // this will call once the value changes
                              _signUpScreenModel?.suffix =
                                  value.toString() ?? "";
                              setState(() {});
                            },
                            validator: (value) {
                              if (value == null) {
                                if ((_signUpScreenModel?.isSuffixVisible ??
                                        false) &&
                                    (_signUpScreenModel?.suffixHasOptions ??
                                        false) &&
                                    (_signUpScreenModel?.isSuffixRequired ??
                                        false)) {
                                  return Utils.getStringValue(
                                      context, AppStringConstant.required);
                                }
                                // add validation with return statement
                              }
                            },
                          ),
                        ],
                      ),

                    /// Name suffix custom
                    if ((_signUpScreenModel?.isSuffixVisible ?? false) &&
                        !(_signUpScreenModel?.suffixHasOptions ?? false))
                      Column(
                        children: [
                          const SizedBox(height: AppSizes.size16),
                          AppTextField(
                            controller: _nameSuffixController,
                            isRequired:
                                _signUpScreenModel?.isSuffixRequired ?? false,
                            isPassword: false,
                            hintText: Utils.getStringValue(
                                context, AppStringConstant.nameSuffix),
                            inputType: TextInputType.name,
                          ),
                        ],
                      ),

                    /// Date of Birth
                    if ((_signUpScreenModel?.isDOBVisible ?? false))
                      Column(
                        children: [
                          const SizedBox(height: AppSizes.size16),
                          AppDatePicker(
                            controller: _dobController,
                            isRequired:
                                _signUpScreenModel?.isDOBRequired ?? false,
                            isPassword: false,
                            hintText: Utils.getStringValue(
                                context, AppStringConstant.dob),
                            inputType: TextInputType.name,
                          ),
                        ],
                      ),

                    /// Tax/VAT number
                    if ((_signUpScreenModel?.isTaxVisible ?? false))
                      Column(
                        children: [
                          const SizedBox(height: AppSizes.size16),
                          AppTextField(
                            controller: _taxVatNumberController,
                            isPassword: false,
                            hintText: Utils.getStringValue(
                                context, AppStringConstant.taxVatNumber),
                            isRequired:
                                _signUpScreenModel?.isTaxRequired ?? false,
                            inputType: TextInputType.number,
                          ),
                        ],
                      ),

                    /// Gender
                    if ((_signUpScreenModel?.isGenderVisible ?? false))
                      Column(
                        children: [
                          const SizedBox(height: AppSizes.size16),
                          DropdownButtonFormField<String>(
                            elevation: 0,
                            menuMaxHeight: AppSizes.deviceHeight / 2,
                            decoration: formFieldDecoration(
                                context,
                                "",
                                Utils.getStringValue(
                                    context, AppStringConstant.gender),
                                isDense: true,
                                isRequired: true),
                            items:
                                (genderOption ?? []).map((String optionData) {
                              return DropdownMenuItem(
                                value: optionData,
                                child: Text(
                                  optionData ?? "",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              // this will call once the value changes
                              _signUpScreenModel?.gender = value;
                              setState(() {});
                            },
                            validator: (value) {
                              if (value == null) {
                                if ((_signUpScreenModel?.isGenderVisible ??
                                        false) &&
                                    (_signUpScreenModel?.isGenderRequired ??
                                        false)) {
                                  return Utils.getStringValue(
                                      context, AppStringConstant.required);
                                }
                              }
                            },
                          ),
                        ],
                      ),

                    /// Email address
                    const SizedBox(height: AppSizes.size16),
                    TextFormField(
                      focusNode: _emailFocusNode,
                      controller: _emailController,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: formFieldDecoration(
                          context,
                          "",
                          Utils.getStringValue(
                              context, AppStringConstant.emailAddress),
                          isRequired: true),
                      autovalidateMode: (_emailController.text.isNotEmpty)
                          ? AutovalidateMode.always
                          : AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        return Validator.isEmailValid(value ?? '', context);
                      },
                      onChanged: (value) async {
                        if (Validator.isEmailValid(value, context) == null) {
                          // bloc?.add(CheckEmailEvent(value, await appStoragePref.getCustomerToken()));
                        } else {
                          emailErrorMessage = null;
                        }
                      },
                    ),
                    if (emailErrorMessage != null)
                      Padding(
                        padding: const EdgeInsets.all(AppSizes.size4),
                        child: Text(
                          emailErrorMessage!,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColors.red),
                        ),
                      ),

                    /// Mobile
                    if ((_signUpScreenModel?.isMobileVisible ?? false))
                      Column(
                        children: [
                          const SizedBox(height: AppSizes.size16),
                          AppTextField(
                            focusNode: _telephoneFocusNode,
                            controller: _telephoneController,
                            isPassword: false,
                            hintText: Utils.getStringValue(
                                context, AppStringConstant.telephone),
                            isRequired:
                                _signUpScreenModel?.isMobileRequired ?? false,
                            inputType: TextInputType.phone,
                          ),
                        ],
                      ),

                    /// Password
                    const SizedBox(height: AppSizes.size16),
                    AppTextField(
                      focusNode: _passwordFocusNode,
                      hintText: Utils.getStringValue(
                          context, AppStringConstant.password),
                      controller: _passwordController,
                      isRequired: true,
                      isPassword: true,
                      inputType: TextInputType.visiblePassword,
                      validationType: AppStringConstant.password,
                      validation: (value) {
                        if (_passwordController.text.toString().trim().length <
                            8) {
                          return Utils.getStringValue(context,
                              AppStringConstant.passwordValidationMessage);
                        } else {
                          return null;
                        }
                      },
                    ),

                    /// confirm Password
                    const SizedBox(height: AppSizes.size16),
                    AppTextField(
                      focusNode: _confirmPasswordFocusNode,
                      hintText: Utils.getStringValue(
                          context, AppStringConstant.confirmPassword),
                      controller: _confirmPasswordController,
                      isRequired: true,
                      isPassword: true,
                      inputType: TextInputType.visiblePassword,
                      validation: (value) {
                        if (_confirmPasswordController.text !=
                            _passwordController.text) {
                          return Utils.getStringValue(
                              context, AppStringConstant.passwordMismatch);
                        } else {
                          return null;
                        }
                      },
                    ),

                    const SizedBox(height: AppSizes.size10),
                    Text(
                      Utils.getStringValue(
                          context, AppStringConstant.passwordValidationMessage),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w300,
                            fontSize: AppSizes.textSizeSmall,
                          ),
                    ),

                    /// Create account
                    const SizedBox(height: AppSizes.size34*1.5),
                    CustomButton(
                      title: Utils.getStringValue(
                              context, AppStringConstant.createAnAccount)
                          .toUpperCase(),
                      onPressed: () => _validateForm(),
                    ),
                    // SizedBox(
                    //   height: 48,
                    //   child: ElevatedButton(
                    //     onPressed: () => _validateForm(),
                    //     child: Center(
                    //         child: Text(
                    //       Utils.getStringValue(
                    //               context, AppStringConstant.createAnAccount)
                    //           .toUpperCase(),
                    //       style: const TextStyle(color: AppColors.white),
                    //     )),
                    //   ),
                    // ),

                    /// login with existing account
                    const SizedBox(height: AppSizes.size16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            Utils.getStringValue(
                                context, AppStringConstant.alreadyHaveAccount),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    fontWeight: FontWeight.w400, fontSize: 13)),
                        const SizedBox(
                          width: 5.0,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            signInSignUpBottomModalSheet(context, false, false);
                          },
                          child: Text(
                            Utils.getStringValue(
                                    context, AppStringConstant.signIn)
                                .toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    color: AppColors.blue),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSizes.size16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
