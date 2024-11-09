/*
 *


 *
 * /
 */

// ignore_for_file: file_names

import 'package:flutter/material.dart';
class RangeSelector extends StatefulWidget {
  // String titleForRange;

  double minPoint = 0.0, maxPoint = 100.0;

  RangeSelector(/*this.titleForRange,*/ this.minPoint, this.maxPoint);

  @override
  _RangeSelectorState createState() => _RangeSelectorState();
}

class _RangeSelectorState extends State<RangeSelector> {
  RangeValues _currentRangeValues = const RangeValues(0, 100);



  Widget buildPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        rangeSlider(),
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Text(
             "Selected range: ${_currentRangeValues.start} - ${_currentRangeValues.end}"),
        )
      ],
    );
  }

  Widget rangeSlider() {
    return RangeSlider(
      values: _currentRangeValues,
      min: widget.minPoint,
      max: widget.maxPoint,
      divisions: widget.maxPoint.toInt(),
      labels: RangeLabels(
        _currentRangeValues.start.round().toString(),
        _currentRangeValues.end.round().toString(),
      ),
      onChanged: (RangeValues values) {
        setState(() {
          _currentRangeValues = values;
          debugPrint("fdefdfe--->$_currentRangeValues");
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildPage();
  }
}
