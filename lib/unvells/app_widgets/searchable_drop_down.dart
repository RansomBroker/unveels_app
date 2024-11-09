import 'package:flutter/material.dart';
import 'package:test_new/unvells/app_widgets/app_text_field.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/utils.dart';

import '../configuration/text_theme.dart';
import 'multi_select_dialog/index.dart';
import 'multi_select_dialog/multi_helper.dart';

class KDropdownBtn<T> extends StatelessWidget {
  final String title;
  final T? value;
  final Function(T?) onChanged;
  final String? Function(T?)? validator;
  final List<MultiSelectorItem<T>> items;
  final SelectorViewType? type;
  final String? error;
  final BoxDecoration? btnDecoration;
  final bool? showArrow;
  final bool? showAz;
  final bool isLoading;
  final bool? isRequired;

  const KDropdownBtn({
    Key? key,
    required this.title,
    this.value,
    required this.onChanged,
    required this.items,
    this.validator,
    this.type,
    this.error,
    this.showArrow,
    this.btnDecoration,
    this.showAz,
    this.isLoading = false,
    this.isRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiSelector.single<T>(
      items: items,
      title: title,
      onChanged: onChanged,
      validator: validator,
      type: SelectorViewType.sheet,
      showArrow: showArrow,
      // titleStyle: KTextStyle.of(context),
      value: value,
      isRequired: isRequired ?? false,
      textFieldDecoration: formFieldDecoration(
          context, "", Utils.getStringValue(context, AppStringConstant.search)),
      btnDecoration: BoxDecoration(
        color: const Color(0xffFAFAFA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffE0E0E0), width: 1.5),
      ),
      // popupDecoration: KHelper.of(context).msgBubble,
      // btnDecoration: btnDecoration ?? KHelper.of(context).textFieldDecoration,
      error: error,
      hintStyle: KTextStyle.of(context).twelve,
      showAz: true,
    );
  }
}

class KDropdownBtnMulti<T> extends StatelessWidget {
  final String hint;
  final T? value;
  final String? Function(List<T>? values)? validator;
  final List<MultiSelectorItem<T>> items;
  final Function(List<T> values) onChanged;
  final SelectorViewType? type;
  final String? error;
  final bool? showArrow;
  final BoxDecoration? btnDecoration;

  const KDropdownBtnMulti({
    Key? key,
    required this.hint,
    this.value,
    required this.onChanged,
    required this.items,
    this.validator,
    this.type,
    this.error,
    this.showArrow,
    this.btnDecoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiSelector.multi<T>(
      items: items,
      title: hint,
      onChanged: onChanged,
      validator: validator,
      type: SelectorViewType.sheet,
      showArrow: showArrow,
      // popupDecoration: KHelper.of(context).msgBubble,
      btnDecoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade500),
      ),
      hintStyle: KTextStyle.of(context).twelve,
      error: error,
    );
  }
}

MultiSelectorItem<T> itemView<T>(
    {required String itemText, required T value, Widget? icon}) {
  return MultiSelectorItem<T>(
    value: value,
    searchValue: itemText,
    icon: icon,
    child: Text(itemText, overflow: TextOverflow.ellipsis),
  );
}
