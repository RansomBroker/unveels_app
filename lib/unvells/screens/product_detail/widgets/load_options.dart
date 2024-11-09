/*
 *


 *
 * /
 */

import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../app_widgets/widget_space.dart';
import '../../../constants/app_constants.dart';
import '../../../models/productDetail/product_custom_option.dart';
import 'options_checkbox_view.dart';
import 'options_edit_text_view.dart';
import 'options_radio_button_view.dart';
import 'options_spinner_view.dart';

class LoadOptions extends StatefulWidget {
  List<ProductCustomOption>? options;
  ValueChanged<List<dynamic>>? productOptions;
  // List<ProductCustomOption>? selectedOptions;

  String? formattedPrice;

  LoadOptions({
    Key? key,
    this.options,
    this.productOptions,
    this.formattedPrice,
    /*this.selectedOptions*/
  }) : super(key: key);

  @override
  _LoadOptionsState createState() => _LoadOptionsState();
}

class _LoadOptionsState extends State<LoadOptions> {
  Map<String, dynamic> productOptions = {};
  @override
  void initState() {
    //isDefaultOptions();
    super.initState();
  }

  void setOptionData() {
    List<dynamic> optionItemsData = [];
    productOptions.forEach((key, value) {
      Map<String, dynamic> optionlistItem = {};
      optionlistItem["id"] = key;
      optionlistItem["value"] = value;
      if (value is List) {
        optionlistItem["value"] = value;
      } else {
        List<dynamic> options = [];
        options.add(value);
        optionlistItem["value"] = options;
      }
      optionItemsData.add(optionlistItem);
      widget.productOptions!(optionItemsData);
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("TEST_LOG==> options ==> ${widget.options}");
    return Container(
      color: Theme.of(context).cardColor,
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.spacingNormal,
          vertical: AppSizes.spacingGeneric),
      child: ListView.builder(
        itemBuilder: (BuildContext context, int i) {
          Widget variationWidget;
          debugPrint("TEST_LOG==> type ==> ${widget.options?[i].type}");
          switch (widget.options?[i].type) {
            case "drop_down":
              //Spinner View;
              variationWidget = OptionsSpinnerView(
                /*options: widget.options,
                selectedOptions: widget.selectedOptions,*/
                variants: widget.options?[i].optionValues,
                formattedPrice: widget.formattedPrice,
                selectedOption: (String val) {
                  print("TEST_LOG ==> val ==>  ${val}");
                  setState(() {
                    productOptions["${widget.options?[i].optionId}"] = val;
                    setOptionData();
                    // widget.productOptions!(productOptions);
                  });
                },
              );
              break;
            case "radio":
              //RadioView
              variationWidget = OptionsRadioButtonView(
                  variants: widget.options?[i].optionValues,
                  formattedPrice: widget.formattedPrice,
                  selectedOption: (String val) {
                    print("hjvdhg radio${val}");
                    setState(() {
                      productOptions["${widget.options?[i].optionId}"] = val;
                      setOptionData();
                      // widget.productOptions!(productOptions);
                    });
                  });
              break;
            case "checkbox":
              //CheckBoxView
              variationWidget = OptionsCheckBoxView(
                  /*options: widget.options,*/
                  /*selectedOptions: widget.selectedOptions,*/
                  variants: widget.options?[i].optionValues,
                  formattedPrice: widget.formattedPrice,
                  selectedOption: (selectedVal) {
                    setState(() {
                      print("hjvdhg${selectedVal[0]} ${selectedVal[1]}");
                      var selectedCheckBoxes = [];

                      if (widget.options?[i].optionValues?[selectedVal[1]]
                              .isSelected ??
                          false) {
                        widget.options?[i].optionValues?[selectedVal[1]]
                            .isSelected = false;
                      } else {
                        widget.options?[i].optionValues?[selectedVal[1]]
                            .isSelected = true;
                      }
                      widget.options?[i].optionValues?.forEach((element) {
                        if (element.isSelected ?? false) {
                          selectedCheckBoxes
                              .add(element.optionTypeId.toString());
                        }
                      });

                      productOptions["${widget.options?[i].optionId}"] =
                          selectedCheckBoxes;
                      setOptionData();
                      // widget.productOptions!(productOptions);
                    });
                  });
              break;
            case "multiple":
              //CheckBoxView
              variationWidget = OptionsCheckBoxView(
                  /*options: widget.options,*/
                  /*selectedOptions: widget.selectedOptions,*/
                  variants: widget.options?[i].optionValues,
                  formattedPrice: widget.formattedPrice,
                  selectedOption: (selectedVal) {
                    setState(() {
                      print("hjvdhg${selectedVal[0]} ${selectedVal[1]}");
                      var selectedCheckBoxes = [];

                      if (widget.options?[i].optionValues?[selectedVal[1]]
                              .isSelected ??
                          false) {
                        widget.options?[i].optionValues?[selectedVal[1]]
                            .isSelected = false;
                      } else {
                        widget.options?[i].optionValues?[selectedVal[1]]
                            .isSelected = true;
                      }
                      widget.options?[i].optionValues?.forEach((element) {
                        if (element.isSelected ?? false) {
                          selectedCheckBoxes
                              .add(element.optionTypeId.toString());
                        }
                      });

                      productOptions["${widget.options?[i].optionId}"] =
                          selectedCheckBoxes;
                      setOptionData();
                      // widget.productOptions!(productOptions);
                    });
                  });
              break;
            case "field":
              //EditTextView
              variationWidget = OptionsEditTextView(textData: (String val) {
                print("TEST_LOG --> ${val}");
                setState(() {
                  productOptions["${widget.options?[i].optionId}"] = val;
                  setOptionData();
                  // widget.productOptions!(productOptions);
                });
              });
              break;
            case "area":
              //EditTextView
              variationWidget = OptionsEditTextView(textData: (String val) {
                print("TEST_LOG --> ${val}");
                setState(() {
                  productOptions["${widget.options?[i].optionId}"] = val;
                  setOptionData();
                  // widget.productOptions!(productOptions);
                });
              });
              break;
            // case "F":
            // //EditTextView
            //   variationWidget = OptionsEditTextView();
            //   break;
            default:
              variationWidget = Container();
              break;
          }
          log("selected options:::${productOptions}");
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widgetSpace(),
              Text(
                widget.options?[i].title ?? "",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              widgetSpace(0, AppSizes.spacingGeneric),
              variationWidget,
            ],
          );
        },
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: widget.options?.length,
      ),
    );
  }
}
