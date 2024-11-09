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

import '../../app_widgets/app_bar.dart';
import '../../app_widgets/app_text_field.dart';
import '../../app_widgets/loader.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_string_constant.dart';
import '../../helper/validator.dart';

class WishlistCommentScreen extends StatefulWidget {
  const WishlistCommentScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WishlistCommentScreenState();
}

class _WishlistCommentScreenState extends State<WishlistCommentScreen> {
  // WishlistCommentScreenBloc? bloc;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  late FocusNode _emailFocusNode,
      _commentFocusNode;

  late AppLocalizations? _localizations;
  late bool _loading;
  late GlobalKey<FormState> _formKey;
  String? emailErrorMessage;

  void _validateForm() async {
    if (_formKey.currentState?.validate() == true) {

    } else {
      _focusErrorNode();
    }
  }

  void _focusErrorNode() {
    if (_emailController.text.isEmpty && emailErrorMessage != null) {
      FocusScope.of(context).requestFocus(_emailFocusNode);
    } else if (_messageController.text.isEmpty) {
      FocusScope.of(context).requestFocus(_commentFocusNode);
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
    // bloc = context.read<WishlistCommentScreenBloc>();

    _emailFocusNode = FocusNode();
    _commentFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildContent(),
        Visibility(
          visible: _loading,
          child: const Loader(),
        ),
      ],
    );
  }

  Widget _buildContent() {
    TextAlign textAlign;

    return Scaffold(
      appBar: commonAppBar(Utils.getStringValue(context, AppStringConstant.addComment), context, isLeadingEnable: true,  onPressed: (){Navigator.pop(context);}),
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
                        context, AppStringConstant.comment),

                    style: /*Theme.of(context).textTheme.headlineSmall
                      ?.copyWith(fontSize: AppSizes.textSizeSmall),*/
                    const TextStyle(
                        fontSize: AppSizes.textSizeMedium,
                        color: AppColors.textColorPrice
                    ),
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

                const SizedBox(height: AppSizes.size30),
                AppTextField(
                  focusNode: _commentFocusNode,
                  hintText:
                  Utils.getStringValue(context, AppStringConstant.comment),
                  textDirection: TextDirection.ltr,
                  controller: _messageController,
                  isRequired: false,
                  isPassword: false,
                  minLine: 3,
                  maxLine: 5,
                  inputType: TextInputType.text,
                ),

                const SizedBox(height: AppSizes.size16 * 1.5),
                appOutlinedButton(
                    context,
                    _validateForm,
                    Utils.getStringValue(context, AppStringConstant.submit).toUpperCase(),
                    backgroundColor: Theme.of(context).colorScheme.onPrimary, textColor: AppColors.white),

                const SizedBox(height: AppSizes.size16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
