/*
 *
  

 *
 * /
 */

// ignore_for_file: file_names, must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/utils.dart';

import '../../../app_widgets/common_widgets.dart';
import '../../../models/productDetail/grouped_data.dart';
import 'group_quantity_view.dart';

class GroupProduct extends StatefulWidget {
  List<GroupedData>? groupedProducts;
  Function(List)? callBack;

  GroupProduct({Key? key, this.groupedProducts, this.callBack})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GroupProductState();
  }
}

class _GroupProductState extends State<GroupProduct> {

  // List newData = [];
  List<dynamic> newData = [];

  @override
  void initState() {
    super.initState();
    getGroupData();
  }

  getGroupData(){
    // List<Data> qtyArray = [];
    newData = [];
    for(int i=0;i<(widget.groupedProducts?.length ?? 0);i++){
      Map<String, dynamic> selectedDataItem = new Map();

      selectedDataItem["id"] = widget.groupedProducts?[i].id.toString()??"";
      selectedDataItem["value"] = widget.groupedProducts?[i].defaultQty??0;
      newData.add(selectedDataItem);

      // newData[widget.groupedProducts?[i].id.toString()??""] = widget.groupedProducts?[i].defaultQty??0;
      // qtyArray.add(Data(id:widget.groupedProducts?[i].id.toString() ,qty: widget.groupedProducts?[i].defaultQty));
      // newData.add(qtyArray[i]);
    }
    if (widget.callBack != null) {
      widget.callBack!(newData);
    }
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body?.text).documentElement?.text ?? '';
    return parsedString;
  }

  @override
  Widget build(BuildContext context) {
    return (widget.groupedProducts?.length ?? 0) > 0
        ? ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: (widget.groupedProducts?.length ?? 0) + 1,
            itemBuilder: (context, i) {
              if (i == 0) {
                return _title();
              } else {
                var product = widget.groupedProducts?[i - 1];
                var price = Row(
                  children: [
                    CommonWidgets().priceText(
                        _parseHtmlString(product?.foramtedPrice ?? "")),
                    const SizedBox(
                      width: AppSizes.spacingNormal,
                    ),
                    // Text(product?.formatedPrice ?? "", style: const TextStyle(
                    //     fontSize: 16, decoration: TextDecoration.lineThrough)),
                  ],
                );

                return GroupQuantityView(
                  title: product?.name ?? '',
                  thumbNail: product?.thumbNail ?? '',
                  qty: product?.defaultQty.toString() ?? "0" /*qtyArray[product?.id.toString() ?? ''].toString()*/,
                  displayImage: true,
                  displayTitle: true,
                  minimum: 0,
                  subTitle: price,
                  callBack: (qty) {
                    setState(() {

                      widget.groupedProducts?[i - 1].defaultQty = int.parse(qty.toString());
                      getGroupData();
                    });
                    if (widget.callBack != null) {
                      widget.callBack!(newData);
                    }
                  },
                );
              }
            })
        : Container();
  }

  Widget _title() {
    return Row(
      children: [
        // Text(Utils.getStringValue(context, AppStringConstant.name)),
        // const Spacer(),
        // Text(Utils.getStringValue(context, AppStringConstant.qty)),
      ],
    );
  }
}
class Data{
  String? id;
  int? qty;

  Data({this.id,this.qty});
  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["productId"] ?? null,
    qty: json["qty"] == null ? null : json["quantity"],
  );
  Map<String, dynamic> toJson() => {
    id.toString(): qty == null ? null : qty,
  };

}
