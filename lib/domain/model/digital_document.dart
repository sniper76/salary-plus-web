import 'package:act_cms/domain/model/digital_document_accept_user.dart';
import 'package:act_cms/domain/model/digital_document_download.dart';
import 'package:act_cms/domain/model/digital_document_item.dart';
import 'package:act_cms/domain/model/digital_document_stock.dart';
import 'package:act_cms/domain/model/digital_document_user.dart';
import 'package:act_cms/domain/model/enum/digital_document_answer_status_type.dart';
import 'package:act_cms/domain/model/enum/digital_document_answer_type.dart';
import 'package:act_cms/domain/model/enum/digital_document_type.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'digital_document.g.dart';

@JsonSerializable()
class DigitalDocument {
  final int id;

  // 문서 타입
  @JsonKey(name: 'digitalDocumentType', unknownEnumValue: DigitalDocumentType.unknown)
  final DigitalDocumentType? documentType;

  // 전자문서 종목
  final DigitalDocumentStock? stock;

  // 전자문서 위임인 또는 작성자
  final DigitalDocumentUser? user;

  // 전자문서 수임인 또는 주주대표
  final DigitalDocumentAcceptUser? acceptUser;

  // 전자문서 안건
  @JsonKey(name: 'items')
  final List<DigitalDocumentItem>? itemGroups;

  // 응답 상태
  final DigitalDocumentAnswerStatusType? answerStatus;
  final DateTime? targetStartDate;
  final DateTime? targetEndDate;
  final int? joinUserCount;
  final int? joinStockSum;
  final double? shareholdingRatio;

  // 전자문서 제목(게시글 제목이 들어감)
  final String? title;

  final DigitalDocumentDownload? digitalDocumentDownload;

  const DigitalDocument(
      {required this.id,
      this.documentType,
      this.stock,
      this.user,
      this.acceptUser,
      this.itemGroups,
      this.answerStatus,
      this.targetStartDate,
      this.targetEndDate,
      this.joinStockSum,
      this.joinUserCount,
      this.shareholdingRatio,
      this.title,
      this.digitalDocumentDownload});

  factory DigitalDocument.fromJson(Map<String, dynamic> json) => _$DigitalDocumentFromJson(json);

  Map<String, dynamic> toJson() => _$DigitalDocumentToJson(this);

  DigitalDocument copyWith({
    String? title,
  }) {
    return DigitalDocument(
        id: id,
        documentType: documentType,
        stock: stock,
        user: user,
        acceptUser: acceptUser,
        itemGroups: itemGroups,
        answerStatus: answerStatus,
        targetStartDate: targetStartDate,
        targetEndDate: targetEndDate,
        joinUserCount: joinUserCount,
        shareholdingRatio: shareholdingRatio,
        title: title ?? this.title,
        digitalDocumentDownload: digitalDocumentDownload ?? digitalDocumentDownload);
  }
}

extension DigitalDocumentExtension on DigitalDocument {
  bool get requiredBankAccount => documentType == DigitalDocumentType.jointOwnership;

  bool get hasAnswerItems => itemGroups != null && itemGroups?.isNotEmpty == true;

  bool get isAnswerCompleted => answerStatus == DigitalDocumentAnswerStatusType.complete;

  int get totalAnswerUserCount => joinUserCount ?? 0;

  double get answerShareHoldingPercent => shareholdingRatio ?? 0;

  Map<int, DigitalDocumentAnswerType?> generateAnswerMap() {
    final map = <int, DigitalDocumentAnswerType?>{};
    final items = itemGroups?.expand<DigitalDocumentItem>((e) => e.childItems ?? [e]).toList() ?? [];
    for (var e in items) {
      if (e.childItems == null || e.childItems?.isEmpty == true) {
        map[e.id] = e.defaultSelectValue;
      } else {
        e.childItems?.forEach((element) {
          map[element.id] = element.defaultSelectValue;
        });
      }
    }
    return map;
  }

  bool get isReady => targetStartDate != null && targetStartDate?.toUtc().isAfter(DateTime.now()) == true;

  bool get isActive =>
      targetStartDate?.toUtc().isBefore(DateTime.now()) == true &&
      targetEndDate?.toUtc().isAfter(DateTime.now()) == true;

  bool get isEnded => targetEndDate?.toUtc().isBefore(DateTime.now()) == true;

  int get remainingDay {
    return targetEndDate?.toUtc().difference(DateTime.now()).inDays ?? -1;
  }

  String get userTitle {
    if (documentType == DigitalDocumentType.digitalProxy) {
      return '위임인';
    } else {
      return '작성자';
    }
  }

  String get acceptUserTitle {
    if (documentType == DigitalDocumentType.digitalProxy) {
      return '수임인';
    } else {
      return '주주대표';
    }
  }

  String get statusLabel {
    if (isReady) {
      return '대기';
    } else if (isActive) {
      return '진행중';
    } else if (isEnded) {
      return '종료';
    } else {
      return '';
    }
  }

  Color? get statusLabelColor {
    if (isReady) {
      return const Color(0xff0E9F33);
    } else if (isActive) {
      return const Color(0xff355CE9);
    } else if (isEnded) {
      return const Color(0xffFF0000);
    } else {
      return null;
    }
  }
}
