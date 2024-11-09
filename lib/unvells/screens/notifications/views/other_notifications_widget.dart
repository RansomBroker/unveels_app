/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/utils.dart';

import '../../../app_widgets/app_bar.dart';
import '../../../constants/app_constants.dart';


class OtherNotificationWidget extends StatefulWidget {
  const OtherNotificationWidget(this.title,this.description, {Key? key}) : super(key: key);

  final String? title;
  final String? description;

  @override
  State<OtherNotificationWidget> createState() => _OtherNotificationWidgetState();
}

class _OtherNotificationWidgetState extends State<OtherNotificationWidget> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:commonAppBar(Utils.getStringValue(context, AppStringConstant.otherNotification), context),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: AppSizes.size8,),
            Padding(
                padding: const EdgeInsets.only(left:AppSizes.size8,right:AppSizes.size8 )
                ,
              child:Text(widget.title??"",
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.displaySmall?.copyWith(
          fontSize: AppSizes.size18,
        ))),
            //_successWidget(context),
            Padding(
              padding: const EdgeInsets.all(AppSizes.size16),
              child: Html(
                data: widget.description
                    ?.trim()
                    .replaceAll(r"\\n", "")
                    .replaceAll(r"\t", ""),
                // onAnchorTap: (link, ctx, _, ele) async {
                //   if (link != null) {
                //     // if (await canLaunch(link)) {
                //     //   launch(link);
                //     // } else {
                //     //   AlertMessage.showWarning(
                //     //     "Error launching url",
                //     //     context,
                //     //   );
                //     // }
                //   } else {
                //     // ignore
                //   }
                // },
              ),
            ),
          ],
        ),
      ),
    );
  }

}
