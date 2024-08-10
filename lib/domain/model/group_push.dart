import 'package:act_cms/domain/model/enum/push/push_send_status.dart';
import 'package:act_cms/domain/model/enum/push/push_send_type.dart';
import 'package:act_cms/domain/model/enum/push/push_target_type.dart';
import 'package:act_cms/domain/model/push.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group_push.g.dart';

@JsonSerializable()
class GroupPush extends Push {
  final String? stockCode;
  final String? stockName;
  final String? stockGroupName;
  final String title;
  final int? stockGroupId;
  final String? topic;
  @JsonKey(unknownEnumValue: PushTargetType.unknown)
  final PushTargetType stockTargetType;
  @JsonKey(unknownEnumValue: PushSendType.unknown)
  final PushSendType sendType;
  @JsonKey(unknownEnumValue: PushSendStatus.unknown)
  final PushSendStatus sendStatus;

  const GroupPush({
    this.stockCode,
    this.stockName,
    this.stockGroupName,
    this.stockGroupId,
    this.topic,
    this.stockTargetType = PushTargetType.unknown,
    this.sendType = PushSendType.unknown,
    this.sendStatus = PushSendStatus.unknown,
    required super.id,
    required super.content,
    required super.createdAt,
    required super.updatedAt,
    required this.title,
  });

  factory GroupPush.fromJson(Map<String, dynamic> json) => _$GroupPushFromJson(json);

  Map<String, dynamic> toJson() => _$GroupPushToJson(this);

  String get category {
    switch (stockTargetType) {
      case PushTargetType.all:
        return stockTargetType.title;
      case PushTargetType.stock:
        return stockName ?? '';
      case PushTargetType.stock_group:
        return stockGroupName ?? '';
      default:
        return '';
    }
  }
}
