import 'package:act_cms/domain/model/enum/leader_status_type.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'leader.g.dart';

@JsonSerializable()
class Leader extends Equatable {
  @JsonKey(unknownEnumValue: LeaderStatusType.unknown)
  final LeaderStatusType status;
  final String? message;
  final bool? applied;

  const Leader({required this.status, this.message, this.applied});

  factory Leader.fromJson(Map<String, dynamic> json) => _$LeaderFromJson(json);

  Map<String, dynamic> toJson() => _$LeaderToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [status, message, applied];
}

extension LeaderExtension on Leader {
  bool get isElected => status == LeaderStatusType.elected;

  bool get canApply => applied == false;

  String get leaderMessage => message ?? '';
}
