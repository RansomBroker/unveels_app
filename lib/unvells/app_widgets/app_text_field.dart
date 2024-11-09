import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants/app_constants.dart';
import '../constants/app_string_constant.dart';
import '../helper/app_localizations.dart';
import '../helper/validator.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
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
  bool outline;

  AppTextField({
    super.key,
    this.controller,
    this.isPassword = false,
    this.hintText = '',
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
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
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
          style: Theme.of(context).textTheme.bodyMedium,
          onChanged: widget.onChange,
          onEditingComplete: widget.onEditingComplete,
          onSaved: widget.onSave,
          decoration: formFieldDecoration(
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
            outline: widget.outline,
          ),
          validator: ((widget.isRequired == true) && (widget.validation == null))
              ? (value) {
            if (value?.isEmpty ?? false) {
              return (widget.validationMessage != '')
                  ? widget.validationMessage
                  : "${AppLocalizations.of(context)?.translate(AppStringConstant.required)}";
            } else if (widget.validationType == AppStringConstant.email) {
              return Validator.isEmailValid(value ?? '', context);
            } else if (widget.validationType == AppStringConstant.password) {
              return Validator.isValidPassword(
                AppLocalizations.of(context)
                    ?.translate(value ?? "") ??
                    '',
                context,
              );
            } else {
              return null;
            }
          }
              : widget.validation,
        ),
      ],
    );
  }
}

// Function to create a common form field decoration for both text fields and dropdowns
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
    contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    isDense: isDense,
    hintText: hintText,
    label: RichText(
      text: TextSpan(
        text: hintText ?? "",
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: const Color(0xff555555),
          fontWeight: FontWeight.w500,
        ),
        children: (isRequired ?? false)
            ? [
          const TextSpan(
            text: " *",
            style: TextStyle(
              color: Colors.red, // Make the required sign red
              fontWeight: FontWeight.bold,
            ),
          ),
        ]
            : [],
      ),
    ),
    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: const Color(0xffB0BEC5),
    ),
    filled: true,
    fillColor: const Color(0xffFAFAFA), // Match with text field background
    border: outline
        ? OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xffDDDDDD), width: 1.2),
    )
        : const UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFA2A2A2)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xffE0E0E0), width: 1.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.gold, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.red.shade500, width: 1.5),
    ),
    suffixIcon: suffix,
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

  CommonDropDownField({
    this.key,
    this.itemList,
    this.value,
    this.hintText,
    this.dropDownValue,
    this.labelText = "",
    this.callBack,
    this.isRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: AppColors.white,
      ),
      child: DropdownButtonFormField(
        iconEnabledColor: AppColors.gold,
        value: value,
        isExpanded: true,
        key: key,
        icon: const Icon(FontAwesomeIcons.angleDown),
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
              style: const TextStyle(color: Colors.grey),
            ),
          );
        }).toList(),
        hint: Text((hintText ?? "") + ' * '),
        decoration: formFieldDecoration(
          context,
          hintText,
          labelText,
          isRequired: isRequired,
          isDense: true,
          outline: true, // Ensure outline is true for dropdowns to match
        ),
      ),
    );
  }
}
