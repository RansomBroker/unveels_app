import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'app_storage_pref.dart';
// import 'package:syncfusion_flutter_core/core.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';
//
// import '../../../common/constants.dart';
// import '../../../common/tools/tools.dart';
// import '../common/helper.dart';

enum KDateTimePickerType {
  dateHijri,
  dateGregorian,
  dateTimeHijri,
  dateTimeGregorian,
  time
}

final TextEditingController dateController = TextEditingController();

class SfDatePicker extends StatelessWidget {
  static Future<String?> showDateTimePickerHG(BuildContext context,
      {required KDateTimePickerType type,
      required DateTime initial,
      required DateTime start,
      required DateTime end,
      bool isFromGift = false,
      bool Function(DateTime)? selectableDayPredicate}) async {
    if (type == KDateTimePickerType.time) {
      final localizations = MaterialLocalizations.of(context);
      final time = await _timePicker(context);
      if (time != null) {
        final formattedTimeOfDay = localizations.formatTimeOfDay(time);
        return formattedTimeOfDay.toString();
      }
    } else {
      final date = await showDialog(
        builder: (BuildContext context) {
          return SfDatePicker(
            hijri: type == KDateTimePickerType.dateHijri ||
                type == KDateTimePickerType.dateTimeHijri,
            type: type,
            hasTime: type == KDateTimePickerType.dateTimeGregorian ||
                type == KDateTimePickerType.dateTimeHijri,
            initial: initial,
            start: start,
            end: end,
            selectableDayPredicate: selectableDayPredicate,
            isFromGift: isFromGift,
          );
        },
        context: context,
      );
      return date;
    }
    return null;
  }

  const SfDatePicker({
    Key? key,
    required this.hijri,
    required this.hasTime,
    required this.initial,
    required this.start,
    required this.end,
    required this.type,
    this.selectableDayPredicate,
    this.isFromGift = false,
  }) : super(key: key);

  final bool hijri;
  final bool hasTime;
  final bool isFromGift;
  final KDateTimePickerType type;
  final DateTime initial, start, end;
  final bool Function(DateTime)? selectableDayPredicate;

  static Future<TimeOfDay?> _timePicker(context) async {
    TimeOfDay? pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    return pickedTime;
  }

  onSubmit(BuildContext context, value, bool isFromGift) async {
    final isAr = appStoragePref.getStoreCode=='ar';
    String? formattedDate =
        DateFormat((isAr && isFromGift) ? 'dd/MM/yyyy' : 'MM/dd/yyyy', 'en_US')
            .format(DateTime.tryParse(value.toString()) ?? initial);
    dateController.text = formattedDate;
    final nav = Navigator.of(context);
    if (hasTime) {
      final localizations = MaterialLocalizations.of(context);
      final pickedTime = await _timePicker(context);
      if (pickedTime != null) {
        final formattedTimeOfDay = localizations.formatTimeOfDay(pickedTime);
        dateController.text = '$formattedDate - $formattedTimeOfDay ';
      }
      nav.pop<String>(dateController.text);
    } else {
      nav.pop<String>(dateController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // List<DateTime> dates = [
    //   DateTime(2024, 4, 4),
    //   DateTime(2024, 4, 5),
    //   DateTime(2024, 4, 6),
    // ];
    return Center(
      child: Container(
        height: height * .6,
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              // changes position of shadow
            ),
          ],
        ),
        // decoration: KHelper.of(context).elevatedBox.copyWith(color: Colors.white),
        child: SfDateRangePicker(
                selectionColor: Theme.of(context).primaryColor,
                minDate: start,
                initialSelectedDate: initial,
                selectableDayPredicate: selectableDayPredicate,
                maxDate: end,
                selectionMode: DateRangePickerSelectionMode.single,
                selectionTextStyle: const TextStyle(color: Colors.white),
                showActionButtons: true,
                backgroundColor: Colors.white,
                selectionShape: DateRangePickerSelectionShape.circle,
                // selectionRadius: 5,
                onCancel: () => Navigator.of(context).pop(),
                onSubmit: (p0) => onSubmit(context, p0, isFromGift),
              ),
      ),
    );
  }
}
