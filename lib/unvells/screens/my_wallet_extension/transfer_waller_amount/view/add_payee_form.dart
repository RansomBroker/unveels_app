import 'package:flutter/material.dart';
import 'package:test_new/unvells/app_widgets/app_bar.dart';
import 'package:test_new/unvells/app_widgets/app_text_field.dart';
import 'package:test_new/unvells/app_widgets/custom_button.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/utils.dart';

import '../../../../constants/app_constants.dart';

// class AddPayeeForm extends StatefulWidget {
//   const AddPayeeForm({super.key});
//
//   @override
//   State<AddPayeeForm> createState() => _AddPayeeFormState();
// }
//
// class _AddPayeeFormState extends State<AddPayeeForm> {
//   TextEditingController nameCtrl = TextEditingController();
//   TextEditingController emailCtrl = TextEditingController();
//   TextEditingController confirmCtrl = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: commonAppBar(
//         isElevated: false,
//           isLeadingEnable: true,
//           Utils.getStringValue(context, AppStringConstant.addPayeeTitle), context
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.symmetric(
//             vertical: 5,
//             horizontal: 10
//           ),
//           color: Theme.of(context).cardColor,
//           child: Column(
//             children: [
//               AppTextField(
//                 controller: nameCtrl,
//                 isPassword: false,
//                 hintText: Utils.getStringValue(context, AppStringConstant.name),
//               ),
//               AppTextField(
//                 controller: emailCtrl,
//                 isPassword: false,
//                 hintText: Utils.getStringValue(context, AppStringConstant.emailAddress),
//               ),
//               AppTextField(
//                 controller: confirmCtrl,
//                 isPassword: false,
//                 hintText: Utils.getStringValue(context, AppStringConstant.confirmEmail),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class AddPayeeForm extends StatelessWidget {
//    AddPayeeForm({super.key, TextEditingController? nameCtrl,TextEditingController? emailCtrl, TextEditingController?confirmCtrl });
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title:  Center(
//         child: Text("Enter Payee Details",
//         style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//           fontSize: 16
//         ),),
//       ),
//       content: SingleChildScrollView(
//         child: Column(
//           children: [
//             AppTextField(
//               controller: nameCtrl,
//               isPassword: false,
//               hintText: "Nick Name",
//             ),
//             AppTextField(
//               controller: emailCtrl,
//               isPassword: false,
//               hintText: "Email Address",
//             ),
//             AppTextField(
//               controller: confirmCtrl,
//               isPassword: false,
//               hintText: "Confirm Email",
//             ),
//           ],
//         ),
//       ),
//
//     );
//   }
// }

class AddPayee extends StatefulWidget {
  const AddPayee({super.key, this.onTap, this.name, this.email});
  final Function (String, String)? onTap;
  final String? name;
  final String? email;

  @override
  State<AddPayee> createState() => _AddPayeeState();
}

class _AddPayeeState extends State<AddPayee> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController confirmCtrl = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    if(widget.name != null) {
      nameCtrl.text = widget.name ?? "";
      emailCtrl.text = widget.email ??"";
      confirmCtrl.text = widget.email ?? "";
    }
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),

      title:  Center(
        child: Text("Enter Payee Details",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 16
          ),),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AppTextField(
                isRequired: true,
                controller: nameCtrl,
                isPassword: false,
                hintText: "Nick Name",
                validationMessage: "Please enter some text",
              ),
              AppTextField(
                controller: emailCtrl,
                isPassword: false,
                isRequired: true,
                readOnly: widget.name != null ? true:false,
                hintText: "Email Address",
                validationMessage: "Please enter some text",
              ),
              AppTextField(
                controller: confirmCtrl,
                isPassword: false,
                isRequired: true,
                readOnly: widget.name != null ? true:false,
                hintText: "Confirm Email",
                validation: (value) {
                  if(value != emailCtrl.text) {
                    return "Email must be similar";
                  }else if((value ?? "").isEmpty) {
                    return "Please enter some text";
                  }else{
                    null;
                  }
                },
              ),

              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: AppSizes.deviceWidth,
                  child: CustomButton(onPressed: (){
                    if((_formKey.currentState?.validate() ??false)){
                      widget?.onTap!(nameCtrl.text, confirmCtrl.text);
                      Navigator.of(context).pop();
                    }

                  },
                      title: "Add Payee",
                      // child: const Text("Add Payee"),
                  )
              )
            ],
          ),
        ),
      ),

    );
  }
}


Widget AddPayeeForm (BuildContext context, Function () onTap, {nameCtrl, emailCtrl, confirmCtrl,}){
  return AlertDialog(
    title:  Center(
      child: Text("Enter Payee Details",
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 16
        ),),
    ),
    content: SingleChildScrollView(
      child: Form(
        child: Column(
          children: [
            AppTextField(
              controller: nameCtrl,
              isPassword: false,
              hintText: "Nick Name",
            ),
            AppTextField(
              controller: emailCtrl,
              isPassword: false,
              hintText: "Email Address",

            ),
            AppTextField(
              controller: confirmCtrl,
              isPassword: false,
              hintText: "Confirm Email",
            ),

            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: AppSizes.deviceWidth,
                child: ElevatedButton(onPressed: onTap, child: const Text("Add Payee"))
            )
          ],
        ),
      ),
    ),

  );
}




