
/*
 *


 *
 * /
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../unvells/constants/app_constants.dart';
import '../../../models/help_admin_chat_model/help_chat_message_model.dart';
Widget commonChatWidget(BuildContext context, String? userName, String? msg, String? timeStamp,HelpChatMessageModel messageList,int? customerId) {
  var isSender = false;
  if(messageList.id != "customer-$customerId") {
    isSender = true;
    print("sender false  $isSender ");
  } else {
    isSender = false;
    print("sender true $isSender ");
  }
   return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: isSender == true ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: isSender == true ? MainAxisAlignment.start : MainAxisAlignment.end,
            children: [
              const SizedBox(width: AppSizes.spacingTiny,),
              Visibility(
                visible: isSender,
                  child:  CircleAvatar(
                    backgroundColor: AppColors.red,
                      child:Text(((userName).toString()[0]??"S"))
                  ),
              ),

          Column(
            crossAxisAlignment: isSender ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: 200),
                child: Card(
                  color: AppColors.lightGray,
                  margin: const EdgeInsets.fromLTRB(
                      AppSizes.spacingGeneric,
                      AppSizes.spacingGeneric,
                      AppSizes.spacingGeneric,
                      AppSizes.linePadding),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSizes.spacingNormal,
                      horizontal: AppSizes.spacingGeneric,
                    ),
                    child: Text(msg ?? '',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).textTheme.bodyLarge?.color),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    8, 0, AppSizes.spacingGeneric, AppSizes.linePadding),
                child: Text(
                  timeStamp ?? '',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 10,
                      color: Theme.of(context).textTheme.bodyLarge?.color),
                ),
              ),
            ],
          ),

            ],
          ),

        ],
      );
}

