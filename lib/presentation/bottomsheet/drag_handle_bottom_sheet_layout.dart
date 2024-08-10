import 'package:act_cms/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class DragHandleBottomSheetLayout extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets? contentPadding;
  final String? title;
  final bool useCancelButton;

  const DragHandleBottomSheetLayout({
    Key? key,
    required this.children,
    this.title,
    this.contentPadding,
    this.useCancelButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: Container(
            color: Colors.white,
            child: Material(
              color: Colors.white,
              child: SafeArea(
                child: Container(
                  padding: contentPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.only(top: 12, bottom: 20),
                        ),
                      ),
                      Row(
                        children: [
                          if (title != null)
                            Text(
                              title ?? '',
                              style: context.textTheme.displaySmall?.copyWith(color: Colors.black),
                            ),
                          const Spacer(),
                          if (useCancelButton)
                            GestureDetector(
                              child: const Icon(Icons.close),
                              onTap: () => Navigator.of(context).pop(),
                            ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      ...children,
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
