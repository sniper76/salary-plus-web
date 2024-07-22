import 'dart:ui';

import 'package:act_web/core/extension/string_extension.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'variation.freezed.dart';
part 'variation.g.dart';

@freezed
class Variation with _$Variation {
  const Variation._();

  const factory Variation({
    required String text,
    @JsonKey(name: 'color') required String colorHex,
  }) = _Variation;

  factory Variation.fromJson(Map<String, dynamic> json) => _$VariationFromJson(json);
}

extension VariationExtension on Variation {
  Color get color => colorHex.toColor();
}
