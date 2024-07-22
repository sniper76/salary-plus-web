import 'package:act_web/domain/model/stock/solidarity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock.freezed.dart';
part 'stock.g.dart';

@freezed
class Stock with _$Stock {
  const factory Stock({
    required String name,
    required String code,
    int? quantity,
    int? displayOrder,
    Solidarity? solidarity,
  }) = _Stock;

  factory Stock.fromJson(Map<String, dynamic> json) => _$StockFromJson(json);
}
