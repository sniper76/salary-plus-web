import 'package:act_cms/config/constants.dart';
import 'package:act_cms/core/extension/datetime_extension.dart';
import 'package:act_cms/domain/model/enum/push/push_send_type.dart';
import 'package:flutter/material.dart';

class PushSendTypeButtons extends StatelessWidget {
  final PushSendType sendType;
  final DateTime? targetDatetime;
  final Function onPressed;
  final Function selectDateTime;

  const PushSendTypeButtons({
    super.key,
    required this.sendType,
    required this.onPressed,
    required this.selectDateTime,
    this.targetDatetime,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: () {
            onPressed(false);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: sendType == PushSendType.immediately ? const Color(0xff0027A3) : const Color(0xffD9D9D9),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
          ),
          child: const Text("즉시", style: TextStyle(color: Colors.white)),
        ),
        ElevatedButton(
          onPressed: () {
            onPressed(true);
            selectDateTime();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: sendType == PushSendType.schedule ? const Color(0xff0027A3) : const Color(0xffD9D9D9),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
          ),
          child: const Text("예약", style: TextStyle(color: Colors.white)),
        ),
        if (sendType == PushSendType.schedule && targetDatetime != null)
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              targetDatetime!.toFormatString(pattern: dateTimeFormatPattern2),
            ),
          )
      ],
    );
  }
}
