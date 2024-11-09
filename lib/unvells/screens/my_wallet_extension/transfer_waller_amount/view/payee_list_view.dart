import 'package:flutter/material.dart';
import 'package:test_new/unvells/configuration/text_theme.dart';
import 'package:test_new/unvells/constants/app_constants.dart';

import '../../../../constants/app_string_constant.dart';
import '../../../../helper/utils.dart';
import '../../../../models/wallet_extension_models/wallet_dashboard_model.dart';

Widget payeeListView(BuildContext context, List<PayeeList> list,
    Function(PayeeList) updateCallback, Function(PayeeList) deleteCallback) {
  return SizedBox(
    height: AppSizes.deviceHeight - 310,
    child: ListView.builder(
      itemCount: list.length,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var item = list[index];
        return Container(
          color: Theme.of(context).cardColor,
          child: ListTile(
            visualDensity: const VisualDensity(horizontal: -2, vertical: -4),
            title: Text(
              item.name ?? "",
              style: Theme.of(context)
                  .textTheme
                  ?.bodyLarge
                  ?.copyWith(fontSize: 14),
            ),
            subtitle: Column(
              children: [
                rowTextMapping(
                    context,
                    Utils.getStringValue(
                            context, AppStringConstant.emailAddress) ??
                        "",
                    item.email ?? ""),
                rowTextMapping(
                    context,
                    Utils.getStringValue(context, AppStringConstant.status) ??
                        "",
                    item.status ?? ""),
              ],
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    updateCallback(item);
                  },
                  child: const Icon(
                    Icons.edit,
                    size: 20,
                    color: AppColors.gold,
                  ),
                ),
                // SizedBox(
                //   height: 1,
                // ),
                GestureDetector(
                  onTap: () {
                    deleteCallback(item);
                  },
                  child: const Icon(Icons.delete_outline, size: 20),
                )
              ],
            ),
          ),
        );
      },
    ),
  );
}

Widget rowTextMapping(
  context,
  title,
  body,
) {
  return Container(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text("$title : ", style: KTextStyle.of(context).boldTwelve),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          flex: 2,
          child: Text(
            body,
            style:
                Theme.of(context).textTheme?.bodyMedium?.copyWith(fontSize: 14),
          ),
        )
      ],
    ),
  );
}
