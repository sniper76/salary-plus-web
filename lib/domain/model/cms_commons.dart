import 'package:act_cms/domain/model/simple_board_group.dart';
import 'package:act_cms/domain/model/simple_stock.dart';
import 'package:act_cms/domain/model/simple_stock_group.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cms_commons.g.dart';

@JsonSerializable()
class CMSCommons {
  final List<SimpleStock> stocks;
  final List<SimpleStockGroup> stockGroups;
  final List<SimpleBoardGroup> boardGroups;

  const CMSCommons({
    required this.stocks,
    required this.stockGroups,
    required this.boardGroups,
  });

  CMSCommons copyWith({List<SimpleStockGroup>? stockGroups}) {
    return CMSCommons(stocks: stocks, boardGroups: boardGroups, stockGroups: stockGroups ?? this.stockGroups);
  }

  factory CMSCommons.fromJson(Map<String, dynamic> json) => _$CMSCommonsFromJson(json);

  Map<String, dynamic> toJson() => _$CMSCommonsToJson(this);
}
