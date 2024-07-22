import 'package:flutter/material.dart';

enum UserActionOnPost { update, delete, report, block, copy, cancel }

extension UserActionOnPostExtention on UserActionOnPost {
  String get title {
    switch (this) {
      case UserActionOnPost.update:
        return '수정';
      case UserActionOnPost.delete:
        return '삭제';
      case UserActionOnPost.report:
        return '신고';
      case UserActionOnPost.block:
        return '차단';
      case UserActionOnPost.copy:
        return '복사';
      case UserActionOnPost.cancel:
        return '취소';
    }
  }

  IconData get icon {
    switch (this) {
      case UserActionOnPost.update:
        return Icons.edit;
      case UserActionOnPost.delete:
        return Icons.delete;
      case UserActionOnPost.report:
        return Icons.report;
      case UserActionOnPost.block:
        return Icons.block;
      case UserActionOnPost.copy:
        return Icons.copy;
      case UserActionOnPost.cancel:
        return Icons.cancel;
    }
  }
}
