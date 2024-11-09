/*
 *


 *
 * /
 */

// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/helper/extension.dart';
import 'dart:ui';

import '../configuration/unvells_theme.dart';
import '../constants/app_constants.dart';
import '../constants/app_string_constant.dart';
import '../helper/app_localizations.dart';
import '../helper/validator.dart';

class OldAppTextField extends StatefulWidget {
  final TextEditingController? controller;
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
  int? minLine;
  Widget? suffix;
  Function()? onEditingComplete;
  String? Function(String?)? validation;
  final ValueChanged<String?>? onSave;
  TextDirection? textDirection;
  FocusNode? focusNode;
  bool outline ;


  OldAppTextField(
      {super.key,
        this.controller,
        this.isPassword=false,
        this.hintText = '',
        this.labelText = '',
        this.helperText,
        this.isRequired = false,
        this.inputType = TextInputType.text,
        this.validationType,
        this.validationMessage = '',
        this.maxLine = 1,
        this.minLine = 1,
        this.readOnly = false,
        this.enable = true,
        this.onChange,
        this.validation,
        this.suffix,
        this.textDirection,
        this.onEditingComplete,
        this.focusNode,
        this.onSave,
        this.isDense = true,
        this.outline = false,
      });

  @override
  State<OldAppTextField> createState() => _OldAppTextFieldState();
}

class _OldAppTextFieldState extends State<OldAppTextField> {
  late bool _obscureText;

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
        SizedBox(height: 10),
        TextFormField(
            focusNode: widget.focusNode,
            textDirection: widget.textDirection,
            cursorColor: Theme.of(context).iconTheme.color,
            cursorHeight: 20,
            enabled: widget.enable,
            readOnly: widget.readOnly,
            maxLines: widget.maxLine,
            minLines: widget.minLine,
            obscureText: _obscureText,
            keyboardType: widget.inputType,
            controller: widget.controller,
            style: KTextStyle.of(context).sixteen,
            onChanged: widget.onChange,
            onEditingComplete: widget.onEditingComplete,
            onSaved: widget.onSave,
            decoration: formFieldDecoration(
              outline: widget.outline,
              context,
              widget.helperText,
              widget.hintText,
              isRequired: widget.isRequired,
              suffix: widget.isPassword
                  ? IconButton(
                icon: Icon(
                  _obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 24,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
                  : widget.suffix,
              isDense: widget.isDense,
            ),
            validator:
            ((widget.isRequired == true) && (widget.validation == null))
                ? (value) {
              if (widget.isRequired == true) {
                if (value?.isEmpty ?? false) {
                  return (widget.validationMessage != '')
                      ? widget.validationMessage
                      : "${AppLocalizations.of(context)?.translate(AppStringConstant.required)}";
                } else if (widget.validationType ==
                    AppStringConstant.email) {
                  return Validator.isEmailValid(value ?? '', context);
                } else if (widget.validationType ==
                    AppStringConstant.password) {
                  return Validator.isValidPassword(
                      AppLocalizations.of(context)
                          ?.translate(value ?? "") ??
                          '',
                      context);
                } else {
                  return null;
                }
              } else {
                return null;
              }
            }
                : widget.validation),
      ],
    );
  }
}

InputDecoration formFieldDecoration(
    BuildContext context,
    String? helperText,
    String? hintText, {
      bool? isDense = true,
      bool? isRequired,
      Widget? suffix,
      bool outline = false,
    }) {
  return InputDecoration(
    alignLabelWithHint: true,
    isDense: isDense,
    hintText: helperText,
    labelText: (hintText ?? "") +
        ((isRequired ?? false) && (hintText != '') ? "*" : ""),
    labelStyle: KTextStyle.of(context)
        .twelve
        .copyWith(color: Color(0xff868E96), height: 1),
    hintStyle: Theme.of(context).textTheme.bodyMedium,
    errorMaxLines: 2,
    // labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
    //       fontWeight: FontWeight.normal,
    //     ),
    // fillColor:Colors.transparent,
    // filled: true,
    suffixIcon: suffix,
    enabled: true,
    border:outline? OutlineInputBorder(
      // borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.grey,
        )):UnderlineInputBorder(
      // borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.grey,
        )),
    //
    enabledBorder: outline
        ? OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Color(0xffe8eaec), width: 1.6))
        : UnderlineInputBorder(
      // borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Color(0xFFA2A2A2)),
    ),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey, width: 1.5)),

    //   disabledBorder: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(10),
    //       borderSide: BorderSide(
    //         color: Colors.grey,
    //       )),
    //   enabledBorder: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(10),
    //       borderSide: BorderSide(
    //         color: Colors.grey,
    //       )),
  );
}



class CommonDropDownField extends StatelessWidget {
  @override
  Key? key;
  final List<String>? itemList;
  final String? hintText;
  final String? value;
  final String? dropDownValue;
  final String? labelText;
  void Function(String, Key?)? callBack;
  final bool isRequired;

  CommonDropDownField(
      {this.key,
        this.itemList,
        this.value,
        this.hintText,
        this.dropDownValue,
        this.labelText = "",
        this.callBack,
        this.isRequired = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: AppColors.white,
      ),
      child: DropdownButtonFormField(
          iconEnabledColor: AppColors.gold,
          value: value /*value ?? itemList?[1]*/,
          isExpanded: true,
          key: key,
          icon: Icon(FontAwesomeIcons.angleDown),
          validator: (val) {
            if (val == null) {
              return "* Required";
            } else {
              return null;
            }
          },
          onChanged: (String? newValue) {
            if (callBack != null) {
              callBack!(newValue ?? '', key);
            }
          },
          items: itemList?.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(color: Colors.grey),
              ),
            );
          }).toList(),
          hint: Text((hintText ?? "") + ' * '),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
            fillColor: Colors.white,
            labelText: labelText,
            enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(color:  Color(0xffe8eaec))),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(color: Colors.grey.shade500)),
            errorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(color: Colors.red.shade500)),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(color: Colors.grey.shade500),
            ),
          )),
    );
  }
}
