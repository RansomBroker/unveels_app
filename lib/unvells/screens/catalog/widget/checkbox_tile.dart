/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/models/catalog/layered_data_options.dart';

import '../../../constants/app_constants.dart';
class CheckboxTile extends StatelessWidget {
  const CheckboxTile(this.filter, this.callback, {Key? key}) : super(key: key);

  final LayeredDataOptions? filter;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          filter?.selected = filter?.selected == true ? false : true;
          callback();
        },
        child: Row(
          children: <Widget>[
            Checkbox(
              value: filter?.selected ?? false,
              onChanged: (value) {
                filter?.selected = value;
                callback();
              },
            ),
            const SizedBox(width: AppSizes.size8),
            Text(
              "${filter?.label}",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            )
          ],
        ),
      ),
    );
  }
}
