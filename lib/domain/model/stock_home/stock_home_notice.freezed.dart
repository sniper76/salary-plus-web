// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_home_notice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StockHomeNotice _$StockHomeNoticeFromJson(Map<String, dynamic> json) {
  return _StockHomeNotice.fromJson(json);
}

/// @nodoc
mixin _$StockHomeNotice {
  NoticeLevel get noticeLevel => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StockHomeNoticeCopyWith<StockHomeNotice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StockHomeNoticeCopyWith<$Res> {
  factory $StockHomeNoticeCopyWith(
          StockHomeNotice value, $Res Function(StockHomeNotice) then) =
      _$StockHomeNoticeCopyWithImpl<$Res, StockHomeNotice>;
  @useResult
  $Res call({NoticeLevel noticeLevel, String message});
}

/// @nodoc
class _$StockHomeNoticeCopyWithImpl<$Res, $Val extends StockHomeNotice>
    implements $StockHomeNoticeCopyWith<$Res> {
  _$StockHomeNoticeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? noticeLevel = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      noticeLevel: null == noticeLevel
          ? _value.noticeLevel
          : noticeLevel // ignore: cast_nullable_to_non_nullable
              as NoticeLevel,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StockHomeNoticeImplCopyWith<$Res>
    implements $StockHomeNoticeCopyWith<$Res> {
  factory _$$StockHomeNoticeImplCopyWith(_$StockHomeNoticeImpl value,
          $Res Function(_$StockHomeNoticeImpl) then) =
      __$$StockHomeNoticeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({NoticeLevel noticeLevel, String message});
}

/// @nodoc
class __$$StockHomeNoticeImplCopyWithImpl<$Res>
    extends _$StockHomeNoticeCopyWithImpl<$Res, _$StockHomeNoticeImpl>
    implements _$$StockHomeNoticeImplCopyWith<$Res> {
  __$$StockHomeNoticeImplCopyWithImpl(
      _$StockHomeNoticeImpl _value, $Res Function(_$StockHomeNoticeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? noticeLevel = null,
    Object? message = null,
  }) {
    return _then(_$StockHomeNoticeImpl(
      noticeLevel: null == noticeLevel
          ? _value.noticeLevel
          : noticeLevel // ignore: cast_nullable_to_non_nullable
              as NoticeLevel,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StockHomeNoticeImpl implements _StockHomeNotice {
  const _$StockHomeNoticeImpl(
      {required this.noticeLevel, required this.message});

  factory _$StockHomeNoticeImpl.fromJson(Map<String, dynamic> json) =>
      _$$StockHomeNoticeImplFromJson(json);

  @override
  final NoticeLevel noticeLevel;
  @override
  final String message;

  @override
  String toString() {
    return 'StockHomeNotice(noticeLevel: $noticeLevel, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StockHomeNoticeImpl &&
            (identical(other.noticeLevel, noticeLevel) ||
                other.noticeLevel == noticeLevel) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, noticeLevel, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StockHomeNoticeImplCopyWith<_$StockHomeNoticeImpl> get copyWith =>
      __$$StockHomeNoticeImplCopyWithImpl<_$StockHomeNoticeImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StockHomeNoticeImplToJson(
      this,
    );
  }
}

abstract class _StockHomeNotice implements StockHomeNotice {
  const factory _StockHomeNotice(
      {required final NoticeLevel noticeLevel,
      required final String message}) = _$StockHomeNoticeImpl;

  factory _StockHomeNotice.fromJson(Map<String, dynamic> json) =
      _$StockHomeNoticeImpl.fromJson;

  @override
  NoticeLevel get noticeLevel;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$StockHomeNoticeImplCopyWith<_$StockHomeNoticeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
