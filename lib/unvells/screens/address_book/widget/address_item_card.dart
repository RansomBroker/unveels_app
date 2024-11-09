/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/helper/app_localizations.dart';

import '../../../constants/app_string_constant.dart';
import '../../../helper/utils.dart';

class AddressItemCard extends StatelessWidget {
  const AddressItemCard({
    required this.address,
    this.onTap,
    this.actions,
    this.defaultAddress=false,
    Key? key,
  }) : super(key: key);

  final String address;
  final Widget? actions;
  final VoidCallback? onTap;
  final bool? defaultAddress;

/*  String? cid;
  String categoryName;
  ViewCard(this.cid,this.categoryName, {Key? key}) : super(key: key);

*/

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: AppSizes.size8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(AppSizes.size8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: AppSizes.deviceWidth * .6,
                      child: Html(
                        data: address,
                        style: {
                          "body": Style(
                            color: const Color(0xFF212529),
                            fontSize: FontSize(14),
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w400,
                            // height: 0,
                          ),
                        },
                      ),
                    ),
                    if(defaultAddress==true)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                           color: const Color(0xffCCFF99)
                        ),
                        child: Text(
                          (Utils.getStringValue(
                              context, AppStringConstant.defaultAddress.localized())),
                          style: KTextStyle.of(context).twelve.copyWith(color: const Color(0xff33AB38)),
                        ),
                      ),
                    )
                  ],
                ),
                // Text(address),
                if (onTap != null)
                  IconButton(
                    // padding: EdgeInsets.zero,
                    icon: const Icon(Icons.more_vert_rounded),
                    onPressed: onTap,
                    color: AppColors.lightGray,
                  )
              ],
            ),
          ),
          // const Divider(
          //   thickness: 0.5,
          //   height: 0.5,
          // ),
          if (actions != null) actions!,
        ],
      ),
    );
  }
}
