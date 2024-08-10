import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/domain/model/digital_document_item.dart';
import 'package:act_cms/domain/model/enum/digital_document_answer_type.dart';
import 'package:act_cms/presentation/widget/digital_document_item_view.dart';
import 'package:flutter/material.dart';

class DigitalDocumentGroupView extends StatefulWidget {
  final DigitalDocumentItem group;
  final Function(DigitalDocumentItem, DigitalDocumentAnswerType)? onAnswerChanged;

  const DigitalDocumentGroupView({
    super.key,
    required this.group,
    this.onAnswerChanged,
  });

  @override
  State<DigitalDocumentGroupView> createState() => _DigitalDocumentGroupViewState();
}

class _DigitalDocumentGroupViewState extends State<DigitalDocumentGroupView> {
  _onAnswerChanged({
    required DigitalDocumentItem item,
    required DigitalDocumentAnswerType answerType,
  }) {
    widget.onAnswerChanged?.call(item, answerType);
  }

  @override
  Widget build(BuildContext context) {
    List<DigitalDocumentItem> items = widget.group.childItems ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40, bottom: 10),
          child: Text(
            '${widget.group.title}${(widget.group.content.isNotEmpty) ? '\n${widget.group.content}' : ''}',
            style: context.textTheme.displaySmall,
          ),
        ),
        if (items.isEmpty)
          DigitalDocumentItemView(
            key: ValueKey('digital-document-item-${widget.group.id}'),
            title: widget.group.subject,
            description: widget.group.description,
            recommendValue: widget.group.defaultSelectValue,
            onChanged: (answer) => _onAnswerChanged(item: widget.group, answerType: answer),
          ),
        ...items.map(
          (e) {
            if (e.childItems == null || e.childItems?.isEmpty == true) {
              return DigitalDocumentItemView(
                key: ValueKey('digital-document-item-${e.id}'),
                title: e.subject,
                description: e.description,
                recommendValue: e.defaultSelectValue,
                onChanged: (answer) => _onAnswerChanged(item: e, answerType: answer),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${e.title}${(e.content.isNotEmpty) ? '\n${e.content}' : ''}',
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ...e.childItems?.map(
                        (item) => DigitalDocumentItemView(
                          key: ValueKey('digital-document-item-${item.id}'),
                          title: item.subject,
                          description: item.description,
                          recommendValue: item.defaultSelectValue,
                          onChanged: (answer) => _onAnswerChanged(item: item, answerType: answer),
                        ),
                      ) ??
                      [],
                ],
              );
            }
          },
        ),
      ],
    );
  }
}
