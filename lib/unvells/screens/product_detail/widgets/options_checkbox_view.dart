/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';

import '../../../helper/app_storage_pref.dart';
import '../../../models/productDetail/product_custom_option.dart';

class OptionsCheckBoxView extends StatefulWidget {
  OptionsCheckBoxView(
      {Key? key,
      this.variants,
      /*this.options,*/
      required this.selectedOption,
      formattedPrice,
      /*this.selectedOptions*/})
      : super(key: key);
  List<OptionValues>? variants;
  ValueChanged<dynamic> selectedOption;
  String? formattedPrice;

  @override
  _OptionsCheckBoxViewState createState() => _OptionsCheckBoxViewState();
}

class _OptionsCheckBoxViewState extends State<OptionsCheckBoxView> {
  var selectedCheckBoxes = [];

  getItems() {
    widget.variants?.forEach((element) {
      if (element.isSelected == true) {
        selectedCheckBoxes.add(element.title);
      }
    });
    print(selectedCheckBoxes);
    selectedCheckBoxes.clear();
  }
  @override
  void initState() {
    // TODO: implement initState
    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    //   widget.selectedOption([widget.variants?[0].optionTypeId as String,0]);
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getItems();
    return _buildCheckBox(widget.variants);
    //use below code for multi selection checkbox
    /*ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: widget.variants?.map((Variant variant) {
<<<<<<< HEAD
        String optionString = variant.variantName??"";
        double priceToAdd = double.parse(variant.modifier.toString());
        if ((priceToAdd) != 0) {
          optionString += "  (+" + (variant.modifierType=="P" ? double.parse(variant.modifierType??"").toString() : variant.formatModifier??"")
              + (variant.modifierType=="P" ? "%" : "")
              + ")";
        }
=======
            String optionString = variant.variantName ?? "";
            double priceToAdd = double.parse(variant.modifier.toString());
            if ((priceToAdd) != 0) {
              optionString += "  (+" +
                  (variant.modifierType == "P"
                      ? double.parse(variant.modifierType ?? "").toString()
                      : variant.formatModifier ?? "") +
                  (variant.modifierType == "P" ? "%" : "") +
                  ")";
            }
>>>>>>> 79452143e122d4e018242e4da963d52ac8a82d19
            return CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                optionString,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              value: variant.isSelected ?? false,
              activeColor: Colors.black,
              checkColor: Colors.grey,
              onChanged: (value) {
                setState(() {
                  variant.isSelected = value!;
                  widget.selectedOption!(variant.variantId as String);
                });
              },
            );
          }).toList() ??
          [],
    );*/
  }

  Widget _buildCheckBox(List<OptionValues>? data) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          data?.length ?? 0,
          (index) {
            String optionString = data?[index].title ?? "";

            if (data?[index].defaultPriceType == "fixed") {
              optionString += "  +" + (data?[index].formattedDefaultPrice??"");
            }  else {
              optionString += "  +" + (data?[index].formattedDefaultPrice??"");
              var price = double.parse(widget.formattedPrice.toString()??"0");
              var pattern = appStoragePref.getPricePattern()??"";
              var defPrice = data?[index].defaultPrice??0.0;
              price = price * double.parse(defPrice.toString()) / 100;

              var newPattern = pattern.replaceAll("%s", price.toString());
              optionString += " +$newPattern";

            }

            return CheckboxListTile(
              dense: true,
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              selected: data?[index].isSelected ?? false,
              title: Text(
                optionString,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              activeColor: Colors.black,
              value: data?[index].isSelected ?? false,
              onChanged: (value) {
                widget.selectedOption([data![index].optionTypeId as String,index]);

                //todo
              },
            );
          },
        ),
      );

}
