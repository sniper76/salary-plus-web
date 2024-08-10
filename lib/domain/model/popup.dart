import 'package:act_cms/domain/model/enum/popup/popup_display_target_type.dart';
import 'package:act_cms/domain/model/enum/popup/popup_link_type.dart';
import 'package:act_cms/domain/model/enum/popup/popup_status.dart';
import 'package:act_cms/domain/model/enum/popup/popup_stock_target_type.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'popup.g.dart';

@JsonSerializable()
class Popup extends Equatable {
  final int id;
  final String title;
  final DateTime targetStartDatetime;
  final DateTime targetEndDatetime;
  final PopupDisplayTargetType displayTargetType;
  final PopupStatus popupStatus;
  final PopupStockTargetType stockTargetType;
  final String content;
  final PopupLinkType linkType;
  final String? linkTitle;
  final String? stockCode;
  final String? stockName;
  final String? stockGroupName;
  final int? stockGroupId;
  final String? linkUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? postId;

  const Popup({
    required this.id,
    required this.title,
    required this.targetStartDatetime,
    required this.targetEndDatetime,
    required this.displayTargetType,
    required this.stockTargetType,
    required this.content,
    required this.linkType,
    required this.popupStatus,
    this.linkUrl,
    this.stockCode,
    this.stockName,
    this.stockGroupId,
    this.stockGroupName,
    this.linkTitle,
    this.createdAt,
    this.updatedAt,
    this.postId,
  });

  factory Popup.fromJson(Map<String, dynamic> json) => _$PopupFromJson(json);

  Map<String, dynamic> toJson() => _$PopupToJson(this);

  Popup copyWith({
    String? title,
    String? content,
  }) {
    return Popup(
        id: id,
        title: title ?? this.title,
        createdAt: createdAt,
        updatedAt: updatedAt,
        content: content ?? this.content,
        targetStartDatetime: targetStartDatetime,
        targetEndDatetime: targetEndDatetime,
        popupStatus: popupStatus,
        linkType: linkType,
        linkTitle: linkTitle,
        displayTargetType: displayTargetType,
        stockCode: stockCode,
        stockGroupId: stockGroupId,
        stockTargetType: stockTargetType);
  }

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        createdAt,
        updatedAt,
        popupStatus,
      ];
}

extension PopupExtension on Popup {
  String getPopupStateText({
    required DateTime targetStartDatetime,
    required DateTime targetEndDatetime,
  }) {
    final today = DateTime.now();
    if (targetStartDatetime.isAfter(today) && targetEndDatetime.isBefore(today)) {
      return PopupStatus.processing.title;
    }
    if (targetStartDatetime.isBefore(today)) {
      return PopupStatus.ready.title;
    }
    if (targetEndDatetime.isAfter(today)) {
      return PopupStatus.complete.title;
    }

    return PopupStatus.unknown.title;
  }

  bool getPopupState({
    required DateTime targetStartDatetime,
    required DateTime targetEndDatetime,
  }) {
    final today = DateTime.now();

    return targetStartDatetime.isAfter(today) && targetEndDatetime.isBefore(today);
  }
}
