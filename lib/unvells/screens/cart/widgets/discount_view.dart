/*
 *
  

 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/app_widgets/app_outlined_button.dart';
import 'package:test_new/unvells/app_widgets/app_text_field.dart';
import 'package:test_new/unvells/configuration/unvells_theme.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/app_localizations.dart';
import 'package:test_new/unvells/helper/utils.dart';

class DiscountView extends StatefulWidget {
  const DiscountView(
      {required this.discountApplied,
      required this.discountCode,
      required this.onClickApply,
      required this.onClickRemove,
      super.key,
      required this.title,
      required this.hint,
      this.warning,
      this.maxNumber,
      this.keybordType,
      this.expanded = false});

  final bool discountApplied;
  final bool expanded;
  final String discountCode, title, hint;
  final String? warning;
  final String? maxNumber;
  final TextInputType? keybordType;
  final Function(String)? onClickApply;
  final Function(String)? onClickRemove;

  @override
  State<DiscountView> createState() => _DiscountViewState();
}

class _DiscountViewState extends State<DiscountView> {
  TextEditingController codeController = TextEditingController();
  late FocusNode codeControllerNode;
  AppLocalizations? _localizations;
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    codeControllerNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.discountApplied) {
      codeController.text = widget.discountCode ?? "";
    } else {
      codeController.text = "";
    }
    return Container(
      decoration: ShapeDecoration(
        color: const Color(0xFFF5F5F5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          // childrenPadding: EdgeInsets.zero,
          leading: Icon(
            Icons.discount,
            color: Theme.of(context).iconTheme.color,
          ),
          iconColor: Theme.of(context).iconTheme.color,
          childrenPadding: const EdgeInsets.only(
              left: AppSizes.size12,
              right: AppSizes.size12,
              bottom: AppSizes.size12),
          initiallyExpanded: widget.expanded,
          title: Row(
            children: [
              Text(
                  (_localizations?.translate(
                            widget.title,
                          ) ??
                          "")
                      .toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontSize: 14, fontWeight: FontWeight.bold)),
              Text(
                widget.warning ?? '',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.gold,
                    ),
              )
            ],
          ),
          children: [
            const SizedBox(
              height: 4,
            ),
            Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    child: AppTextField(
                        isDense: true,
                        isRequired: false,
                        focusNode: codeControllerNode,
                        controller: codeController,
                        inputType: widget.keybordType ?? TextInputType.text,
                        validation: (p0) {
                          if (widget.maxNumber != null) {
                            int parseP0 = int.parse(p0!);
                            int max = int.parse(widget.maxNumber ?? '0');

                            if (parseP0 > max) {
                              return Utils.getStringValue(context,
                                  AppStringConstant.rewardMaxAmountWarning);
                            }
                            return null;
                          }
                          return null;
                        },
                        readOnly: widget.discountApplied ? true : false,
                        isPassword: false,
                        validationMessage: "Please enter some text",
                        hintText: Utils.getStringValue(context, widget.hint),
                        suffix: GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              if (codeController.text.isNotEmpty) {
                                if (widget.discountApplied) {
                                  widget.onClickRemove!(codeController.text);
                                } else {
                                  widget.onClickApply!(codeController.text);
                                }
                              } else {
                                codeControllerNode.requestFocus();
                              }
                            }
                          },
                          child: Container(
                            width: AppSizes.deviceWidth / 4,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(6),
                                bottomRight: Radius.circular(6),
                              ),
                            ),
                            child: Center(
                                child: Text(
                              widget.discountApplied
                                  ? Utils.getStringValue(
                                          context, AppStringConstant.remove)
                                      .toUpperCase()
                                  : Utils.getStringValue(
                                          context, AppStringConstant.apply)
                                      .toUpperCase(),
                              style: const TextStyle(
                                color: AppColors.white,
                              ),
                            )),
                          ),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
