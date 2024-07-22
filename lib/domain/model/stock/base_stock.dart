import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_stock.freezed.dart';
part 'base_stock.g.dart';

@freezed
class BaseStock with _$BaseStock {
  const BaseStock._();

  const factory BaseStock({
    required String code,
    required String name,
    String? standardCode,
  }) = _BaseStock;

  factory BaseStock.fromJson(Map<String, dynamic> json) => _$BaseStockFromJson(json);
}

extension BaseStockExtension on BaseStock {
  String get logoUrl => 'https://cdn.deepsearch.com/company/logo/$code.png';
}
