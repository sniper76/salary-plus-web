import 'package:flutter/material.dart';

enum BottomSheetMenu { modify, delete, report, block, copy, cancel }

extension BottomSheetMenuResultExtention on BottomSheetMenu {
  String get title {
    switch (this) {
      case BottomSheetMenu.modify:
        return '수정';
      case BottomSheetMenu.delete:
        return '삭제';
      case BottomSheetMenu.report:
        return '신고';
      case BottomSheetMenu.block:
        return '차단';
      case BottomSheetMenu.copy:
        return '복사';
      case BottomSheetMenu.cancel:
        return '취소';
    }
  }

  IconData get icon {
    switch (this) {
      case BottomSheetMenu.modify:
        return Icons.edit;
      case BottomSheetMenu.delete:
        return Icons.delete;
      case BottomSheetMenu.report:
        return Icons.report;
      case BottomSheetMenu.block:
        return Icons.block;
      case BottomSheetMenu.copy:
        return Icons.copy;
      case BottomSheetMenu.cancel:
        return Icons.cancel;
    }
  }
}
