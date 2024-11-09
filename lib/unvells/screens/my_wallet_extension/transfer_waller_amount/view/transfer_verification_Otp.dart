import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constants/app_string_constant.dart';
import '../../../../helper/utils.dart';

Widget showOtpScreen(BuildContext context, Function(String) callback) {
  String otp = "";
  return Stack(
    children: [
      AlertDialog(
        title: Center(
          child: Text(
            Utils.getStringValue(context, AppStringConstant.enterOtp),
            style:
                Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16),
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                onChanged: (value) {
                  otp = value;
                },
                decoration: InputDecoration(
                  hintText:
                      Utils.getStringValue(context, AppStringConstant.enterOtp),
                ),
              )
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                if((otp ?? "") != ""){
                  callback(otp);
                }
              },
              child: Text(
                Utils.getStringValue(context, AppStringConstant.ok),
                style: Theme.of(context).textTheme.bodyLarge,
              )),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                Utils.getStringValue(context, AppStringConstant.cancel),
                style: Theme.of(context).textTheme.bodyLarge,
              )),
        ],
      )
    ],
  );
}
