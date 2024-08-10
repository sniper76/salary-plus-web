import 'package:act_cms/core/extension/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'variation.g.dart';

@JsonSerializable()
class Variation {
  final String text;
  @JsonKey(name: 'color')
  final String colorHex;

  const Variation({required this.text, required this.colorHex});

  factory Variation.fromJson(Map<String, dynamic> json) => _$VariationFromJson(json);

  Map<String, dynamic> toJson() => _$VariationToJson(this);
}

extension VariationExtension on Variation {
  Color get color => colorHex.toColor();
}
