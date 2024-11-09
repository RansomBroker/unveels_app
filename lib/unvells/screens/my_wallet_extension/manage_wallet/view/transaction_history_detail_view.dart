import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/models/wallet_extension_models/wallet_dashboard_model.dart';

import '../../../../constants/app_string_constant.dart';
import '../../../../helper/utils.dart';
import '../../../../models/wallet_extension_models/transaction_history_model.dart';

Widget transactionHistoryDetailView (BuildContext context, List<TransactionList> transaction, Function (TransactionList) getDetails) {
  return Column(
    children: [
      Container(
        color: Theme.of(context).cardColor,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Expanded(
             flex: 2,
             child: Text(Utils.getStringValue(context, AppStringConstant.description,),
             style: Theme.of(context).textTheme.bodyLarge?.copyWith(
               fontWeight: FontWeight.w500,
               fontSize: 14
             ),),
           ),
           Expanded(
             child: Text(Utils.getStringValue(context, AppStringConstant.creditDebit,),
             style: Theme.of(context).textTheme.bodyLarge?.copyWith(
               fontWeight: FontWeight.w500,
                 fontSize: 14
             ),),
           ),
           Expanded(
             child: Center(
               child: Text(Utils.getStringValue(context, AppStringConstant.status,),
               style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                 fontWeight: FontWeight.w500,
                   fontSize: 14
               ),),
             ),
           ),
         ],
        ),
      ),
      const SizedBox(
        height: 4,
      ),
      SizedBox(
        height: AppSizes.deviceHeight - 390,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: transaction.length,
            itemBuilder: (context, index) {
            var item = transaction[index];
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                color: Theme.of(context).cardColor,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text.rich(
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          TextSpan(
                              text: (item.description ?? "").substring(0, ((item.description ?? "").indexOf("#"))),
                              children: [
                               TextSpan(
                                 text: (item.description ?? "").substring((item.description ?? "").indexOf("#")),
                                 style: Theme.of(context).textTheme?.bodyLarge?.copyWith(
                                   fontSize: 14,
                                   color: Theme.of(context).buttonTheme.colorScheme?.background
                                 ),
                                 recognizer: TapGestureRecognizer()..onTap = () {
                                   getDetails(item);
                                 }
                               )
                              ]
                          )
                      ),


                      // Text(item.description ?? "",
                      //   maxLines: 2,
                      //   overflow: TextOverflow.ellipsis,
                      //   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      //       fontSize: 14
                      //   ),),
                    ),
                    Expanded(
                      child: Text( (item.debit ?? "") == "" ? item.credit ?? "":item.debit ?? "",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12,
                          color: (item.debit ?? "") == "" ? Colors.green : Colors.red
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(item.status ?? "",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 14
                          ),),
                      ),
                    ),
                  ],
                ),
              );
            },
        ),
      )
    ],
  );
}