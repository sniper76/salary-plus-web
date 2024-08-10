import 'package:flutter/material.dart';

class CommentRegisterWidget extends StatefulWidget {
  final void Function(String content, bool isAnonymous) onSave;

  const CommentRegisterWidget({super.key, required this.onSave});

  @override
  State<CommentRegisterWidget> createState() => _CommentRegisterWidgetState();
}

class _CommentRegisterWidgetState extends State<CommentRegisterWidget> {
  bool isChecked = false;
  final TextEditingController _commentTextController = TextEditingController();

  @override
  void dispose() {
    _commentTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(child: _buildCommentTextField()),
          const SizedBox(width: 8),
          Column(
            children: [
              _buildCheckBox(),
              _buildCommentSaveButton(),
            ],
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }

  Widget _buildCommentSaveButton() {
    return ElevatedButton(
      child: const Text("등록"),
      onPressed: () async {
        if (_commentTextController.text.isEmpty) {
          return;
        }
        widget.onSave(_commentTextController.text, isChecked);
        _commentTextController.text = "";
      },
    );
  }

  Widget _buildCommentTextField() {
    return TextField(
      controller: _commentTextController,
      maxLines: 10,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Color(0xffD9D9D9)),
        ),
      ),
    );
  }

  Widget _buildCheckBox() {
    return SizedBox(
      width: 120,
      child: CheckboxListTile(
        title: const Text('익명'),
        value: isChecked,
        onChanged: (bool? value) {
          setState(() {
            isChecked = value!;
          });
        },
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}
