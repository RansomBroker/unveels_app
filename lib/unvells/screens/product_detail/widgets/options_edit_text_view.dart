/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';

import '../../../constants/app_constants.dart';
import '../../../helper/app_localizations.dart';

class OptionsEditTextView extends StatefulWidget {
  OptionsEditTextView({Key? key, this.textData}) : super(key: key);

  ValueChanged<String>? textData=(test){};

  @override
  _OptionsEditTextViewState createState() => _OptionsEditTextViewState();
}

class _OptionsEditTextViewState extends State<OptionsEditTextView> {
  final TextEditingController optionController=TextEditingController();
  AppLocalizations? _localizations;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      readOnly:false,
      keyboardType: TextInputType.text,
      obscureText: false,
      controller: optionController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.zero),
            borderSide: BorderSide(
              color: AppColors.black,
            )),
        contentPadding: EdgeInsets.only(top: AppSizes.spacingLarge, bottom: AppSizes.spacingLarge, left: AppSizes.spacingTiny, right: AppSizes.spacingTiny),
        isDense: true,
        label:  Text(""),
      ),
      style: Theme.of(context).textTheme.bodyLarge,
      onChanged: (value) {
        widget.textData!(optionController.text.toString());
      },
    );
  }
}

