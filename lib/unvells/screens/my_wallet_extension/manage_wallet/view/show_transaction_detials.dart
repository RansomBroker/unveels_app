import 'package:flutter/material.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/models/wallet_extension_models/view_transaction_model.dart';

import '../../../../helper/utils.dart';
import '../../transfer_waller_amount/view/payee_list_view.dart';

Widget showTransactionDetails (BuildContext context, TransactionData? model) {

  return AlertDialog(
    title: Center(
      child: Text(Utils.getStringValue(context, AppStringConstant.transactionDetails),
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontSize: 16
      ),),
    ),
    content: SingleChildScrollView(
      child: Column(
        children: [
          if(model != null )...[
            rowTextMapping(context, model.amount?.label ?? "Amount", model.amount?.value ?? "0.00"),
            const SizedBox(
              height: 5,
            ),
            rowTextMapping(context, model.order?.label ?? "Reference", model.order?.value?? ""),
            const SizedBox(
              height: 5,
            ),
            rowTextMapping(context, model.action?.label ?? "Action", (model.action?.value ?? "").toUpperCase()),
            const SizedBox(
              height: 5,
            ),
            rowTextMapping(context, model.type?.label ?? "Type", model.type?.value ?? ""),
            const SizedBox(
              height: 5,
            ),
            rowTextMapping(context, model.date?.label ?? "Transaction At", model.date?.value ?? ""),
            const SizedBox(
              height: 5,
            ),
            rowTextMapping(context, model.status?.label ?? "Transaction Status", model.status?.value ?? ""),
            const SizedBox(
              height: 5,
            ),
            rowTextMapping(context, model.note?.label ?? "Transaction Note", model.note?.value?? ""),
            const SizedBox(
              height: 5,
            )
          ]else...[
            Text(Utils.getStringValue(context, AppStringConstant.noDataFound))
          ]

        ],
      ),
    ),
  );
}
