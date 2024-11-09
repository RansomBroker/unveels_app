import 'package:flutter/material.dart';
import 'package:test_new/unvells/app_widgets/app_text_field.dart';
import 'package:collection/collection.dart';
import 'package:test_new/unvells/app_widgets/custom_button.dart';
import 'package:test_new/unvells/helper/utils.dart';
import '../../../../constants/app_constants.dart';
import '../../../../constants/app_string_constant.dart';
import '../../../../helper/app_storage_pref.dart';
import '../../../../models/wallet_extension_models/wallet_dashboard_model.dart';

class TransferMoneyView extends StatefulWidget {
  const TransferMoneyView(
      {super.key,
      required this.transferPayeeList,
      this.payeeList,
      required this.callBack});

  final Function(int, int, String) callBack;
  final List<DropdownMenuItem<String>> transferPayeeList;
  final List<PayeeList>? payeeList;

  @override
  State<TransferMoneyView> createState() => _TransferMoneyViewState();
}

class _TransferMoneyViewState extends State<TransferMoneyView> {
  TextEditingController amtCtrl = TextEditingController();
  TextEditingController noteCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String selectedValue = "0";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
          child: Text(
        Utils.getStringValue(
            context, AppStringConstant.transferMoneyToCustomer),
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16),
      )),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField(
                isExpanded: true,
                  validator: (value) {
                    if (value == null) {
                      return "Please select Payee";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                    fillColor: Colors.white,
                    labelText: "Select Payee",
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
                  items: widget.transferPayeeList,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value.toString();
                    });
                    print("selectedValue $selectedValue");
                  }),
              // AppTextField(isPassword: false),
              AppTextField(
                isPassword: false,
                isRequired: true,
                controller: amtCtrl,
                inputType: TextInputType.number,
                hintText: "Amount (${appStoragePref.getCurrencyCode()})",
                validationMessage: "Please enter the value",
              ),
              AppTextField(
                isPassword: false,
                isRequired: true,
                controller: noteCtrl,
                hintText: "Note",
                validationMessage: "Please enter the value",
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: AppSizes.deviceWidth,
                child: CustomButton(
                  onPressed: () {
                    if ((_formKey.currentState?.validate() ?? false)) {
                      widget.callBack(int.parse(selectedValue), int.parse(amtCtrl.text), noteCtrl.text);
                    }
                  },
                  title: AppStringConstant.transferMoneyToCustomer,
                  // child: const Text(AppStringConstant.transferMoneyToCustomer),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
