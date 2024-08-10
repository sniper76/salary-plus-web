import 'package:act_cms/core/util/json_utils.dart';
import 'package:act_cms/domain/model/digital_proxy.dart';
import 'package:json_annotation/json_annotation.dart';

part 'digital_proxy_result.g.dart';

@JsonSerializable()
class DigitalProxyResult {
  final String templateId;
  final String templateName;
  final String templateRole;
  @JsonKey(toJson: dateToJson)
  final DateTime startedAt;
  @JsonKey(toJson: dateToJson)
  final DateTime endedAt;

  const DigitalProxyResult({
    required this.templateId,
    required this.templateName,
    required this.templateRole,
    required this.startedAt,
    required this.endedAt,
  });

  factory DigitalProxyResult.fromModel(DigitalProxy digitalProxy) => DigitalProxyResult(
        templateId: digitalProxy.templateId,
        templateName: digitalProxy.templateName,
        templateRole: digitalProxy.templateRole,
        startedAt: digitalProxy.targetStartDate ?? DateTime.now(),
        endedAt: digitalProxy.targetEndDate ?? DateTime.now(),
      );

  Map<String, dynamic> toJson() => _$DigitalProxyResultToJson(this);
}
