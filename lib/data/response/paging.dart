import 'package:freezed_annotation/freezed_annotation.dart';

part 'paging.freezed.dart';
part 'paging.g.dart';

@freezed
class Paging with _$Paging {
  const Paging._();

  const factory Paging({
    @Default(0) @JsonKey(name: 'totalElements') int total,
    @Default(1) @JsonKey(name: 'totalPages') int totalPage,
    required int size,
    required int page,
  }) = _Paging;

  factory Paging.initial() {
    return const Paging(
      total: 0,
      totalPage: 1,
      size: 10,
      page: 1,
    );
  }

  factory Paging.fromJson(Map<String, dynamic> json) => _$PagingFromJson(json);
}

extension PagingExtension on Paging {
  bool get endOfPage => total <= 0 || totalPage <= page;
}
