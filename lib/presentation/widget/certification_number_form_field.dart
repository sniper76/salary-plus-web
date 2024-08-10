import 'dart:async';

import 'package:act_cms/config/theme.dart';
import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/core/extension/duration_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CertificationNumberFormField extends StatefulWidget {
  final TextEditingController? controller;
  final int maxMinutes;
  final double border;
  final double borderRadius;
  final Color? borderColor;
  final Color? focusBorderColor;
  final Color? backgroundColor;
  final TextStyle? hintTextStyle;
  final bool autoFocus;
  final AsyncCallback? onRetryPressed;

  const CertificationNumberFormField({
    super.key,
    this.controller,
    this.maxMinutes = 3,
    this.border = 1,
    this.borderRadius = 8,
    this.borderColor,
    this.focusBorderColor,
    this.backgroundColor,
    this.hintTextStyle,
    this.autoFocus = false,
    this.onRetryPressed,
  });

  @override
  State<CertificationNumberFormField> createState() => _CertificationNumberFormFieldState();
}

class _CertificationNumberFormFieldState extends State<CertificationNumberFormField> {
  final _inputKey = GlobalKey();
  Color _borderColor = Colors.transparent;
  Timer? _countdownTimer;
  late Duration _maxDuration;
  Duration _elapsedDuration = Duration.zero;

  _onFocusChanged(bool focused) {
    setState(() {
      if (focused) {
        _borderColor = widget.focusBorderColor ?? context.colorScheme.primary;
      } else {
        _borderColor = widget.borderColor ?? context.colorScheme.outline;
      }
    });
  }

  _onRetry() async {
    _stopTimer();
    await widget.onRetryPressed?.call();
    _startTimer();
  }

  _startTimer() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedDuration = _maxDuration - Duration(seconds: timer.tick);
      });
      final maxTick = widget.maxMinutes * 60;
      if (timer.tick >= maxTick) {
        _stopTimer();
      }
    });
  }

  _stopTimer() {
    _countdownTimer?.cancel();
  }

  @override
  void initState() {
    super.initState();
    _maxDuration = Duration(minutes: widget.maxMinutes);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _borderColor = widget.borderColor ?? context.colorScheme.outline;
      });
      _startTimer();
    });
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            '인증번호',
            style: context.textTheme.bodySmall,
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
            border: widget.border > 0 ? Border.all(color: _borderColor, width: widget.border) : null,
          ),
          child: Focus(
            onFocusChange: _onFocusChanged,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    key: _inputKey,
                    controller: widget.controller,
                    autofocus: widget.autoFocus,
                    keyboardType: TextInputType.number,
                    autofillHints: const [AutofillHints.oneTimeCode],
                    maxLength: 6,
                    decoration: InputDecoration(
                      hintText: '인증번호를 입력해주세요',
                      hintStyle:
                          widget.hintTextStyle ?? context.textTheme.bodyLarge?.copyWith(color: Colors.grey.shade400),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      counterText: "",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 34),
                  child: Text(
                    _elapsedDuration.format(),
                    style: context.textTheme.labelLarge?.copyWith(
                      color: context.colorScheme.error,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: GestureDetector(
                    onTap: _onRetry,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppTheme.primaryColor.shade700,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(2)),
                      ),
                      child: Text(
                        '재요청',
                        style: context.textTheme.labelLarge?.copyWith(color: AppTheme.primaryColor.shade700),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
