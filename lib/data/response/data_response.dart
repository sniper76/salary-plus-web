import 'package:act_cms/domain/model/paging.dart';
import 'package:act_cms/domain/model/searching.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class DataResponse<T> {
  final Paging? paging;
  final Searching? search;
  final T? data;

  const DataResponse({
    this.paging,
    this.search,
    this.data,
  });

  factory DataResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$DataResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$DataResponseToJson(this, toJsonT);
}
