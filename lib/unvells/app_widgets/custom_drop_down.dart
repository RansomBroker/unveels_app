import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/app_constants.dart';
import 'app_text_field.dart';

class CustomDropDownField<T> extends StatelessWidget {
  final Key? key;
  final List<DropdownMenuItem<T>>? itemList;
  final String? hintText;
  final T? value;
  final String? title;
  final String? dropDownValue;
  final String? labelText;
  final void Function(T?, Key?)? callBack;
  final bool isRequired;

  const CustomDropDownField({
    this.key,
    this.itemList,
    this.value,
    this.hintText,
    this.dropDownValue,
    this.labelText = "",
    this.callBack,
    this.isRequired = false,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: AppColors.white,
      ),
      child: DropdownButtonFormField<T>(
        iconEnabledColor: AppColors.gold,
        value: value,
        isExpanded: true,
        key: key,
        icon: const Icon(FontAwesomeIcons.angleDown),
        validator: (val) {
          if (val == null && isRequired) {
            return "* Required";
          } else {
            return null;
          }
        },
        onChanged: (T? newValue) {
          if (callBack != null) {
            callBack!(newValue, key);
          }
        },
        items: itemList,
        hint: Text((hintText ?? "") + (isRequired ? ' * ' : '')),
        decoration: formFieldDecoration(
          context,
          hintText,
          labelText,
          isRequired: isRequired,
          isDense: true,
          outline: true, // Ensure outline is true to match styling.
        ),
      ),
    );
  }
}
