import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'simple_board_group.g.dart';

@JsonSerializable()
class SimpleBoardGroup {
  final String name;
  final String displayName;
  final List<BoardGroupCategory> categories;

  const SimpleBoardGroup({
    required this.name,
    required this.displayName,
    required this.categories,
  });

  factory SimpleBoardGroup.fromJson(Map<String, dynamic> json) => _$SimpleBoardGroupFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleBoardGroupToJson(this);
}

// extension StockGroupExtention on StockGroup {
//   String get logoUrl =>
//       'https://cdn.deepsearch.com/company/logo/${this.code}.png';
// }
