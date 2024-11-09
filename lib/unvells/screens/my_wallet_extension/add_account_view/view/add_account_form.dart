import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/unvells/app_widgets/app_bar.dart';
import 'package:test_new/unvells/app_widgets/app_text_field.dart';
import 'package:test_new/unvells/app_widgets/custom_button.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';

import '../../../../constants/app_constants.dart';
import '../../../../helper/utils.dart';
import '../../../../models/wallet_extension_models/add_account_form_model.dart';

class AddAccountDetailsForm extends StatefulWidget {
  const AddAccountDetailsForm({super.key, this.callBack});
  final Function (AddAccountFormModel)? callBack;
  @override
  State<AddAccountDetailsForm> createState() => _AddAccountDetailsFormState();
}

class _AddAccountDetailsFormState extends State<AddAccountDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController accountHolderName = TextEditingController();
  TextEditingController acNumberCtrl = TextEditingController();
  TextEditingController bankNameCtrl = TextEditingController();
  TextEditingController codeCtrl = TextEditingController();
  TextEditingController descCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
          child: Text(
        Utils.getStringValue(context, AppStringConstant.addAccountDetails),
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 16,
            ),
      )),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AppTextField(
                controller: accountHolderName,
                isPassword: false,
                isRequired: true,
                validationMessage: "Please Enter the details",
                hintText: "A/c Holder Name",
              ),
              const SizedBox(
                height: 5,
              ),
              AppTextField(
                controller: acNumberCtrl,
                isPassword: false,
                isRequired: true,
                hintText: "A/c Number",
                inputType: TextInputType.number,
                validationMessage: "Please Enter the details",
              ),
              const SizedBox(
                height: 5,
              ),
              AppTextField(
                controller: bankNameCtrl,
                isPassword: false,
                isRequired: true,
                hintText: "Bank Name",
                validationMessage: "Please Enter the details",
              ),
              const SizedBox(
                height: 5,
              ),
              AppTextField(
                controller: codeCtrl,
                isPassword: false,
                isRequired: true,
                hintText: "Bank Code",
                validationMessage: "Please Enter the details",
              ),
              const SizedBox(
                height: 5,
              ),
              AppTextField(
                controller: descCtrl,
                isPassword: false,
                isRequired: true,
                hintText: "Additional Information",
                maxLine: 5,
                minLine: 5,
                validationMessage: "Please Enter the details",
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: AppSizes.deviceWidth,
                child: CustomButton(
                    onPressed: () {
                      if((_formKey.currentState?.validate() ?? false)){
                        widget?.callBack!(AddAccountFormModel(
                          acHolderName: accountHolderName.text,
                          acNumber: acNumberCtrl.text,
                          bankCode: codeCtrl.text,
                          bankName: bankNameCtrl.text,
                          description: descCtrl.text
                        ));
                      }
                    },
                    title: Utils.getStringValue(
                        context, AppStringConstant.submitBankDetails),

                    // child: Text(Utils.getStringValue(
                    //     context, AppStringConstant.submitBankDetails)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
