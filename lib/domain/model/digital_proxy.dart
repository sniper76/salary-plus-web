import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'digital_proxy.g.dart';

@JsonSerializable()
class DigitalProxy {
  final String templateId;
  final String templateName;
  final String templateRole;
  final DateTime? targetStartDate;
  final DateTime? targetEndDate;

  const DigitalProxy({
    required this.templateId,
    required this.templateName,
    required this.templateRole,
    this.targetStartDate,
    this.targetEndDate,
  });

  factory DigitalProxy.fromJson(Map<String, dynamic> json) => _$DigitalProxyFromJson(json);

  Map<String, dynamic> toJson() => _$DigitalProxyToJson(this);
}

extension DigitalProxyExtension on DigitalProxy {
  bool get isReady => targetStartDate != null && targetStartDate?.toUtc().isAfter(DateTime.now()) == true;

  bool get isActive =>
      targetStartDate?.toUtc().isBefore(DateTime.now()) == true &&
      targetEndDate?.toUtc().isAfter(DateTime.now()) == true;

  bool get isEnded => targetEndDate?.toUtc().isBefore(DateTime.now()) == true;

  int get remainingDay {
    return targetEndDate?.toUtc().difference(DateTime.now()).inDays ?? -1;
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
