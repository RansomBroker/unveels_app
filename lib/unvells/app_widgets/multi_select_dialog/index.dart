
import 'package:flutter/material.dart';

import 'index.dart';
export 'multi_helper.dart';
export 'multi_select_view.dart';
export 'single_select_view.dart';
export 'package:azlistview/azlistview.dart';





abstract class MultiSelector {
  static KSingleSelector<T> single<T>({
    required String title,
    required List<MultiSelectorItem<T>> items,
    required Function(T? values) onChanged,
    BoxDecoration? btnDecoration,
    BoxDecoration? popupDecoration,
    BoxDecoration? errorDecoration,
    SelectorViewType? type,
    bool? showArrow = true,
    bool? showAz = false,
    bool isRequired = false,
    String? Function(T? values)? validator,
    String? error,
    TextStyle? titleStyle,
    TextStyle? hintStyle,
    T? value,
    InputDecoration? textFieldDecoration,
  }) {
    return KSingleSelector<T>(
      title: title,
      btnDecoration: btnDecoration,
      items: items,
      type: type,
      isRequired: isRequired,
      onChanged: onChanged,
      validator: validator,
      error: error,
      titleStyle: titleStyle,
      value: value,
      showArrow: showArrow,
      showAz: showAz,
      hintStyle: hintStyle,
      textFieldDecoration: textFieldDecoration,
      popupDecoration: popupDecoration,
      errorDecoration: errorDecoration,
    );
  }

  static KMultiSelector<T> multi<T>({
    required String title,
    required List<MultiSelectorItem<T>> items,
    required Function(List<T> values) onChanged,
    List<T>? initSelection,
    BoxDecoration? btnDecoration,
    BoxDecoration? popupDecoration,
    BoxDecoration? errorDecoration,
    SelectorViewType? type,
    String? Function(List<T>? values)? validator,
    String? error,
    bool? showArrow = true,
    bool? showAz = false,
    String? confirmText,
    TextStyle? confirmStyle,
    TextStyle? titleStyle,
    TextStyle? hintStyle,
    InputDecoration? textFieldDecoration,
  }) {
    return KMultiSelector<T>(
      title: title,
      btnDecoration: btnDecoration,
      items: items,
      type: type,
      onChanged: onChanged,
      validator: validator,
      error: error,
      showArrow: showArrow,
      showAz: showAz,
      initSelection: initSelection,
      confirmText: confirmText,
      confirmStyle: confirmStyle,
      titleStyle: titleStyle,
      hintStyle: hintStyle,
      errorDecoration: errorDecoration,
      textFieldDecoration: textFieldDecoration,
      popupDecoration: popupDecoration,
    );
  }
}
