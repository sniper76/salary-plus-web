import 'package:act_cms/core/extension/datetime_extension.dart';
import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

void showCmsCalender({
  required BuildContext context,
  required String title,
  required String subTitle,
  required void Function(DateTime date) onSubmit,
  DateTime? initDate,
}) async =>
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return PointerInterceptor(
            child: AlertDialog(
              contentPadding: const EdgeInsets.all(40),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          const Text('-'),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(subTitle),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(((initDate) == null) ? '-' : initDate.toFormatString()),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    width: 400,
                    height: 300,
                    child: SfDateRangePicker(
                      minDate: DateTime(DateTime.now().year, DateTime.now().month - 2, 1),
                      // 2년 전의 1월 1일
                      maxDate: DateTime(DateTime.now().year + 2, 12, 31),
                      // 2년 후의 1월 1일
                      initialSelectedDate: initDate,
                      initialDisplayDate: initDate,
                      showActionButtons: true,
                      showNavigationArrow: true,
                      showTodayButton: true,
                      confirmText: "변경",
                      cancelText: "취소",
                      monthViewSettings: const DateRangePickerMonthViewSettings(
                        dayFormat: 'EEE',
                      ),
                      monthFormat: 'MMM',
                      headerStyle: const DateRangePickerHeaderStyle(
                        textAlign: TextAlign.center,
                        textStyle: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      onSubmit: (p0) {
                        onSubmit(p0 as DateTime);
                        Navigator.of(context).pop();
                      },
                      selectionMode: DateRangePickerSelectionMode.single,
                      onCancel: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     // TODO: 여기에 버튼 클릭시 실행할 로직을 추가하세요
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //     fixedSize: const Size(470, 54), // Width and Height
                  //   ),
                  //   child: const Text('변경'),
                  // ),
                ],
              ),
            ),
          );
        });
