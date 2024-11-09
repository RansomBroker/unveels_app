/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';

import '../../../constants/app_constants.dart';
import '../../../helper/app_storage_pref.dart';
import '../../../models/productDetail/product_custom_option.dart';

class OptionsSpinnerView extends StatefulWidget {
  OptionsSpinnerView({Key? key,this.variants,this.selectedOption, formattedPrice /*,this.selectedOptions*//*,this.options*/}) : super(key: key);
  List<OptionValues>? variants;
  ValueChanged<String>? selectedOption=(test){};
  String? formattedPrice;
  // List<CombinationOptionVariant>? selectedOptions;
  // List<ProductCustomOption>? options;
  @override
  _OptionsSpinnerViewState createState() => _OptionsSpinnerViewState();
}

class _OptionsSpinnerViewState extends State<OptionsSpinnerView> {
  String selectedVariant = "";

  // String getSelectedValue(){
  //   for (OptionValues v in widget.variants??[]) {
  //     if (v.isSelected??false) {
  //       selectedVariant = v.title??"";
  //     }
  //    // selectedVariant = v.variantName??"";
  //   }
  //   return selectedVariant;
  // }
  @override
  void initState() {
    // getSelectedValue();
    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    //   widget.selectedOption!(widget.variants?[0].optionTypeId??"");
    // });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        width: double.infinity,
        decoration: const ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1.0, style: BorderStyle.solid),
            borderRadius: BorderRadius.all(Radius.circular(0.0)),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.spacingGeneric),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            items: widget.variants?.map((OptionValues value) {
              String optionString = value.title??"";
              if (value.defaultPriceType == "fixed") {
                optionString += "  +" + (value.formattedDefaultPrice??"");
              }  else {
                optionString += "  +" + (value.formattedDefaultPrice??"");
                var price = double.parse(widget.formattedPrice.toString()??"0");
                var pattern = appStoragePref.getPricePattern()??"";
                // var precision = appStoragePref.getPrecision();
                var defPrice = value.defaultPrice??0.0;
                price = price * double.parse(defPrice.toString()) / 100;

                // var precisionFormat = "%." + precision.toString() + "f";
                // var formattedPrice = String.for(precisionFormat, price)
                // val newPattern = pattern?.replace("%s".toRegex(), formattedPrice)


                var newPattern = pattern.replaceAll("%s", price.toString());
                optionString += " +$newPattern";

              }
              return DropdownMenuItem(
                child: Text(optionString),
                value: value.optionTypeId,
              );
            }).toList(),
            // isExpanded: true,
            hint: Text(
              selectedVariant,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            style: Theme.of(context).textTheme.bodyLarge,
            onChanged: (newValue) async {
              widget.variants?.forEach((element) {
                if(newValue==element.optionTypeId){
                  setState(() {
                    selectedVariant = element.title??"";
                    widget.selectedOption!(newValue as String);
                  });
                }
              });
              // setState(() {
              //   selectedVariant = newValue as String;
              //   widget.selectedOption!(newValue as String);
              // });
            },
          ),
        ));
  }


}
