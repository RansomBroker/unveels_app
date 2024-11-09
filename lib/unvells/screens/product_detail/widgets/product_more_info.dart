/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/utils.dart';
import 'package:test_new/unvells/models/productDetail/additional_information.dart';

import '../../../configuration/text_theme.dart';

// productInfo(
//   BuildContext context,
// ) {
//   return
// }

class productInfo extends StatefulWidget {
  const productInfo({super.key,this.additionalInfo});

 final List<AdditionalInformation>? additionalInfo;




  @override
  State<productInfo> createState() => _productInfoState();
}

class _productInfoState extends State<productInfo> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme
          .of(context)
          .cardColor,
      padding: const EdgeInsets.symmetric(horizontal: 24.0),

      // margin: const EdgeInsets.only(top: AppSizes.size8),
      child: ExpansionTile(

          initiallyExpanded: true,
          trailing: Icon(_isExpanded ? Icons.minimize : Icons.add),
          // initiallyExpanded: _isExpanded,
          onExpansionChanged: (bool expanded) {
            setState(() {
              _isExpanded = expanded;
            });
          },
          iconColor: Colors.black,
          shape: const Border(),
          title: Text(
              Utils.getStringValue(
                  context, AppStringConstant.moreInformation) ??
                  '',
              style:  KTextStyle.of(context).semiBoldSixteen),
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.additionalInfo?.length ?? 0,
              padding: EdgeInsets.zero,

              itemBuilder: (context, index) {
                return IntrinsicHeight(
                  child: Row(
                    children: [
                      SizedBox(
                        width: (AppSizes.deviceWidth / 3) - AppSizes.size16,
                        child: Text(
                          widget.additionalInfo?[index].label ?? '',
                          textAlign: TextAlign.right,
                          style:  KTextStyle.of(context).twelve,
                        ),
                      ),
                      // Container(
                      //   padding: const EdgeInsets.symmetric(horizontal: AppSizes.size8),
                      //   width: 2, color: Colors.blue,),
                      VerticalDivider(
                        thickness: 0.5,
                        color: Theme
                            .of(context)
                            .dividerColor,
                        width: AppSizes.size16,
                      ),
                      Text(
                        widget.additionalInfo?[index].value ?? '',
                        textAlign: TextAlign.left,
                        style:  KTextStyle.of(context).twelve,

                      )
                      // SizedBox(
                      //     width: ((AppSizes.deviceWidth *2)/3) - AppSizes.size16,
                      //     child: Html(data: additionalInfo?[index].value ?? '')),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 2,
                );
              },
            )
          ]),
    );
  }
}
