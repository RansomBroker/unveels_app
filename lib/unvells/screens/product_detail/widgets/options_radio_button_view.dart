/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/helper/app_storage_pref.dart';

import '../../../models/productDetail/product_custom_option.dart';

class OptionsRadioButtonView extends StatefulWidget {
   OptionsRadioButtonView({Key? key,this.variants,this.selectedOption, this.formattedPrice}) : super(key: key);
   List<OptionValues>? variants;
   ValueChanged<String>? selectedOption=(test){};
   String? formattedPrice;
  @override
  _OptionsRadioButtonViewState createState() => _OptionsRadioButtonViewState();
}

class _OptionsRadioButtonViewState extends State<OptionsRadioButtonView> {

  @override
  void initState() {
    // TODO: implement initState
    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    //   widget.selectedOption!(widget.variants?[0].optionId as String);
    // });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return _buildRadio(0,widget.variants);
  }
  Widget _buildRadio(int attributeId, List<OptionValues>? data) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: List.generate(
      data?.length??0,
          (index) {
            String optionString = data?[index].title ?? "";

            if (data?[index].defaultPriceType == "fixed") {
              optionString += "  +" + (data?[index].formattedDefaultPrice??"");
            }  else {
              optionString += "  +" + (data?[index].formattedDefaultPrice??"");
              var price = double.parse(widget.formattedPrice.toString()??"0");
              var pattern = appStoragePref.getPricePattern()??"";
              // var precision = appStoragePref.getPrecision();
              var defPrice = data?[index].defaultPrice??0.0;
              price = price * double.parse(defPrice.toString()) / 100;

              // var precisionFormat = "%." + precision.toString() + "f";
              // var formattedPrice = String.for(precisionFormat, price)
              // val newPattern = pattern?.replace("%s".toRegex(), formattedPrice)


              var newPattern = pattern.replaceAll("%s", price.toString());
              optionString += " +$newPattern";

            }
        return RadioListTile<String>(
          dense: true,
          contentPadding: EdgeInsets.zero,
          selected: data?[index].isSelected ?? false,
          title: Text(
            optionString,style: Theme.of(context).textTheme.bodyLarge,
          ),
          activeColor: Colors.black,
          value: data?[index].title ?? "",
          groupValue: (data?[index].isSelected ?? false) ? (data?[index].title) : "",
          onChanged: (value) {
            for (OptionValues d in data!) {
              d.isSelected = false;
            }
            data[index].isSelected = true;
            setState(() {
              widget.selectedOption!(data[index].optionTypeId as String);
            });
            //todo
          },
        );
      },
    ),
  );

}
