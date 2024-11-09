/*
 *


 *
 * /
 */

// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/utils.dart';

import '../../../constants/app_constants.dart';
import '../../../models/productDetail/samples.dart';
import 'file_download.dart';


class DownloadProductSample extends StatefulWidget {
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;
  Samples? samples;

  DownloadProductSample({Key? key, this.samples,this.scaffoldMessengerKey}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return _DownloadProductSampleState();
  }
}

class _DownloadProductSampleState extends State<DownloadProductSample> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.paddingNormal),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.samples?.title ?? Utils.getStringValue(context, AppStringConstant.sample), style: Theme
                .of(context)
                .textTheme
                .titleSmall,),
            const SizedBox(height: 8,),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: (widget.samples?.linkSampleData?.length ?? 0),
                itemBuilder: (context, i) {
                  return Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 4),
                      child: InkWell(
                        onTap: () {
                          DownloadFile().downloadPersonalData(
                              widget.samples?.linkSampleData?[i].url ?? "",
                              widget.samples?.linkSampleData?[i].fileName ?? "",
                              widget.samples?.linkSampleData?[i].mimeType ?? "",
                              context);
                        },
                        child: Text(widget.samples?.linkSampleData?[i].sampleTitle ?? '',
                          style: const TextStyle(color: Colors.blue),),
                      ));
                })
          ]),
    );
  }
}