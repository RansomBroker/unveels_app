import 'package:flutter/material.dart';
import 'package:test_new/unvells/app_widgets/app_text_field.dart';
import 'package:test_new/unvells/app_widgets/custom_button.dart';
import 'package:test_new/unvells/constants/app_constants.dart';

import '../../../../constants/app_string_constant.dart';
import '../../../../helper/utils.dart';

class TransferAmountToBankView extends StatefulWidget {
  const TransferAmountToBankView({super.key, this.accountList, this.callBack});
  final Function (String, String, String)? callBack;
  final List<DropdownMenuItem<String>>? accountList;

  @override
  State<TransferAmountToBankView> createState() =>
      _TransferAmountToBankViewState();
}

class _TransferAmountToBankViewState extends State<TransferAmountToBankView> {
  TextEditingController amount = TextEditingController();
  TextEditingController note = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  dynamic selectedValue;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          Utils.getStringValue(context, AppStringConstant.transferAmtToBank),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16),
        ),
      ),
      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),

      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AppTextField(
                controller: amount,
                validationMessage: "Please Enter the Details",
                isPassword: false,
                hintText: "Amount",
                isRequired: true,
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButtonFormField(
                  isExpanded: true,
                  validator: (value) {
                    if (value == null) {
                      return "Please select Account";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding:
                    const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                    fillColor: Colors.white,
                    labelText: "Select Account",
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.grey.shade500)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.grey.shade500)),
                    errorBorder: OutlineInputBorder(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.red.shade500)),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius:
                      const BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(color: Colors.grey.shade500),
                    ),
                  ),
                  items: widget.accountList,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value.toString();
                    });
                    print("selectedValue $selectedValue");
                  }),
              const SizedBox(
                height: 10,
              ),
              AppTextField(
                controller: note,
                minLine: 5,
                maxLine: 5,
                isPassword: false,
                hintText: "Note",
                isRequired: false,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: AppSizes.deviceWidth,
                child: CustomButton(
                  onPressed: (){
                    if((_formKey.currentState?.validate() ?? false)){
                      widget?.callBack!(amount.text, selectedValue, note.text ?? "");
                    }
                  },
                  title: Utils.getStringValue(context, AppStringConstant.transferAmtToBank),
                  // child: Text(Utils.getStringValue(context, AppStringConstant.transferAmtToBank)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
