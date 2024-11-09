/*
 *


 *
 * /
 */

// ignore_for_file: file_names, must_call_super, unused_field

import 'package:flutter/material.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/utils.dart';

import '../../../app_widgets/app_multi_select_checkbox.dart';
import '../../../app_widgets/common_widgets.dart';
import '../../../app_widgets/radio_button_group.dart';
import '../../../helper/constants_helper.dart';
import '../../../models/productDetail/bundle_option.dart';
import 'group_quantity_view.dart';

// ignore: must_be_immutable
class BundleOptionsView extends StatefulWidget {
  Function(List<dynamic>)? callBack;
  List<BundleOption>? options = [];
  BundleOptionsView({Key? key, this.options, this.callBack}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _BundleOptionsViewState();
  }
}

class _BundleOptionsViewState extends State<BundleOptionsView> {
  // List newData = [];
  String? currentId;
  var bundleData = <dynamic, dynamic>{};

  // var bundleOption = <dynamic, dynamic>{};
  // var bundleOptionQty = <dynamic, dynamic>{};
  @override
  void initState() {
    getBundleData();
    // TODO: implement initState
    super.initState();
  }

  getBundleData() {
    List<dynamic> mProductParamsJSON = [];
    for (int i = 0; i < (widget.options?.length ?? 0); i++) {
      Map<String, dynamic> mProductParams = new Map();

      // bundleOption[widget.options?[i].optionId?.toString() ?? ''] = widget.options?[i].selectedOption??"1";
      // bundleOptionQty[widget.options?[i].optionId?.toString() ?? ''] = widget.options?[i].selectedQty??"1";

      // qtyArray.add(BundleData(bundleOptionProductId:widget.options?[i].optionId.toString() ,qty: 1,bundleOptionId:widget.options?[i].optionId.toString() ));
      // newData.add(qtyArray[i].toJson());

      mProductParams["id"] = widget.options?[i].optionId?.toString() ?? '';
      mProductParams["value"] = widget.options?[i].selectedOption ?? "1";
      mProductParams["qty"] = widget.options?[i].selectedQty ?? "1";
      mProductParamsJSON.add(mProductParams);
    }

    if (widget.callBack != null) {
      widget.callBack!(mProductParamsJSON);
    }
    print("TEST_LOG--> data$mProductParamsJSON");
  }

  @override
  void didChangeDependencies() {}

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text( Utils.getStringValue(context, AppStringConstant.customizeOptions),style: Theme.of(context).textTheme.titleLarge,),

            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.options?.length ?? 0,
                itemBuilder: (context, index) {
                  var item = widget.options?[index];
                  switch (item?.type ?? '') {
                    case ConstantsHelper.select:
                      return _getTextField(item);
                    case ConstantsHelper.radioText:
                      return _getRadioButtonType(item);
                    case ConstantsHelper.checkBoxText:
                      return _getCheckBoxType(item);
                    case ConstantsHelper.multiSelect:
                      return _getCheckBoxType(item);
                    default:
                      break;
                  }
                  return Container();
                })
          ],
        ));
  }

  Widget _getRadioButtonType(BundleOption? option) {
    return Container(
        // color: Colors.white,
        padding: const EdgeInsets.fromLTRB(
            AppSizes.spacingNormal,
            AppSizes.spacingNormal,
            AppSizes.spacingNormal,
            AppSizes.spacingNormal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              option?.title.toString() ?? '',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(
              height: AppSizes.spacingNormal,
            ),
            Container(
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1.0, style: BorderStyle.solid),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              ),
              child: RadioButtonGroup(
                key: Key(option?.optionId?.toString() ?? ''),
                labels:
                    option?.optionValues?.map((e) => e.title ?? "").toList(),
                /* activeColor: Colors.black,*/ onChange: (label, index) {
                  if ((option?.optionValues?.length ?? 0) > index) {
                    option?.selectedOption =
                        option.optionValues?[index].optionValueId.toString();
                    getBundleData();

                    // bundleOption[option?.optionId?.toString() ?? ''] = option?.optionValues?[index].optionId.toString()??0;
                    // bundleOptionQty[option?.optionId?.toString() ?? ''] = option?.selectedQty.toString()??"0";

                    // _updateQtyValue(int.parse(option?.optionId??"") ?? 0, option?.optionValues?[index].defaultQty ?? 0);
                    // _updateOptions(int.parse(option?.optionId??"") ?? 0,int.parse(option?.optionValues?[index].optionId??"") ?? 0,-1,true);
                  }
                },
              ),
            ),
            GroupQuantityView(
                qty: option?.required.toString() ?? "1",
                callBack: (qty) {
                  option?.selectedQty = qty.toString();
                  getBundleData();
                  // _updateQtyValue(int.parse(option?.optionId??"") ?? 0, qty /*?? 0*/);
                })
          ],
        ));
  }

  Widget _getCheckBoxType(BundleOption? option) {
    return (widget.options?.length ?? 0) > 0
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text(
                  option?.optionValues?.map((e) => e.title).toString() ??
                      "" ??
                      '',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1.0, style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  child: CheckboxGroup(
                    // activeColor: Colors.black,
                    labels: option?.optionValues
                        ?.map((e) => e.title ?? "")
                        .toList(),
                    onChange: (isChecked, label, index, key) {
                      var product = option?.optionValues
                          ?.firstWhere((element) => element.title == label);
                      if (isChecked) {
                        option?.selectedOption = product?.optionValueId ?? "0";
                        getBundleData();

                        // _updateQtyValue(int.parse(option?.optionId??"" )?? 0, product?.defaultQty?.toString() ?? '0');
                        // _updateOptions(int.parse(option?.optionId??"") ?? 0,int.parse(product?.optionId??"") ?? 0,-1,false);
                      } else {
                        // _updateOptions(int.parse(option?.optionId??"") ?? 0,-1,int.parse(product?.optionId??"") ?? 0,false);
                      }
                    },
                  ),
                ),
                GroupQuantityView(
                    qty: option?.required.toString() ?? "1",
                    callBack: (qty) {
                      option?.selectedQty = qty.toString();
                      getBundleData();
                      // _updateQtyValue(int.parse(option?.optionId??"") ?? 0, qty /*?? 0*/);
                    })
              ])
        : Container();
  }

  Widget _getTextField(BundleOption? option) {
    return Container(
        // color: Colors.white,
        padding: const EdgeInsets.fromLTRB(
            AppSizes.spacingNormal,
            AppSizes.spacingNormal,
            AppSizes.spacingNormal,
            AppSizes.spacingNormal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: CommonWidgets().getDropdown(
                  Key(option?.optionId?.toString() ?? ''),
                  context,
                  option?.optionValues?.map((e) => e.title ?? "").toList() ??
                      [],
                  /*  option?.bundleOptionProducts?.map((e) => e.name ?? '').toList() ?? []*/
                  option?.optionValues?.map((e) => e.title).toString(),
                  null,
                  null,
                  option?.optionValues?.map((e) => e.title).toString(),
                  (label, key) {
                var product = option?.optionValues
                    ?.firstWhere((element) => element.title == label);

                option?.selectedOption = product?.optionValueId ?? "0";
                getBundleData();

                // _updateQtyValue(int.parse(option?.optionId??"") ?? 0,product?.defaultQty?.toString() ?? '0');
                // _updateOptions(int.parse(option?.optionId??"") ?? 0,int.parse(product?.optionId??"") ?? 0,-1,true);
              }, false),
            ),
            GroupQuantityView(
                qty: option?.required.toString() ?? "1",
                callBack: (qty) {
                  option?.selectedQty = qty.toString();
                  getBundleData();
                  // _updateQtyValue(int.parse(option?.optionId??"") ?? 0, qty /*?? 0*/);
                })
          ],
        ));
  }

  _updateOptions(int id, int productId, int removeId, bool isReplace) {
    if (bundleData["bundle_options"] != null) {
      if (bundleData["bundle_options"][id.toString()] != null) {
        if (removeId != -1) {}
        (bundleData["bundle_options"]?[id.toString()] as List<dynamic>)
            .remove(removeId);

        if (productId != -1) {
          if (isReplace) {
            bundleData["bundle_options"][id.toString()] = [productId];
          } else {
            (bundleData["bundle_options"][id.toString()] as List<dynamic>)
                .add(productId);
          }
        }
      } else {
        bundleData["bundle_options"][id.toString()] = [productId];
      }
    } else {
      bundleData["bundle_options"] = {
        id.toString(): [productId]
      };
    }
    // if (widget.callBack != null) widget.callBack!(bundleData);
  }

  _updateQtyValue(int id, dynamic qty) {
    if (bundleData["bundle_option_qty"] != null) {
      setState(() {
        (bundleData["bundle_option_qty"]
            as Map<String, dynamic>?)?[id.toString() /*?? ""*/] = qty;
      });
    } else {
      setState(() {
        bundleData["bundle_option_qty"] = {id.toString(): qty};
      });
    }
  }
}

class BundleData {
  String? bundleOptionId;
  String? bundleOptionProductId;
  int? qty;

  BundleData({this.bundleOptionId, this.bundleOptionProductId, this.qty});
  factory BundleData.fromJson(Map<String, dynamic> json) => BundleData(
        bundleOptionId: json["bundleOptionId"] ?? null,
        bundleOptionProductId: json["bundleOptionProductId"] == null
            ? null
            : json["bundleOptionProductId"],
        qty: json["qty"] == null ? null : json["qty"],
      );
  Map<String, dynamic> toJson() => {
        "bundleOptionId": bundleOptionId == null ? null : bundleOptionId,
        "bundleOptionProductId":
            bundleOptionProductId == null ? null : bundleOptionProductId,
        "qty": qty == null ? null : qty,
      };
}
