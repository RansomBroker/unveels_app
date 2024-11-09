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
import '../login_signup/bloc/signin_signup_screen_bloc.dart';
import 'bloc/whishlist_sharing_screen_bloc.dart';
import 'bloc/wishlist_sharing_screen_event.dart';
import 'bloc/wishlist_sharing_screen_state.dart';

class WishlistSharing extends StatefulWidget {
  const WishlistSharing({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WishlistSharingState();
}

class _WishlistSharingState extends State<WishlistSharing> {
  WishlistSharingBloc? bloc;

  late TextEditingController _emailController, _messageController;

  late FocusNode _emailFocusNode, _messageFocusNode;

  late AppLocalizations? _localizations;
  late bool _loading;
  late GlobalKey<FormState> _formKey;
  String? emailErrorMessage;

  void _validateForm() async {
    if (_formKey.currentState?.validate() == true) {
      Utils.hideSoftKeyBoard();
      _loading = true;
      bloc?.add(WishListSharingSubmitEvent(
          _emailController.text.trim(), _messageController.text));
    } else {
      _focusErrorNode();
    }
  }

  void _focusErrorNode() {
    if (_emailController.text.isEmpty && emailErrorMessage != null) {
      FocusScope.of(context).requestFocus(_emailFocusNode);
    } else if (_messageController.text.isEmpty) {
      FocusScope.of(context).requestFocus(_messageFocusNode);
    }
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _emailController = TextEditingController(text: "");
    _messageController = TextEditingController(text: "");
    bloc = context.read<WishlistSharingBloc>();
    _loading = false;
    _formKey = GlobalKey();

    _emailFocusNode = FocusNode();
    _messageFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistSharingBloc, WishlistSharingState>(
      builder: (context, state) {
        if (state is WishlistSharingSuccessState) {
          _loading = false;
          var model = state.data;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showSuccess(model.message ?? "", context);
            Navigator.pop(context);
          });
        }
        return Stack(
          children: <Widget>[
            _buildContent(),
            Visibility(
              visible: _loading,
              child: const Loader(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildContent() {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: commonAppBar(
          Utils.getStringValue(context, AppStringConstant.wishlistSharing),
          context,
          isLeadingEnable: true, onPressed: () {
        Navigator.pop(context);
      }),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.size8),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: AppSizes.spacingNormal),

                  /// Sharing Information Heading
                  child: Text(
                    Utils.getStringValue(
                        context, AppStringConstant.sharingInformation),
                    style: /*Theme.of(context).textTheme.headlineSmall
                      ?.copyWith(fontSize: AppSizes.textSizeSmall),*/
                    const TextStyle(
                        fontSize: AppSizes.textSizeMedium,
                        color: AppColors.textColorPrice),
                    textAlign: TextAlign.start,
                    textDirection: TextDirection.ltr,
                  ),
                ),
                SizedBox(
                  width: AppSizes.deviceWidth,
                  height: AppSizes.textSizeLarge,
                  child: const Divider(
                    height: 1,
                    thickness: 1,
                  ),
                ),
                const SizedBox(height: AppSizes.size16),
                TextFormField(
                  focusNode: _emailFocusNode,
                  controller: _emailController,
                  decoration: formFieldDecoration(
                      context,
                      "",
                      Utils.getStringValue(
                          context, AppStringConstant.enterEmailSeparatedCommas),
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
                if (emailErrorMessage != null)
                  const SizedBox(height: AppSizes.size34),
                AppTextField(
                  focusNode: _messageFocusNode,
                  hintText: Utils.getStringValue(
                      context, AppStringConstant.messageWishlistShare),
                  textDirection: TextDirection.ltr,
                  controller: _messageController,
                  isRequired: false,
                  isPassword: false,
                  minLine: 3,
                  maxLine: 4,
                  inputType: TextInputType.text,
                ),
                const SizedBox(height: AppSizes.size16 * 1.5),
                appOutlinedButton(
                    context,
                    _validateForm,
                    Utils.getStringValue(
                        context, AppStringConstant.shareWishList)
                        .toUpperCase(),
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    textColor: AppColors.white),
                const SizedBox(height: AppSizes.size16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
