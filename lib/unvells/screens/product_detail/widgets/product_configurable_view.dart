/*
 *


 *
 * /
 */

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_new/unvells/app_widgets/image_view.dart';
import 'package:test_new/unvells/models/productDetail/attributes.dart';
import 'package:test_new/unvells/models/productDetail/swatch_data.dart';
import 'package:test_new/unvells/screens/product_detail/bloc/product_detail_screen_events.dart';
import 'package:test_new/unvells/screens/product_detail/bloc/product_detail_screen_state.dart';

import '../../../constants/app_constants.dart';
import '../../../helper/app_localizations.dart';
import '../../../helper/extension.dart';
import '../../../models/productDetail/configurable_data.dart';
import '../../../models/productDetail/product_attributes_options.dart';
import '../bloc/product_detail_screen_bloc.dart';

class ProductConfigurableView extends StatefulWidget {
  ProductDetailScreenBloc? productPageBloc;
  String productId;
  String typeId;
  ConfigurableData? data;

  ProductConfigurableView(
      this.productPageBloc, this.productId, this.typeId, this.data,
      {Key? key});

  @override
  State<StatefulWidget> createState() => _ProductConfigurableViewState();
}

class _ProductConfigurableViewState extends State<ProductConfigurableView> {
  AppLocalizations? _localizations;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<Attributes> attributeList = widget.data?.attributes ?? [];
    return Container(
      color: Theme.of(context).cardColor,
      width: AppSizes.deviceWidth,
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...attributeList.map((attribute) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Padding(
                //   padding: const EdgeInsets.only(
                //       top: AppSizes.linePadding, bottom: AppSizes.linePadding),
                //   child: Text(
                //     attribute.label ?? "",
                //     style: Theme.of(context).textTheme.titleMedium,
                //   ),
                // ),
                (attribute.swatchType == "visual" ||
                        attribute.swatchType == "text")
                    ? addVisualTypeSwatch(attributeList.indexOf(attribute),
                        attribute, widget.data?.swatchData ?? "")
                    : addDropDownTypeOptions(attributeList.indexOf(attribute),
                        attribute, widget.data?.swatchData ?? ""),
                const SizedBox(height: AppSizes.spacingNormal),
              ],
            );
          })
        ],
      ),
    );
  }

  Widget addVisualTypeSwatch(
      int attributeIndex, Attributes attributes, String swatchData) {
    List<SwatchData> attributeSwatchData = [];
    try {
      var mainSwatchDataObject = json.decode(swatchData);
      var eachOptionData = mainSwatchDataObject[attributes.id.toString()];

      attributes.options?.forEach((element) {
        var keys = eachOptionData[element.id.toString()];

        SwatchData swatchData = SwatchData();
        swatchData.id = element.id;
        swatchData.type = keys["type"];
        swatchData.value = keys["value"];
        swatchData.isSelected = widget
                .data
                ?.attributes?[attributeIndex]
                .options?[attributes.options?.indexOf(element) ?? 0]
                .swatchData
                ?.isSelected ??
            false;

        // cartData?.optionItems?.forEach {
        //   if (it.valueIds?.contains(key) == true) {
        //     swatchData.isSelected = true
        //   }
        // }
        attributeSwatchData.add(swatchData);
        widget
            .data
            ?.attributes?[attributeIndex]
            .options?[attributes.options?.indexOf(element) ?? 0]
            .swatchData = swatchData;
      });
    } catch (e) {
      print(e);
    }
    return Wrap(
      alignment: WrapAlignment.start,

      spacing: 5,
      runSpacing: 9,
      children: List.generate(attributeSwatchData.length, (index) {
        String text = "";
        String color = "";
        if (attributes.swatchType != "visual") {
          text = attributeSwatchData[index].value ?? "";
        } else if (attributeSwatchData[index].type.toString() == "1") {
          color = attributeSwatchData[index].value ?? "FFFFFF";
        } else {
          color = "FFFFFF";
        }
        if (color.isEmpty) {
          color = "FFFFFF";
        }
        return InkWell(
          onTap: () {
            for (SwatchData d in attributeSwatchData) {
              widget
                  .data
                  ?.attributes?[attributeIndex]
                  .options?[attributeSwatchData.indexOf(d)]
                  .swatchData
                  ?.isSelected = false;
            }
            widget.data?.attributes?[attributeIndex].options?[index].swatchData
                ?.isSelected = true;
            widget.productPageBloc?.add(const UpdatePriceEvent());
            setState(() {});
          },
          child: (attributeSwatchData[index].type.toString() == "2")
              ? _imageContainer(
                  widget.data?.attributes?[attributeIndex].options?[index]
                          .swatchData?.isSelected ??
                      false,
                  imageUrl: attributeSwatchData[index].value ?? "")
              : _colorContainer(
                  widget.data?.attributes?[attributeIndex].options?[index]
                          .swatchData?.isSelected ??
                      false,
                  size: text,
                  color: HexColor.fromHex(color)),
        );
      }),
    );
  }

  Widget _colorContainer(bool isSelected, {String? size, Color? color}) {
    return Container(
      height: AppSizes.size34,
      // width: (AppSizes.size34),
      decoration: (size != null)
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              border: Border.all(
                color: isSelected ? AppColors.gold : const Color(0xffDADADA),
              ),
              color: isSelected ? Colors.white : const Color(0xffF0F0F0),
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(isSelected ? 25 : 20),
              border: Border.all(
                  color: isSelected ? AppColors.gold : Colors.transparent,
                  width: 3),
              color: (color != null) ? color : AppColors.white,
            ),
      child: (size != null)
          ? FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  size,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color:isSelected? Colors.black:null,
                      ),
                ),
              ),
            )
          : null,
    );
  }

  Widget _imageContainer(bool isSelected, {String? imageUrl}) {
    return Card(
      elevation: 4,
      child: Container(
        height: AppSizes.size34,
        width: (AppSizes.size34 + AppSizes.paddingNormal),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isSelected ? 8 : 3),
          border: Border.all(
              color: isSelected
                  ? Theme.of(context).primaryColorDark
                  : Theme.of(context).dividerColor),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: CachedNetworkImage(
            imageUrl: imageUrl ?? '',
            height: AppSizes.size34,
            width: (AppSizes.size34 + AppSizes.paddingNormal),
            fit: BoxFit.fill,
            placeholder: (context, url) => Container(
              height: AppSizes.size34,
              width: (AppSizes.size34 + AppSizes.paddingNormal),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                    image: AssetImage(
                  AppImages.placeholder,
                )),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              height: AppSizes.size34,
              width: (AppSizes.size34 + AppSizes.paddingNormal),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                    image: AssetImage(
                  AppImages.placeholder,
                )),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget addDropDownTypeOptions(
      int attributeIndex, Attributes attributes, String swatchData) {
    List<String> spinnerOptions = [];
    spinnerOptions.add(widget.data?.chooseText ?? "");

    attributes.options?.forEach((element) {
      spinnerOptions.add(element.label ?? "");
    });

    try {
      attributes.options?.forEach((element) {
        SwatchData swatchData = SwatchData();
        swatchData.id = element.id;
        swatchData.isSelected = widget
                .data
                ?.attributes?[attributeIndex]
                .options?[attributes.options?.indexOf(element) ?? 0]
                .swatchData
                ?.isSelected ??
            false;
        widget
            .data
            ?.attributes?[attributeIndex]
            .options?[attributes.options?.indexOf(element) ?? 0]
            .swatchData = swatchData;
      });
    } catch (e) {
      print(e);
    }

    return DropdownButtonFormField<String>(
      value: widget.data?.chooseText ?? "",
      decoration: const InputDecoration(
        isDense: true,
        focusedBorder: OutlineInputBorder(),
        border: OutlineInputBorder(),
      ),
      menuMaxHeight: AppSizes.deviceHeight / 2,
      items: (spinnerOptions ?? []).map((String optionData) {
        return DropdownMenuItem(
          value: optionData,
          child: Text(
            optionData ?? "",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      }).toList(),
      onChanged: (value) {
        if (spinnerOptions.indexOf(value ?? "") > 0) {
          for (int i = 1; i < spinnerOptions.length; i++) {
            widget.data?.attributes?[attributeIndex].options?[i - 1].swatchData
                ?.isSelected = false;
          }
          widget
              .data
              ?.attributes?[attributeIndex]
              .options?[spinnerOptions.indexOf(value ?? "") - 1]
              .swatchData
              ?.isSelected = true;
          widget.productPageBloc?.add(const UpdatePriceEvent());
          setState(() {});
        }
      },
      validator: (value) {
        if (value == null) {
          // add validation with return statement
          // widget.productPageBloc?.emit(ProductDetailScreenErrorAlert(AppStringConstant.selectConfigurableOptionsMsg));
        }
      },
    );
  }
}
