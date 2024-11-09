/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/app_widgets/app_outlined_button.dart';
import 'package:test_new/unvells/helper/app_localizations.dart';
import 'package:test_new/unvells/helper/utils.dart';

import '../../app_widgets/app_alert_message.dart';
import '../../app_widgets/app_bar.dart';
import '../../app_widgets/app_text_field.dart';
import '../../app_widgets/loader.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_string_constant.dart';
import '../../helper/validator.dart';
import 'bloc/contact_us_screen_bloc.dart';
import 'bloc/contact_us_screen_event.dart';
import 'bloc/contact_us_screen_state.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  ContactUsBloc? bloc;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  late FocusNode _nameFocusNode,
      _emailFocusNode,
      _phoneNumberFocusNode,
      _descriptionFocusNode;

  late AppLocalizations? _localizations;
  late bool _loading;
  late GlobalKey<FormState> _formKey;
  String? emailErrorMessage;

  void _validateForm() async {
    if (_formKey.currentState?.validate() == true) {
      bloc?.add(AddCommentEvent(
        _nameController.text.toString() ?? '',
        _emailController.text.toString() ?? '',
        _phoneNumberController.text.toString() ?? '',
        _descriptionController.text.toString() ?? '',
      ));
    } else {
      _focusErrorNode();
    }
  }

  void _focusErrorNode() {
    if (_nameController.text.isEmpty) {
      FocusScope.of(context).requestFocus(_nameFocusNode);
    } else if (_emailController.text.isEmpty && emailErrorMessage != null) {
      FocusScope.of(context).requestFocus(_emailFocusNode);
    } else if (_phoneNumberController.text.isEmpty) {
      FocusScope.of(context).requestFocus(_phoneNumberFocusNode);
    } else if (_descriptionController.text.isEmpty) {
      FocusScope.of(context).requestFocus(_descriptionFocusNode);
    }
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _loading = false;
    _formKey = GlobalKey();
    bloc = context.read<ContactUsBloc>();

    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _phoneNumberFocusNode = FocusNode();
    _descriptionFocusNode = FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactUsBloc, ContactUsState>(
        builder: (context, currentState) {
      if (currentState is ContactUsLoadingState) {
        _loading = true;
      } else if (currentState is AddCommentSuccessState) {
        _loading = false;
        // _nameController = TextEditingController();
        // _emailController = TextEditingController();
        // _phoneNumberController = TextEditingController();
        // _descriptionController = TextEditingController();

        WidgetsBinding.instance?.addPostFrameCallback((_) {
          AlertMessage.showSuccess(currentState.data.message ?? '', context);
        });
      } else if (currentState is ContactUsErrorState) {
        _loading = false;
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          AlertMessage.showError(
              currentState.message ??
                  Utils.getStringValue(
                      context, AppStringConstant.somethingWentWrong),
              context);
        });
      } else if (currentState is ContactUsEmptyState) {}

      bloc?.emit(ContactUsEmptyState());
      return _buildContent();
    });
  }

  Widget _buildContent() {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: commonAppBar(
              Utils.getStringValue(context, AppStringConstant.contactUs),
              context,
              isLeadingEnable: false, onPressed: () {
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
                    const SizedBox(
                      height: AppSizes.size16,
                    ),
                    AppTextField(
                      focusNode: _nameFocusNode,
                      controller: _nameController,
                      isRequired: true,
                      isPassword: false,
                      hintText:
                          Utils.getStringValue(context, AppStringConstant.name),
                      inputType: TextInputType.name,
                    ),
                    const SizedBox(height: AppSizes.size16),
                    TextFormField(
                      focusNode: _emailFocusNode,
                      controller: _emailController,
                      decoration: formFieldDecoration(
                          context,
                          "",
                          Utils.getStringValue(
                              context, AppStringConstant.email),
                          isRequired: true),
                      autovalidateMode: (_emailController.text.isNotEmpty)
                          ? AutovalidateMode.always
                          : AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        return Validator.isEmailValid(value ?? '', context);
                      },
                      onChanged: (value) async {
                        if (Validator.isEmailValid(value, context) == null) {
                          // var wkToken = await AppSharedPref.getWkToken();
                          // bloc?.add(CheckEmailEvent(value, wkToken));
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
                    const SizedBox(height: AppSizes.size16),
                    AppTextField(
                      focusNode: _phoneNumberFocusNode,
                      controller: _phoneNumberController,
                      isPassword: false,
                      hintText: Utils.getStringValue(
                          context, AppStringConstant.phoneNumber),
                      isRequired: false,
                      inputType: TextInputType.phone,
                    ),
                    const SizedBox(height: AppSizes.size16),
                    AppTextField(
                      focusNode: _descriptionFocusNode,
                      hintText: Utils.getStringValue(
                          context, AppStringConstant.whatsOnYourMind),
                      controller: _descriptionController,
                      isRequired: true,
                      isPassword: false,
                      minLine: 3,
                      maxLine: 5,
                      inputType: TextInputType.text,
                    ),
                    const SizedBox(height: AppSizes.size16 * 1.5),
                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                          onPressed: () {
                            _validateForm();
                          },
                          child: Center(
                              child: Text(
                            Utils.getStringValue(
                                    context, AppStringConstant.submit)
                                .toUpperCase(),
                            style: const TextStyle(color: Colors.white),
                          ))),
                    ),
                    const SizedBox(height: AppSizes.size16),
                  ],
                ),
              ),
            ),
          ),
        ),
        Visibility(visible: _loading, child: const Loader())
      ],
    );
  }
}
