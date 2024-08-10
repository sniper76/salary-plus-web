import 'package:act_cms/presentation/widget/act_field_container.dart';
import 'package:flutter/material.dart';

class ActCampaignTitleInput extends StatefulWidget {
  final Function(String value)? onChanged;
  final TextEditingController controllerCampaignTitle;

  const ActCampaignTitleInput({super.key, this.onChanged, required this.controllerCampaignTitle});

  @override
  State<ActCampaignTitleInput> createState() => _ActCampaignTitleInputState();
}

class _ActCampaignTitleInputState extends State<ActCampaignTitleInput> {
  @override
  Widget build(BuildContext context) {
    return ActFieldContainer(
      title: '캠페인명',
      children: [
        Expanded(
            child: TextField(
          controller: widget.controllerCampaignTitle,
          decoration: InputDecoration(
            hintText: "제목을 입력하세요.",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Color(0xffD9D9D9)),
            ),
          ),
          onChanged: widget.onChanged,
        ))
      ],
    );
  }
}
