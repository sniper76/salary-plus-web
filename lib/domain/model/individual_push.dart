import 'package:act_cms/domain/model/push.dart';
import 'package:act_cms/domain/model/push_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'individual_push.g.dart';

@JsonSerializable()
class IndividualPush extends Push {
  final PushUser user;

  const IndividualPush({
    required this.user,
    required super.id,
    required super.content,
    required super.createdAt,
    required super.updatedAt,
  });

  factory IndividualPush.fromJson(Map<String, dynamic> json) => _$IndividualPushFromJson(json);

  Map<String, dynamic> toJson() => _$IndividualPushToJson(this);
}
