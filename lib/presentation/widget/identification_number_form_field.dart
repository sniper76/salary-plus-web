import 'package:act_cms/config/constants.dart';
import 'package:act_cms/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class IdentificationNumberFormField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final double border;
  final double borderRadius;
  final Color? borderColor;
  final Color? focusBorderColor;
  final Color? backgroundColor;
  final TextStyle? hintTextStyle;
  final VoidCallback? onSubmitted;

  const IdentificationNumberFormField({
    super.key,
    this.controller,
    this.focusNode,
    this.border = 1,
    this.borderRadius = 8,
    this.borderColor,
    this.focusBorderColor,
    this.backgroundColor,
    this.hintTextStyle,
    this.onSubmitted,
  });

  @override
  State<IdentificationNumberFormField> createState() => _IdentificationNumberFormFieldState();
}

class _IdentificationNumberFormFieldState extends State<IdentificationNumberFormField> {
  final _inputKey1 = GlobalKey();
  final _inputKey2 = GlobalKey();
  final _birthDateController = TextEditingController();
  final _genderController = TextEditingController();
  final _genderFocusNode = FocusNode();
  bool _isFocused = false;
  String _errorMessage = '';

  _onFocusChanged(bool focused) {
    if (focused) {
      if (_inputKey1.currentContext != null) {
        Scrollable.ensureVisible(
          _inputKey1.currentContext!,
          duration: AnimationDuration.shortest,
          curve: Curves.easeInOut,
        );
      }
    }
    setState(() {
      _isFocused = focused;
    });
  }

  _onTextChanged() {
    if (_birthDateController.text.isEmpty || _birthDateController.text.length < 6 || _genderController.text.isEmpty) {
      return;
    }

    widget.controller?.text = _birthDateController.text + _genderController.text;
  }

  _validate() {
    var errorMessage = '';
    if (_birthDateController.text.isEmpty || _birthDateController.text.length < 6) {
      errorMessage = '생년월일 6자리를 입력해주세요';
    } else if (_genderController.text.isEmpty) {
      errorMessage = '주민번호 뒷자리를 입력해주세요';
    }

    setState(() {
      _errorMessage = errorMessage;
    });
  }

  @override
  void initState() {
    super.initState();

    _birthDateController.addListener(_onTextChanged);
    _genderController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _birthDateController.removeListener(_onTextChanged);
    _genderController.removeListener(_onTextChanged);

    _birthDateController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var borderColor = widget.borderColor ?? context.colorScheme.outline;
    if (_isFocused) {
      borderColor = widget.focusBorderColor ?? context.colorScheme.primary;
    }

    if (_errorMessage.isNotEmpty == true) {
      borderColor = context.colorScheme.error;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            '주민등록번호',
            style: context.textTheme.bodySmall,
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
            border: widget.border > 0 ? Border.all(color: borderColor, width: widget.border) : null,
          ),
          child: Focus(
            onFocusChange: _onFocusChanged,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    key: _inputKey1,
                    controller: _birthDateController,
                    focusNode: widget.focusNode,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    decoration: InputDecoration(
                      hintText: '생년월일 6자리',
                      hintStyle:
                          widget.hintTextStyle ?? context.textTheme.bodyLarge?.copyWith(color: Colors.grey.shade400),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      counterText: "",
                    ),
                    onChanged: (value) {
                      if (_birthDateController.text.isNotEmpty && _birthDateController.text.length >= 6) {
                        _genderFocusNode.requestFocus();
                      }
                    },
                    validator: (value) {
                      _validate();
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      if (_birthDateController.text.isNotEmpty) {
                        _genderFocusNode.requestFocus();
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    '⏤',
                    style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _genderFocusNode.requestFocus();
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          child: TextFormField(
                            key: _inputKey2,
                            controller: _genderController,
                            focusNode: _genderFocusNode,
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                              counterText: "",
                            ),
                            validator: (value) {
                              _validate();
                              return null;
                            },
                            onChanged: (value) {
                              if (value.isNotEmpty == true && value.isNotEmpty) {
                                widget.onSubmitted?.call();
                              }
                            },
                            onFieldSubmitted: (value) {
                              if (widget.controller?.text.isNotEmpty == true) {
                                widget.onSubmitted?.call();
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 18),
                          child: Text(
                            '●●●●●●',
                            style: context.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade500),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Offstage(
          offstage: _errorMessage.isEmpty,
          child: AnimatedOpacity(
            opacity: _errorMessage.isNotEmpty ? 1 : 0,
            duration: AnimationDuration.shortest,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
              child: Text(
                _errorMessage,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.error,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
