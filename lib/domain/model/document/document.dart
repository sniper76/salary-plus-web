import 'package:act_web/core/extension/datetime_extension.dart';
import 'package:act_web/domain/enum/digital_document_answer_status_type.dart';
import 'package:act_web/domain/enum/digital_document_answer_type.dart';
import 'package:act_web/domain/enum/digital_document_attach_option_type.dart';
import 'package:act_web/domain/enum/digital_document_type.dart';
import 'package:act_web/domain/enum/poll_selection_type.dart';
import 'package:act_web/domain/enum/poll_view_type.dart';
import 'package:act_web/domain/enum/poll_vote_type.dart';
import 'package:act_web/domain/model/document/digital_document_attach_options.dart';
import 'package:act_web/domain/model/document/digital_document_item.dart';
import 'package:act_web/domain/model/document/poll_answer.dart';
import 'package:act_web/domain/model/document/poll_item.dart';
import 'package:act_web/domain/model/stock/digital_document_stock.dart';
import 'package:act_web/domain/model/user/digital_document_accept_user.dart';
import 'package:act_web/domain/model/user/digital_document_user.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'document.freezed.dart';
part 'document.g.dart';

@freezed
class Document with _$Document {
  const Document._();

  const factory Document({
    DateTime? targetStartDate,
    DateTime? targetEndDate,
    DigitalDocumentAnswerStatusType? answerStatus,
  }) = _Document;

  const factory Document.poll({
    required int id,
    required int postId,
    required String title,
    required PollVoteType voteType,
    @JsonKey(name: 'selectionOption') required PollSelectionType selectionType,
    required String status,
    @Default([]) List<PollItem> pollItems,
    @Default(PollViewType.vote) PollViewType viewType,
    String? content,
    List<PollAnswer>? answers,
    @JsonKey(toJson: _convertDateToString) DateTime? targetStartDate,
    @JsonKey(toJson: _convertDateToString) DateTime? targetEndDate,
    DigitalDocumentAnswerStatusType? answerStatus,
  }) = Poll;

  const factory Document.digitalProxy({
    required int templateId,
    required String templateName,
    required String templateRole,
    DateTime? targetStartDate,
    DateTime? targetEndDate,
    DigitalDocumentAnswerStatusType? answerStatus,
  }) = DigitalProxy;

  const factory Document.digitalDocument({
    required int id,
    @JsonKey(name: 'digitalDocumentType', unknownEnumValue: DigitalDocumentType.unknown)
    required DigitalDocumentType documentType,
    required DigitalDocumentAttachOptions attachOptions,
    DigitalDocumentStock? stock,
    DigitalDocumentUser? user,
    DigitalDocumentAcceptUser? acceptUser,
    @JsonKey(name: 'items') List<DigitalDocumentItem>? itemGroups,
    DateTime? targetStartDate,
    DateTime? targetEndDate,
    DigitalDocumentAnswerStatusType? answerStatus,
    int? joinUserCount,
    double? shareholdingRatio,
    String? title,
  }) = DigitalDocument;

  factory Document.fromJson(Map<String, dynamic> json) => _$DocumentFromJson(json);
}

String? _convertDateToString(DateTime? date) => date?.toUtc().toIso8601String();

extension DocumentExtension on Document {
  bool get isAnswerCompleted => answerStatus == DigitalDocumentAnswerStatusType.complete;

  bool get isReady => targetStartDate != null && targetStartDate!.toUtc().isAfter(DateTime.now());

  bool get isActive =>
      targetStartDate?.toUtc().isBefore(DateTime.now()) == true &&
      targetEndDate?.toUtc().isAfter(DateTime.now()) == true;

  bool get isEnded => targetEndDate?.toUtc().isBefore(DateTime.now()) == true;

  String get remainingDay => 'D${targetEndDate?.toUtc().difference(DateTime.now()).inDays}';

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

  String statusTime() {
    final now = DateTime.now();

    if (isReady) {
      final difference = targetStartDate!.difference(now);
      if (difference.inHours < 1) return '곧 시작';
      if (difference.inHours <= 24) return '${difference.inHours}시간 후 시작';
      return '${difference.inDays}일 후 시작';
    } else if (isActive) {
      final difference = targetEndDate!.difference(DateTime.now());
      if (difference.inHours < 1) return '곧 마감';
      if (difference.inHours <= 24) return '${difference.inHours}시간 후 마감';
      return '${difference.inDays}일 후 마감';
    } else {
      return '종료일 ${targetEndDate?.toFormatString()}';
    }
  }

  Color? get statusLabelColor {
    if (isReady) {
      return const Color(0xffFF8650);
    } else if (isActive) {
      return const Color(0xff0E9F33);
    } else if (isEnded) {
      return const Color(0xffFF0000);
    } else {
      return null;
    }
  }
}

extension DigitalDocumentExtension on DigitalDocument {
  bool get attachingFilesNotRequired =>
      attachOptions.bankAccountImage == DigitalDocumentAttachOptionType.none &&
      attachOptions.idCardImage == DigitalDocumentAttachOptionType.none;

  bool get isIdCardImageRequired => attachOptions.idCardImage == DigitalDocumentAttachOptionType.required;

  bool get isIdCardImageOptional => attachOptions.idCardImage == DigitalDocumentAttachOptionType.optional;

  bool get isBankAccountImagesNotRequired => attachOptions.bankAccountImage == DigitalDocumentAttachOptionType.none;

  bool get isBankAccountImagesRequired => attachOptions.bankAccountImage == DigitalDocumentAttachOptionType.required;

  bool get isBankAccountImagesOptional => attachOptions.bankAccountImage == DigitalDocumentAttachOptionType.optional;

  bool get isHectoEncryptedBankAccountPdfOptional =>
      attachOptions.hectoEncryptedBankAccountPdf == DigitalDocumentAttachOptionType.optional;

  bool get canAttachBankAccountImages =>
      attachOptions.bankAccountImage == DigitalDocumentAttachOptionType.optional ||
      attachOptions.bankAccountImage == DigitalDocumentAttachOptionType.required;

  bool get canAttachHectoEncryptedBankAccountPdf =>
      attachOptions.hectoEncryptedBankAccountPdf == DigitalDocumentAttachOptionType.optional ||
      attachOptions.hectoEncryptedBankAccountPdf == DigitalDocumentAttachOptionType.required;

  bool get canAttachVerificationImages =>
      attachOptions.idCardImage == DigitalDocumentAttachOptionType.optional ||
      attachOptions.idCardImage == DigitalDocumentAttachOptionType.required;

  bool get hasAnswerItems => itemGroups != null && itemGroups?.isNotEmpty == true;

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
}
