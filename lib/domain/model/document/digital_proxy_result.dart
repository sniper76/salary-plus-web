import 'package:act_web/domain/model/document/document.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'digital_proxy_result.freezed.dart';

@freezed
class DigitalProxyResult with _$DigitalProxyResult {
  const DigitalProxyResult._();

  const factory DigitalProxyResult({
    required int templateId,
    required String templateName,
    required String templateRole,
    required DateTime startedAt,
    required DateTime endedAt,
  }) = _DigitalProxyResult;

  factory DigitalProxyResult.fromModel(DigitalProxy digitalProxy) => DigitalProxyResult(
        templateId: digitalProxy.templateId,
        templateName: digitalProxy.templateName,
        templateRole: digitalProxy.templateRole,
        startedAt: digitalProxy.targetStartDate ?? DateTime.now(),
        endedAt: digitalProxy.targetEndDate ?? DateTime.now(),
      );
}

extension DigitalProxyResultExtension on DigitalProxyResult {
  Map<String, dynamic> toCreateJson() {
    final data = {
      'templateId': templateId,
      'templateName': templateName,
      'templateRole': templateRole,
      'targetStartDate': startedAt.toUtc().toIso8601String(),
      'targetEndDate': endedAt.toUtc().toIso8601String(),
    };
    return data;
  }
}
