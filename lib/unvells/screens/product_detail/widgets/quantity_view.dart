/*
 *


 *
 * /
 */

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_new/unvells/configuration/unvells_theme.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/screens/product_detail/bloc/product_detail_screen_bloc.dart';

import '../../../constants/app_string_constant.dart';
import '../../../helper/utils.dart';
import '../bloc/product_detail_screen_events.dart';

class QuantityView extends StatefulWidget {
  ValueChanged<int>? callBack;
  ProductDetailScreenBloc? bloc;
  int? counter;

  QuantityView({this.callBack, this.bloc, this.counter});

  @override
  State<StatefulWidget> createState() {
    return _QuantityViewState();
  }
}

class _QuantityViewState extends State<QuantityView> {
  TextEditingController controller = TextEditingController();
  ProductDetailScreenBloc? bloc;
  bool doUpdate = true;

  @override
  void initState() {
    controller.text = "1";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (doUpdate) {
      controller.text =
      "1 ${Utils.getStringValue(context, AppStringConstant.unit)}";
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.zero,
        padding: const EdgeInsets.all(AppSizes.paddingNormal),
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Utils.getStringValue(context, AppStringConstant.quantity),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                width: AppSizes.deviceWidth / 1,
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  // borderRadius: BorderRadius.circular(10.0),
                  // border: Border.all(
                  //     color: Theme.of(context).colorScheme.outline),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              if (widget.counter! > 1) {
                                widget.counter = (widget.counter ?? 1) - 1;
                                changeQty();
                              }
                            },
                            child: Center(
                              child: Icon(Icons.remove,
                                  size: 20, color: Colors.white),
                            )),
                      ),
                      SizedBox(
                        width: 30.0,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                                color: Theme.of(context).colorScheme.outline),
                          ),
                          child: Center(
                            child: TextField(
                              enabled: false,
                              controller: controller,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontSize: 18.0),
                              keyboardType: TextInputType.number,
                              decoration:
                              InputDecoration(border: InputBorder.none),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30.0,
                      ),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              widget.counter = (widget.counter ?? 1) + 1;
                              changeQty();
                            },
                            child: Center(
                                child: Icon(Icons.add,
                                    size: 20, color: Colors.white))),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changeQty() {
    doUpdate = false;
    widget.bloc?.add(QuantityUpdateEvent(widget.counter));
    controller.text =
    ("${widget.counter}${(widget.counter! > 1) ? " ${Utils.getStringValue(context, AppStringConstant.units)}" : " ${Utils.getStringValue(context, AppStringConstant.unit)}"}");
  }
}
