import 'package:flutter/material.dart';

class DataGridTitleItem extends StatelessWidget {
  final String title;
  final bool? isAttachment;

  const DataGridTitleItem({super.key, required this.title, this.isAttachment = false});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      overflow: TextOverflow.ellipsis,
      TextSpan(
        text: title,
        children: [
          if (isAttachment == true) _buildAttachment(),
        ],
      ),
    );
  }

  WidgetSpan _buildAttachment() {
    return const WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: Padding(padding: EdgeInsets.only(left: 4.0), child: Icon(Icons.image_outlined, size: 12)),
    );
  }
}
