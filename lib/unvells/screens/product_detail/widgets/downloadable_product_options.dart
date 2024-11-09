
/*
 *


 *
 * /
 */

// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';

import '../../../app_widgets/app_multi_select_checkbox.dart';
import '../../../constants/app_constants.dart';
import '../../../models/productDetail/links.dart';

class DownloadProductOptions extends StatefulWidget {
  Links? links;
  Function (List, List)? callBack;
  DownloadProductOptions({Key? key, this.links, this.callBack}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return _DownloadProductOptionsState();
  }
}
class _DownloadProductOptionsState extends State<DownloadProductOptions> {
  List<String> selected = [];
  List<dynamic> selectedLinks = [];
  List<dynamic> selectedLinksPrice = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  (widget.links?.linkData?.length ?? 0) > 0 ?
    Container(
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.all(AppSizes.paddingNormal),
      color: Theme
          .of(context)
          .cardColor,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget?.links?.title??"",
              style: Theme
                  .of(context)
                  .textTheme
                  .titleSmall,
            ),

            const SizedBox(height: 8,),
            CheckboxGroup(
              activeColor: Colors.black,
              labels: widget.links?.linkData?.map((e) => ((e.linkTitle ??'') + ' + '+(e.formattedPrice.toString() ?? ''))).toList() ?? [],
              checked: selected,
              onChange: (isChecked, label, index,key) {

                selectedLinks = [];
                selectedLinksPrice = [];

                var list = selected.map((e) => widget.links?.linkData?.firstWhere((element) => ((element.linkTitle ?? '')+ ' + '+(element.formattedPrice.toString() ?? '')) == e).id ?? 0).toList();
                var listPrice = selected.map((e) => widget.links?.linkData?.firstWhere((element) => ((element.linkTitle ?? '')+ ' + '+(element.formattedPrice.toString() ?? '')) == e).price ?? 0).toList();

                list.asMap().forEach((key, value) {
                  selectedLinks.add(value.toString());
                });

                listPrice.asMap().forEach((key, value) {
                  selectedLinksPrice.add(value.toString());
                });

                if(widget.callBack != null) {
                  widget.callBack!(selectedLinks, selectedLinksPrice);
                }
              },
            )        ]),
    )
        : Container();
  }
}