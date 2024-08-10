import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/domain/model/comment.dart';
import 'package:act_cms/presentation/widget/button/act_elevated_button.dart';
import 'package:flutter/material.dart';

class CommentEditWidget extends StatefulWidget {
  final void Function(String content, Comment comment) onUpdate;
  final Comment comment;

  const CommentEditWidget({
    super.key,
    required this.onUpdate,
    required this.comment,
  });

  @override
  State<CommentEditWidget> createState() => _CommentEditWidgetState();
}

class _CommentEditWidgetState extends State<CommentEditWidget> {
  final TextEditingController _commentTextController = TextEditingController();

  @override
  void initState() {
    _commentTextController.text = widget.comment.content;
    super.initState();
  }

  @override
  void dispose() {
    _commentTextController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(CommentEditWidget oldWidget) {
    _commentTextController.text = widget.comment.content;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(child: _buildCommentTextField()),
          const SizedBox(width: 8),
          SizedBox(
            width: 120.0,
            child: Center(
              child: _buildCommentUpdateButton(),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }

  Widget _buildCommentUpdateButton() {
    return ActElevatedButton(
      titleWidget: const Text("수정"),
      onPressed: () async {
        if (_commentTextController.text.isEmpty) {
          return;
        }
        final confirm = await context.showConfirmDialog(title: '댓글 수정', message: '댓글을 수정하시겠습니까?');
        if (confirm) {
          widget.onUpdate(
            _commentTextController.text,
            widget.comment,
          );
          _commentTextController.text = "";
        }
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
}
