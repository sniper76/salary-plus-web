import 'package:json_annotation/json_annotation.dart';

part 'badge_visibility.g.dart';

@JsonSerializable()
class BadgeVisibility {
  final String label;
  final bool isVisible;
  final String name;

  BadgeVisibility({
    required this.label,
    required this.isVisible,
    required this.name,
  });

  BadgeVisibility copyWith({bool? isVisible}) {
    return BadgeVisibility(label: this.label, isVisible: isVisible ?? this.isVisible, name: this.name);
  }

  factory BadgeVisibility.fromJson(Map<String, dynamic> json) => _$BadgeVisibilityFromJson(json);

  Map<String, dynamic> toJson() => _$BadgeVisibilityToJson(this);

  @override
  List<Object?> get props => [isVisible, label];
}
