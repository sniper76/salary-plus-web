import 'package:json_annotation/json_annotation.dart';

part 'user_stock_data.g.dart';

@JsonSerializable()
class UserStockData {
  final String code;
  final String name;
  final int quantity;
  final DateTime referenceDate;
  final DateTime registerDate;

  const UserStockData({
    required this.code,
    required this.name,
    required this.quantity,
    required this.referenceDate,
    required this.registerDate,
  });

  factory UserStockData.fromJson(Map<String, dynamic> json) => _$UserStockDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserStockDataToJson(this);
}

// extension StockGroupExtention on StockGroup {
//   String get logoUrl =>
//       'https://cdn.deepsearch.com/company/logo/${this.code}.png';
// }
