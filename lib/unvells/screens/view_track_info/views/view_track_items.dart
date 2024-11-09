/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/utils.dart';
import '../../../app_widgets/app_dialog_helper.dart';
import '../../../constants/app_constants.dart';
import '../../../models/invoice_view/invoice_view_model.dart';
import '../../../models/shipment_view/shipment_view_model.dart';

Widget ViewTrackItems(BuildContext context, TrackingListData? item) {
  Widget getListItem(String key, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        children: [
          const Text(" "),
          Expanded(child: Text(key)),
          const Text(" "),
          Expanded(
              child: Text(
            value!,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.titleLarge,
          )),
        ],
      ),
    );
  }

  return Container(
    color: Theme.of(context).cardColor,
    child: Padding(
      padding: const EdgeInsets.all(AppSizes.size8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Divider(
            thickness: 1,
            height: 1,
          ),

          const SizedBox(
            height: AppSizes.size16,
          ),

          getListItem(item?.title ?? '', item?.number.toString()),

          const SizedBox(
            height: AppSizes.size16,
          ),

          const Divider(
            thickness: 1,
            height: 1,
          ),
        ],
      ),
    ),
  );
}
