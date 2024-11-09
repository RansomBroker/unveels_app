/*
 *


 *
 * /
 */

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/app_widgets/custom_button.dart';
import 'package:test_new/unvells/helper/app_storage_pref.dart';
import '../../app_widgets/app_alert_message.dart';
import '../../app_widgets/app_bar.dart';
import '../../app_widgets/app_date_picker.dart';
import '../../app_widgets/app_dialog_helper.dart';
import '../../app_widgets/app_outlined_button.dart';
import '../../app_widgets/app_switch_button.dart';
import '../../app_widgets/app_text_field.dart';
import '../../app_widgets/dialog_helper.dart';
import '../../app_widgets/loader.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_routes.dart';
import '../../constants/app_string_constant.dart';
import '../../helper/app_localizations.dart';
import '../../helper/generic_methods.dart';
import '../../helper/utils.dart';
import '../../helper/validator.dart';
import '../../models/account_info/account_info_model.dart';
import 'bloc/account_info_bloc.dart';
import 'bloc/account_info_events.dart';
import 'bloc/account_info_state.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({Key? key}) : super(key: key);

  @override
  _AccountInfoScreenState createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  bool changePassword = false;
  bool changeEmail = false;
  bool isLoading = false;
  bool isEmailVerified = false;
  final _formKey = GlobalKey<FormState>();
  final _deleteDialogFormKey = GlobalKey<FormState>();
  final TextEditingController _namePrefixController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _nameSuffixController = TextEditingController();
  final TextEditingController _taxVatNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _deletePasswordController =
      TextEditingController();
  AccountInfoBloc? _accountInfoBloc;
  AccountInfoModel? accountInfoModel;

  var userEmail = "";
  List<String> genderOption = ["Male", "Female"]; //test data

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _accountInfoBloc = context.read<AccountInfoBloc>();
    _accountInfoBloc?.add(const AccountDetailEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountInfoBloc, AccountInfoState>(
        builder: (BuildContext context, AccountInfoState currentState) {
      if (currentState is AccountInfoLoadingState) {
        isLoading = true;
      } else if (currentState is AccountDetailSuccessState) {
        isLoading = false;
        accountInfoModel = currentState.data;
        setUpFormData();
      } else if (currentState is SaveAccountSuccessState) {
        isLoading = false;
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          AlertMessage.showSuccess(currentState.data.message ?? '', context);
        });
        var data = appStoragePref.getUserData();
        data?.firstName = _firstNameController.text;
        data?.lastName = _lastNameController.text;
        data?.name = "${_firstNameController.text} ${_lastNameController.text}";
        data?.email = _emailController.text;
        appStoragePref.setUserData(data);
      } else if (currentState is DeleteAccountState) {
        isLoading = false;
        if (currentState.data.success ?? false) {
          appStoragePref.logoutUser();
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showSuccess(
                currentState.data?.message != ''
                    ? currentState.data?.message ?? ''
                    : Utils.getStringValue(
                        context, AppStringConstant.accountDeleted),
                context);
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.splash, (route) => false);
          });
        } else {
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showError(
                currentState.data.message ??
                    Utils.getStringValue(
                        context, AppStringConstant.somethingWentWrong),
                context);
          });
        }
      } else if (currentState is AccountInfoErrorState) {
        isLoading = false;
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          AlertMessage.showError(currentState.message ?? '', context);
          _accountInfoBloc?.emit(CompleteState());
        });
      } else if (currentState is CompleteState) {}
      return _buildUI();
    });
  }

  void setUpFormData() {
    _namePrefixController.text = accountInfoModel?.prefix ?? "";
    _namePrefixController.text = accountInfoModel?.prefix ?? "";
    _firstNameController.text = accountInfoModel?.firstName ?? "";
    _middleNameController.text = accountInfoModel?.middleName ?? "";
    _lastNameController.text = accountInfoModel?.lastName ?? "";
    _nameSuffixController.text = accountInfoModel?.suffix ?? "";
    _emailController.text = accountInfoModel?.email ?? "";
    _telephoneController.text = accountInfoModel?.telephone ?? "";
    _taxVatNumberController.text = accountInfoModel?.taxValue ?? "";
    _dobController.text = accountInfoModel?.DOBValue ?? "";
  }

  Widget _buildUI() {
    return Stack(
      children: <Widget>[
        _buildContent(),
        Visibility(visible: isLoading, child: const Loader())
      ],
    );
  }

  Widget _buildContent() {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: commonAppBar(
          Utils.getStringValue(context, AppStringConstant.accountInfo), context,
          isLeadingEnable: true, onPressed: () {
        Navigator.pop(context);
      }),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.size15),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /// user account details

                /// Name prefix selection
                if ((accountInfoModel?.isPrefixVisible ?? false) &&
                    (accountInfoModel?.prefixHasOptions ?? false))
                  Column(
                    children: [
                      const SizedBox(
                        height: AppSizes.size6,
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
                        items: (accountInfoModel?.prefixOptions ?? [])
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
                          accountInfoModel?.prefix = value.toString();
                          setState(() {});
                        },
                        validator: (value) {
                          if (value == null) {
                            if ((accountInfoModel?.isPrefixVisible ?? false) &&
                                (accountInfoModel?.prefixHasOptions ?? false) &&
                                (accountInfoModel?.isPrefixRequired ?? false))
                              return Utils.getStringValue(
                                  context, AppStringConstant.required);
                            // add validation with return statement
                          }
                        },
                      ),
                    ],
                  ),

                /// Name prefix custom
                if ((accountInfoModel?.isPrefixVisible ?? false) &&
                    !(accountInfoModel?.prefixHasOptions ?? false))
                  Column(
                    children: [
                      const SizedBox(height: AppSizes.size16),
                      AppTextField(
                        controller: _namePrefixController,
                        isRequired: accountInfoModel?.isPrefixRequired ?? false,
                        isPassword: false,
                        hintText: Utils.getStringValue(
                            context, AppStringConstant.namePrefix),
                        inputType: TextInputType.name,
                      ),
                    ],
                  ),

                /// First name
                const SizedBox(height: AppSizes.size16),
                AppTextField(
                  controller: _firstNameController,
                  isRequired: true,
                  isPassword: false,
                  hintText: Utils.getStringValue(
                      context, AppStringConstant.firstName),
                  inputType: TextInputType.name,
                ),

                ///Middle name
                if (accountInfoModel?.isMiddlenameVisible ?? false)
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
                AppTextField(
                  controller: _lastNameController,
                  isRequired: true,
                  isPassword: false,
                  hintText:
                      Utils.getStringValue(context, AppStringConstant.lastName),
                  inputType: TextInputType.name,
                ),

                /// Name suffix selection
                if ((accountInfoModel?.isSuffixVisible ?? false) &&
                    (accountInfoModel?.suffixHasOptions ?? false))
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
                        items: (accountInfoModel?.suffixOptions ?? [])
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
                          accountInfoModel?.suffix = value.toString() ?? "";
                          setState(() {});
                        },
                        validator: (value) {
                          if (value == null) {
                            if ((accountInfoModel?.isSuffixVisible ?? false) &&
                                (accountInfoModel?.suffixHasOptions ?? false) &&
                                (accountInfoModel?.isSuffixRequired ?? false))
                              return Utils.getStringValue(
                                  context, AppStringConstant.required);
                            // add validation with return statement
                          }
                        },
                      ),
                    ],
                  ),

                /// Name suffix custom
                if ((accountInfoModel?.isSuffixVisible ?? false) &&
                    !(accountInfoModel?.suffixHasOptions ?? false))
                  Column(
                    children: [
                      const SizedBox(height: AppSizes.size16),
                      AppTextField(
                        controller: _nameSuffixController,
                        isRequired: accountInfoModel?.isSuffixRequired ?? false,
                        isPassword: false,
                        hintText: Utils.getStringValue(
                            context, AppStringConstant.nameSuffix),
                        inputType: TextInputType.name,
                      ),
                    ],
                  ),

                /// Date of Birth
                if ((accountInfoModel?.isDOBVisible ?? false))
                  Column(
                    children: [
                      const SizedBox(height: AppSizes.size16),
                      AppDatePicker(
                        controller: _dobController,
                        isRequired: accountInfoModel?.isDOBRequired ?? false,
                        isPassword: false,
                        hintText: Utils.getStringValue(
                            context, AppStringConstant.dob),
                        inputType: TextInputType.name,
                      ),
                    ],
                  ),

                /// Tax/VAT number
                if ((accountInfoModel?.isTaxVisible ?? false))
                  Column(
                    children: [
                      const SizedBox(height: AppSizes.size16),
                      AppTextField(
                        controller: _taxVatNumberController,
                        isPassword: false,
                        hintText: Utils.getStringValue(
                            context, AppStringConstant.taxVatNumber),
                        isRequired: accountInfoModel?.isTaxRequired ?? false,
                        inputType: TextInputType.number,
                      ),
                    ],
                  ),

                /// Gender
                if ((accountInfoModel?.isGenderVisible ?? false))
                  Column(
                    children: [
                      const SizedBox(height: AppSizes.size16),
                      DropdownButtonFormField<String>(
                        elevation: 0,
                        menuMaxHeight: AppSizes.deviceHeight / 2,
                        hint: Text(
                          genderOption[int.parse(
                                  accountInfoModel?.genderValue ?? "0")] ??
                              Utils.getStringValue(
                                  context, AppStringConstant.gender),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        decoration: formFieldDecoration(
                            context,
                            "",
                            Utils.getStringValue(
                                context, AppStringConstant.gender),
                            isDense: true,
                            isRequired: true),
                        items: (genderOption ?? []).map((String optionData) {
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
                          accountInfoModel?.gender = value;
                          setState(() {});
                        },
                        validator: (value) {
                          if (value == null) {
                            if ((accountInfoModel?.isGenderVisible ?? false) &&
                                (accountInfoModel?.isGenderRequired ?? false))
                              return Utils.getStringValue(
                                  context, AppStringConstant.required);
                          }
                        },
                      ),
                    ],
                  ),

                /// Mobile
                if ((accountInfoModel?.isMobileVisible ?? false))
                  Column(
                    children: [
                      const SizedBox(height: AppSizes.size16),
                      AppTextField(
                        controller: _telephoneController,
                        isPassword: false,
                        hintText: Utils.getStringValue(
                            context, AppStringConstant.telephone),
                        isRequired: accountInfoModel?.isMobileRequired ?? false,
                        inputType: TextInputType.phone,
                      ),
                    ],
                  ),

                /// Email address
                const SizedBox(height: AppSizes.size16),
                AppSwitchButton(
                    Utils.getStringValue(
                        context, AppStringConstant.changeEmail), (value) {
                  setState(() {
                    changeEmail = value;
                  });
                }, changeEmail),

                if (changeEmail)
                  Column(
                    children: [
                      const SizedBox(height: AppSizes.size16),
                      AppTextField(
                        controller: _emailController,
                        isPassword: false,
                        hintText: Utils.getStringValue(
                            context, AppStringConstant.emailAddress),
                        isRequired: changeEmail,
                        validationType: AppStringConstant.email,
                        inputType: TextInputType.emailAddress,
                      ),
                    ],
                  ),

                /// Password
                const SizedBox(height: AppSizes.size16),
                AppSwitchButton(
                    Utils.getStringValue(
                        context, AppStringConstant.changePassword), (value) {
                  setState(() {
                    changePassword = value;
                    _passwordController.clear();
                    _newPasswordController.clear();
                    _confirmPasswordController.clear();
                  });
                }, changePassword),

                if (changeEmail || changePassword)
                  AppTextField(
                    hintText: Utils.getStringValue(
                        context, AppStringConstant.password),
                    controller: _passwordController,
                    isRequired: true,
                    isPassword: true,
                    inputType: TextInputType.visiblePassword,
                    validationType: AppStringConstant.password,
                  ),

                if (changePassword)
                  Column(
                    children: [
                      const SizedBox(height: AppSizes.size16),
                      AppTextField(
                        hintText: Utils.getStringValue(
                            context, AppStringConstant.newPassword),
                        controller: _newPasswordController,
                        isRequired: changePassword,
                        isPassword: true,
                        inputType: TextInputType.visiblePassword,
                        validationType: AppStringConstant.password,
                      ),
                      const SizedBox(height: AppSizes.size16),
                      AppTextField(
                        hintText: Utils.getStringValue(
                            context, AppStringConstant.confirmPassword),
                        controller: _confirmPasswordController,
                        isRequired: changePassword,
                        isPassword: true,
                        inputType: TextInputType.visiblePassword,
                        validationType: AppStringConstant.password,
                        validation: (value) {
                          if (_confirmPasswordController.text !=
                              _newPasswordController.text) {
                            return Utils.getStringValue(
                                context, AppStringConstant.passwordNotMatch);
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: AppSizes.size16),
                    ],
                  ),

                /// confirm Password
                // const SizedBox(height: AppSizes.size16),
                // AppTextField(
                //   hintText: Utils.getStringValue(context, AppStringConstant.confirmPassword),
                //   controller: _confirmPasswordController,
                //   isRequired: true,
                //   isPassword: true,
                //   inputType: TextInputType.visiblePassword,
                //   validation: (value) {
                //     if (_confirmPasswordController.text !=
                //         _passwordController.text) {
                //       return Utils.getStringValue(context, AppStringConstant.passwordMismatch);
                //     } else {
                //       return null;
                //     }
                //   },
                // ),

                /// save account
                const SizedBox(height: AppSizes.spacingNormal),
                SizedBox(
                  height: AppSizes.genericButtonHeight,
                  child: CustomButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() == true) {
                        _accountInfoBloc?.add(SaveAccountInfoEvent(
                            (accountInfoModel?.prefixHasOptions ?? false)
                                ? accountInfoModel?.prefix ?? ""
                                : _namePrefixController.text,
                            _firstNameController.text,
                            _middleNameController.text,
                            _lastNameController.text,
                            (accountInfoModel?.suffixHasOptions ?? false)
                                ? accountInfoModel?.suffix ?? ""
                                : _nameSuffixController.text,
                            _dobController.text,
                            _taxVatNumberController.text,
                            accountInfoModel?.genderValue ?? "",
                            _emailController.text,
                            _telephoneController.text,
                            _newPasswordController.text,
                            _passwordController.text,
                            _newPasswordController.text,
                            changeEmail ? 1 : 0,
                            changePassword ? 1 : 0));
                      }
                    },
                    title:
                        Utils.getStringValue(context, AppStringConstant.save),
                    // child: Center(
                    //   child: Text(
                    //
                    //         .toUpperCase(),
                    //     style: const TextStyle(color: Colors.white),
                    //   ),
                    // ),
                  ),
                ),
                const SizedBox(height: 5.0),

                /// Delete account
                const SizedBox(height: AppSizes.spacingGeneric),
                appOutlinedButton(
                  textColor: Colors.white,
                  context,
                  () async {
                    // if ((appStoragePref.getUserData()?.email ?? "") ==
                    //     AppConstant.demoEmail) {
                    //   AlertMessage.showError(
                    //       Utils.getStringValue(
                    //           context, AppStringConstant.cantDeleteDemoAccount),
                    //       context);
                    //   return;
                    // }

                    DialogHelper.deleteAccountConfirmationDialog(
                        context,
                        GenericMethods.getStringValue(
                            context, AppStringConstant.deleteYourAccount),
                        GenericMethods.getStringValue(
                                context,
                                AppStringConstant
                                    .deleteAccountWarningStartMessage) +
                            " " +
                            (appStoragePref.getUserData()?.email ?? "")
                                .toString() +
                            " " +
                            GenericMethods.getStringValue(
                                context,
                                AppStringConstant
                                    .deleteAccountWarningEndMessage),
                        (String value) {
                      _accountInfoBloc?.add(DeleteAccountEvent(
                          appStoragePref.getUserData()?.email ?? "", value));
                    });
                  },
                  Utils.getStringValue(context, AppStringConstant.deleteAccount)
                      .toUpperCase(),
                ),

                const SizedBox(height: AppSizes.size16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> displayPasswordAuthenticationDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "${Utils.getStringValue(context, AppStringConstant.pleaseEnterPasswordToDeleteAccount)}$userEmail",
              maxLines: 4,
            ),
            content: Form(
                key: _deleteDialogFormKey,
                child: TextFormField(
                    controller: _deletePasswordController,
                    obscureText: true,
                    decoration: formFieldDecoration(
                        context,
                        "",
                        Utils.getStringValue(
                            context, AppStringConstant.password),
                        isRequired: true,
                        suffix: IconButton(
                          icon: Icon(
                            Icons.visibility_off,
                          ),
                          onPressed: () {},
                        )),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      return (_deletePasswordController.text.isNotEmpty)
                          ? null
                          : (Utils.getStringValue(
                              context, AppStringConstant.required));
                    })),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: AppColors.red,
                    ),
                    backgroundColor: AppColors.red),
                child: Text(
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.white),
                  Utils.getStringValue(context, AppStringConstant.cancel),
                ),
              ),
              OutlinedButton(
                onPressed: () async {
                  if (_deleteDialogFormKey.currentState?.validate() == true) {
                    //delete account
                    _accountInfoBloc?.emit(AccountInfoLoadingState());
                  }
                },
                child: Text(
                  Utils.getStringValue(
                      context, AppStringConstant.deleteAccount),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              )
            ],
          );
        });
  }
}
