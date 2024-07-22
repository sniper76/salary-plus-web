import 'package:act_web/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class ActTextFormField extends StatelessWidget {
  final String? label;
  final TextStyle? labelTextStyle;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextStyle? textStyle;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final double border;
  final double borderRadius;
  final Color? borderColor;
  final Color? focusBorderColor;
  final Color? backgroundColor;
  final bool isObscureText;
  final bool readOnly;
  final bool enabled;
  final EdgeInsets? margin;
  final Widget? suffixIcon;
  final int? maxLength;
  final String? Function(String?)? validator;
  final VoidCallback? onSubmitted;
  final VoidCallback? onTap;
  final int? maxLines;
  final void Function(String)? onChanged;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsets? scrollPadding;
  final bool isCollapsed;
  final double? height;

  const ActTextFormField({
    super.key,
    this.label,
    this.labelTextStyle,
    this.controller,
    this.focusNode,
    this.textStyle,
    this.hintText,
    this.hintTextStyle,
    this.keyboardType,
    this.textInputAction,
    this.border = 1,
    this.borderRadius = 8,
    this.borderColor,
    this.focusBorderColor,
    this.backgroundColor,
    this.isObscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.suffixIcon,
    this.margin,
    this.maxLength,
    this.validator,
    this.onSubmitted,
    this.onTap,
    this.onChanged,
    this.maxLines = 1,
    this.contentPadding,
    this.scrollPadding,
    this.isCollapsed = false,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                label ?? '',
                style: labelTextStyle ?? context.textTheme.bodySmall,
              ),
            ),
          SizedBox(
            height: height,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.top,
              expands: height != null,
              scrollPadding: scrollPadding ?? const EdgeInsets.all(20.0),
              controller: controller,
              focusNode: focusNode,
              enabled: enabled,
              style: textStyle ?? context.textTheme.bodySmall,
              obscureText: isObscureText,
              keyboardType: keyboardType,
              maxLines: maxLines,
              onChanged: onChanged,
              decoration: InputDecoration(
                isCollapsed: isCollapsed,
                counterText: '',
                hintText: hintText,
                hintStyle: hintTextStyle ?? context.textTheme.bodyLarge?.copyWith(color: Colors.grey.shade400),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(borderRadius),
                  ),
                  borderSide: border > 0
                      ? BorderSide(color: borderColor ?? context.colorScheme.outline, width: border)
                      : BorderSide.none,
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(borderRadius),
                  ),
                  borderSide: border > 0
                      ? BorderSide(color: borderColor ?? context.colorScheme.outline, width: border)
                      : BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(borderRadius),
                  ),
                  borderSide: border > 0
                      ? BorderSide(color: focusBorderColor ?? context.colorScheme.primary, width: border)
                      : BorderSide.none,
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(borderRadius),
                  ),
                  borderSide:
                      border > 0 ? BorderSide(color: context.colorScheme.error, width: border) : BorderSide.none,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(borderRadius),
                  ),
                  borderSide:
                      border > 0 ? BorderSide(color: context.colorScheme.error, width: border) : BorderSide.none,
                ),
                isDense: true,
                contentPadding: contentPadding ?? const EdgeInsets.all(16.0),
                filled: true,
                fillColor: backgroundColor ?? Colors.white,
                suffixIcon: suffixIcon,
              ),
              maxLength: maxLength,
              textInputAction: textInputAction,
              readOnly: readOnly,
              onFieldSubmitted: (message) {
                onSubmitted?.call();
              },
              onTap: () {
                onTap?.call();
              },
              textCapitalization: TextCapitalization.none,
              validator: validator,
              onSaved: (value) {
                controller?.text = value ?? '';
              },
            ),
          ),
        ],
      ),
    );
  }
}
