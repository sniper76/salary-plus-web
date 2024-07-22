// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paging.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Paging _$PagingFromJson(Map<String, dynamic> json) {
  return _Paging.fromJson(json);
}

/// @nodoc
mixin _$Paging {
  @JsonKey(name: 'totalElements')
  int get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'totalPages')
  int get totalPage => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PagingCopyWith<Paging> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PagingCopyWith<$Res> {
  factory $PagingCopyWith(Paging value, $Res Function(Paging) then) =
      _$PagingCopyWithImpl<$Res, Paging>;
  @useResult
  $Res call(
      {@JsonKey(name: 'totalElements') int total,
      @JsonKey(name: 'totalPages') int totalPage,
      int size,
      int page});
}

/// @nodoc
class _$PagingCopyWithImpl<$Res, $Val extends Paging>
    implements $PagingCopyWith<$Res> {
  _$PagingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? totalPage = null,
    Object? size = null,
    Object? page = null,
  }) {
    return _then(_value.copyWith(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      totalPage: null == totalPage
          ? _value.totalPage
          : totalPage // ignore: cast_nullable_to_non_nullable
              as int,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PagingImplCopyWith<$Res> implements $PagingCopyWith<$Res> {
  factory _$$PagingImplCopyWith(
          _$PagingImpl value, $Res Function(_$PagingImpl) then) =
      __$$PagingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'totalElements') int total,
      @JsonKey(name: 'totalPages') int totalPage,
      int size,
      int page});
}

/// @nodoc
class __$$PagingImplCopyWithImpl<$Res>
    extends _$PagingCopyWithImpl<$Res, _$PagingImpl>
    implements _$$PagingImplCopyWith<$Res> {
  __$$PagingImplCopyWithImpl(
      _$PagingImpl _value, $Res Function(_$PagingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? totalPage = null,
    Object? size = null,
    Object? page = null,
  }) {
    return _then(_$PagingImpl(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      totalPage: null == totalPage
          ? _value.totalPage
          : totalPage // ignore: cast_nullable_to_non_nullable
              as int,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PagingImpl extends _Paging {
  const _$PagingImpl(
      {@JsonKey(name: 'totalElements') this.total = 0,
      @JsonKey(name: 'totalPages') this.totalPage = 1,
      required this.size,
      required this.page})
      : super._();

  factory _$PagingImpl.fromJson(Map<String, dynamic> json) =>
      _$$PagingImplFromJson(json);

  @override
  @JsonKey(name: 'totalElements')
  final int total;
  @override
  @JsonKey(name: 'totalPages')
  final int totalPage;
  @override
  final int size;
  @override
  final int page;

  @override
  String toString() {
    return 'Paging(total: $total, totalPage: $totalPage, size: $size, page: $page)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PagingImpl &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.totalPage, totalPage) ||
                other.totalPage == totalPage) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.page, page) || other.page == page));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, total, totalPage, size, page);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PagingImplCopyWith<_$PagingImpl> get copyWith =>
      __$$PagingImplCopyWithImpl<_$PagingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PagingImplToJson(
      this,
    );
  }
}

abstract class _Paging extends Paging {
  const factory _Paging(
      {@JsonKey(name: 'totalElements') final int total,
      @JsonKey(name: 'totalPages') final int totalPage,
      required final int size,
      required final int page}) = _$PagingImpl;
  const _Paging._() : super._();

  factory _Paging.fromJson(Map<String, dynamic> json) = _$PagingImpl.fromJson;

  @override
  @JsonKey(name: 'totalElements')
  int get total;
  @override
  @JsonKey(name: 'totalPages')
  int get totalPage;
  @override
  int get size;
  @override
  int get page;
  @override
  @JsonKey(ignore: true)
  _$$PagingImplCopyWith<_$PagingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
