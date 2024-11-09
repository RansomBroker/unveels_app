/*
 *


 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/app_widgets/app_dialog_helper.dart';
import 'package:test_new/unvells/app_widgets/flux_image.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/helper/app_localizations.dart';
import '../../../constants/app_string_constant.dart';

class QuantityChanger extends StatefulWidget {
  const QuantityChanger(this.onQuantityChange, this.initialValue,
      {super.key, this.isFromHome = false});

  final ValueChanged<int> onQuantityChange;
  final int? initialValue;
  final bool? isFromHome;

  @override
  _QuantityChangerState createState() => _QuantityChangerState();
}

class _QuantityChangerState extends State<QuantityChanger> {
  late int _value;
  late AppLocalizations? _localizations;

  @override
  void initState() {
    _value = widget.initialValue ?? 1;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  void _incrementQuantity() {
    setState(() {
      _value++;
    });
    widget.onQuantityChange(_value);
  }

  void _decrementQuantity() {
    if (_value > 1) {
      setState(() {
        _value--;
      });
    } else {
      // Handle the delete logic here
      widget.onQuantityChange(0);
    }
    widget.onQuantityChange(_value);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.deviceHeight * .055,
      width: AppSizes.deviceWidth * .3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.isFromHome == false) ...[
            InkWell(
              onTap: _decrementQuantity,
              child: FluxImage(
                imageUrl: _value > 1
                    ? "assets/icons/minus_circle.svg"
                    : 'assets/icons/Remove.svg',
                // width: _value > 1?33:40,
                // height: _value > 1?33:40,
              ),
            ),
            Text(
              '$_value',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
          InkWell(
            onTap: _incrementQuantity,
            child: const FluxImage(
              imageUrl: 'assets/icons/add_circle.svg',
              width: 30,
              height: 30,
            ),
          ),
        ],
      ),
    );
  }
}
