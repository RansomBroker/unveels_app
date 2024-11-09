/*
 *
  

 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/utils.dart';
import '../helper/generic_methods.dart';
import 'app_text_field.dart';

class AppDatePicker extends StatefulWidget {
  ValueChanged<String>? selectedDate = (test) {};
  String? optionDefaultValue;
  final TextEditingController controller;
  final String? hintText;
  String? labelText;
  final String? helperText;
  bool? isRequired;
  final TextInputType inputType;
  final String? validationType;
  final String? validationMessage;
  bool readOnly;
  bool? enable;
  bool? isDense;
  bool isPassword;
  Function(String)? onChange;
  int? maxLine;
  Widget? suffix;
  Function()? onEditingComplete;
  String? Function(String?)? validation;
  TextDirection? textDirection;
  FocusNode? focusNode;

  AppDatePicker(
      {required this.controller,
        required this.isPassword,
        this.hintText = '',
        this.labelText = '',
        this.helperText,
        this.isRequired = false,
        this.inputType = TextInputType.text,
        this.validationType,
        this.validationMessage = '',
        this.maxLine = 1,
        this.readOnly = false,
        this.enable = true,
        this.onChange,
        this.validation,
        this.suffix,
        this.textDirection,
        this.onEditingComplete,
        this.focusNode,
        this.isDense = true});

  @override
  _AppDatePickerState createState() =>
      _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> {

  late bool _obscureText = false;
  DateTime? selectedDate = DateTime.now();


  @override
  void initState() {
    _obscureText = widget.isPassword ? true : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.labelText != "")
          Row(
            children: [
              Text(
                (widget.labelText ?? '') +
                    ((widget.isRequired ?? false) ? "*" : ""),
                // style: Theme.of(context).textTheme.titleSmall
              ),
            ],
          ),
        TextFormField(
            focusNode: widget.focusNode,
            textDirection: widget.textDirection,
            cursorColor: Theme.of(context).colorScheme.onPrimary,
            enabled: widget.enable,
            readOnly: true,
            maxLines: widget.maxLine,
            obscureText: _obscureText,
            keyboardType: widget.inputType,
            controller: widget.controller,
            style: Theme.of(context).textTheme.bodyMedium,
            onChanged: widget.onChange,
            onEditingComplete: widget.onEditingComplete,
            decoration: formFieldDecoration(
              context,
              widget.helperText,
              widget.hintText,
              isRequired: widget.isRequired,
              suffix: widget.suffix,
              isDense: widget.isDense,
            ),
            onTap: () async {
              selectedDate = await GenericMethods()
                  .showDatePickerAndGetSelectedDate(
                  context,
                  selectedDate!, widget.hintText.toString()
              );

              setState(() {
                widget.selectedDate!(
                    "${selectedDate?.day}-${selectedDate?.month}-${selectedDate?.year}");

                widget.controller.text = "${selectedDate?.day}-${selectedDate?.month}-${selectedDate?.year}";
              });
            },
            validator:
            ((widget.isRequired == true) && (widget.validation == null))
                ? (value) {
              if (widget.isRequired == true) {
                if (value?.isEmpty ?? false) {
                  return (widget.validationMessage != '')
                      ? widget.validationMessage
                      : "${Utils.getStringValue(context, AppStringConstant.required)}";
                }  else {
                  return null;
                }
              } else {
                return null;
              }
            }
            : widget.validation
        ),
      ],
    );
  }
}
