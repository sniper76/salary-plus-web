import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'paging.g.dart';

@JsonSerializable()
class Paging extends Equatable {
  @JsonKey(name: 'totalElements')
  final int total;
  @JsonKey(name: 'totalPages')
  final int totalPage;
  final int size;
  final int page;

  const Paging({
    this.total = 0,
    this.totalPage = 1,
    this.size = apiLoadSize,
    this.page = 1,
  });

  factory Paging.fromJson(Map<String, dynamic> json) => _$PagingFromJson(json);

  Map<String, dynamic> toJson() => _$PagingToJson(this);

  @override
  String toString() {
    return 'Paging(total: $total, totalPage: $totalPage, size: $size, page: $page)';
  }

  Paging copyWith({
    final int? total,
    final int? totalPage,
    final int? size,
    final int? page,
  }) {
    return Paging(
      total: total ?? this.total,
      totalPage: totalPage ?? this.totalPage,
      size: size ?? this.size,
      page: page ?? this.page,
    );
  }

  @override
  List<Object?> get props => [total, totalPage, size, page];
}

extension PagingExtension on Paging {
  bool get endOfPage => total <= 0 || totalPage <= page;
}
