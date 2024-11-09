/*
 *


 *
 * /
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_string_constant.dart';
import '../../../helper/app_localizations.dart';

class Newsletter extends StatefulWidget {
  Function(String) newsletter;
  String selectedId;//-----Pass 1 for yes -------- Pass 0 for no--------//
  bool? showHeading;
  String translationKey;

  Newsletter(this.newsletter, this.translationKey,{this.selectedId ="3", this.showHeading});

  @override
  State<StatefulWidget> createState() {
    return _NewsletterState();
  }
}

class _NewsletterState extends State<Newsletter> {
  AppLocalizations? localizations;
  var selectedId = "2";

  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    selectedId = widget.selectedId;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if(widget.showHeading==true)
        Expanded(
          child: Text(
            localizations?.translate(widget.translationKey) ?? "",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Expanded(
          child: RadioListTile(
            visualDensity: VisualDensity.compact,
            title: Text(
              localizations?.translate(AppStringConstant.yes) ?? "",
            ),
            value: "1",
            groupValue: selectedId,
            onChanged: (value) {
              setState(() {
                selectedId = "1";
                print("huiuihi---$value");
                widget.newsletter(value as String);
              });
            },
            dense: true,
            contentPadding: EdgeInsets.zero,
          ),
        ),
        Expanded(
          child: RadioListTile(
            title: Text(
              localizations?.translate(AppStringConstant.no) ?? "",
            ),
            value: "0",
            groupValue: selectedId,
            onChanged: (value) {
              setState(() {
                selectedId = "0";
                print("huiuihi---$value");
                widget.newsletter(value as String);
              });
            },
            dense: true,
            contentPadding: EdgeInsets.zero,
          ),
        ),
        // const Expanded(child: SizedBox())
      ],
    );
  }
}
