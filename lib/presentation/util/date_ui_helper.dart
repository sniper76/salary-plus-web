import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class DateUiHelper {
  static Future<DateTime?> selectDateTime(BuildContext context, DateTime? initialDateTime) async {
    if (!context.mounted) return null;

    DateTime? selectedDate = await selectDate(context, initialDateTime);
    if (selectedDate == null) {
      return null;
    }

    if (!context.mounted) return null;

    TimeOfDay? selectedTime = await selectTime(context, initialDateTime);
    if (selectedTime == null) {
      return null;
    }

    return DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
  }

  static Future<DateTime?> selectDate(BuildContext context, DateTime? dateTime) async {
    var now = DateTime.now();
    var initialDate = (dateTime != null && now.isBefore(dateTime)) ? dateTime : now;

    return await showDatePicker(
      context: context,
      builder: (ctx, child) => PointerInterceptor(child: child!),
      initialDate: initialDate,
      firstDate: now,
      lastDate: DateTime(2100),
    );
  }

  static Future<TimeOfDay?> selectTime(BuildContext context, DateTime? dateTime) async {
    TimeOfDay initialTime =
        dateTime != null ? TimeOfDay(hour: dateTime.hour, minute: dateTime.minute) : TimeOfDay.now();

    return await showTimePicker(
      context: context,
      builder: (ctx, child) => PointerInterceptor(child: child!),
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: initialTime,
    );
  }
}
