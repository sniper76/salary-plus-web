import 'package:act_cms/config/theme.dart';
import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/domain/model/enum/digital_document_answer_type.dart';
import 'package:flutter/material.dart';

class DigitalDocumentItemView extends StatefulWidget {
  final String title;
  final String description;
  final DigitalDocumentAnswerType? recommendValue;
  final Function(DigitalDocumentAnswerType)? onChanged;
  final EdgeInsets margin;

  const DigitalDocumentItemView({
    super.key,
    required this.title,
    required this.description,
    this.recommendValue,
    this.onChanged,
    this.margin = const EdgeInsets.symmetric(vertical: 20),
  });

  @override
  State<DigitalDocumentItemView> createState() => _DigitalDocumentAnswerViewState();
}

class _DigitalDocumentAnswerViewState extends State<DigitalDocumentItemView> {
  bool _isExpanded = false;
  DigitalDocumentAnswerType _selectedValue = DigitalDocumentAnswerType.unknown;
  List<DigitalDocumentAnswerType> items =
      DigitalDocumentAnswerType.values.where((e) => e != DigitalDocumentAnswerType.unknown).toList();

  _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  _onAnswerChanged(DigitalDocumentAnswerType value) {
    setState(() {
      _selectedValue = value;

      widget.onChanged?.call(_selectedValue);
    });
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      _selectedValue = widget.recommendValue ?? DigitalDocumentAnswerType.unknown;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xffEBEEF0), width: 1),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: (widget.description.isNotEmpty) ? _toggleExpanded : null,
                child: Container(
                  color: const Color(0xffEBEEF0),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.title,
                          style: context.textTheme.headlineSmall,
                        ),
                      ),
                      if (widget.description.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: RotatedBox(
                            quarterTurns: _isExpanded ? -45 : 45,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Offstage(
                offstage: !_isExpanded,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        widget.description,
                        style: context.textTheme.bodyLarge?.copyWith(color: Colors.grey.shade600),
                      ),
                    ),
                    Container(
                      height: 1,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.grey.shade200,
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: SegmentedButton<DigitalDocumentAnswerType>(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                      (states) => states.contains(MaterialState.selected) ? AppTheme.primaryColor : Colors.white,
                    ),
                    foregroundColor: MaterialStateColor.resolveWith(
                      (states) => states.contains(MaterialState.selected) ? Colors.white : AppTheme.primaryColor,
                    ),
                    side: MaterialStateBorderSide.resolveWith(
                      (states) => BorderSide(
                        color: context.colorScheme.primary,
                        width: 1,
                      ),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  showSelectedIcon: false,
                  segments: [
                    ...items.map(
                      (e) => ButtonSegment<DigitalDocumentAnswerType>(
                        value: e,
                        label: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              e.title,
                              style: context.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: _selectedValue == e ? Colors.white : context.colorScheme.primary),
                            ),
                            if (e == widget.recommendValue)
                              Text(
                                '주주연대추천',
                                style: context.textTheme.labelSmall?.copyWith(
                                  color: _selectedValue == e
                                      ? Colors.white.withOpacity(0.9)
                                      : context.colorScheme.primary.withOpacity(0.9),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  selected: <DigitalDocumentAnswerType>{_selectedValue},
                  onSelectionChanged: (selected) {
                    _onAnswerChanged(selected.first);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
